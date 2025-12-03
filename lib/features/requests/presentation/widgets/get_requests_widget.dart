import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/home/presentation/widgets/app_drawer.dart';
import '../../../../common/widgets/generic_error_screen.dart';
import '../providers/get_requests_state_notifier_provider.dart';
import '../../../auth/presentation/providers/login_state_notifier_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './row_details.dart';

class GetRequestsWidget extends ConsumerStatefulWidget {
  final int initialIndex;
  const GetRequestsWidget({super.key, this.initialIndex = 0});

  @override
  ConsumerState<GetRequestsWidget> createState() => _GetRequestsWidgetState();
}

class _GetRequestsWidgetState extends ConsumerState<GetRequestsWidget>
    with SingleTickerProviderStateMixin {
  int? userId;
  late TabController tabController;

  final estados = ['Open', 'Assigned', 'Finished'];
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: estados.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    Future.microtask(() {
      userId =
          ref
              .read(loginStateNotifierProvider.notifier)
              .authResponseModel!
              .result!
              .userId;
      ref
          .read(getRequestsStateNotifierProvider.notifier)
          .getRequests(userId!, false);
    });

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  void onRetry() {
    final estadoActual = estados[tabController.index];
  }

  @override
  Widget build(BuildContext context) {
    final requestState = ref.watch(getRequestsStateNotifierProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      drawer: AppDrawer(),

      body: requestState.when(
        data: (requests) {
          final currentTab = tabController.index;
          final filteredRequests =
              requests.where((r) {
                if (r == null) return false;
                switch (currentTab) {
                  case 0:
                    return r.estado == 'Open';
                  case 1:
                    return r.estado == 'Assigned';
                  case 2:
                    return r.estado == 'Finished';
                  default:
                    return true;
                }
              }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    tabs: const [
                      Tab(text: 'Untaken'),
                      Tab(text: 'Accepted'),
                      Tab(text: 'Finished'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    filteredRequests.isEmpty
                        ? const Center(child: Text('No requests to show'))
                        : ListView.builder(
                          // shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredRequests.length,
                          itemBuilder: (context, index) {
                            final requestIndex = filteredRequests[index];
                            final date = requestIndex!.fechaViaje;
                            final id = requestIndex.id;
                            DateTime dateTime = DateTime.parse(date.toString());
                            String requestDate = DateFormat(
                              'dd/MM/yyyy',
                            ).format(dateTime);

                            return Slidable(
                              startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      228,
                                      174,
                                      94,
                                    ),
                                    icon: Icons.info_outline_rounded,
                                    onPressed: (ctx) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Request details',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  buildDetailRow(
                                                    'ID',
                                                    id.toString(),
                                                  ),
                                                  buildDetailRow(
                                                    'Date',
                                                    DateFormat(
                                                      'MM/dd/yyy',
                                                    ).format(
                                                      DateTime.parse(
                                                        requestIndex.fechaViaje
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                  buildDetailRow(
                                                    'Origin',
                                                    '${requestIndex.calleDesde} ${requestIndex.numeroDesde}',
                                                  ),
                                                  buildDetailRow(
                                                    'Destination',
                                                    '${requestIndex.calleHasta} ${requestIndex.numeroHasta}',
                                                  ),
                                                  buildDetailRow(
                                                    'Status',
                                                    '${requestIndex.estado}',
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                width: screenWidth,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 7,
                                  margin: const EdgeInsets.all(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ID: ${requestIndex.id.toString()} - Date: $requestDate',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Begin: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${requestIndex.calleDesde} ${requestIndex.numeroDesde}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'End: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${requestIndex.calleHasta} ${requestIndex.numeroHasta}',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => GenericErrorScreen(onRetry: onRetry),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
