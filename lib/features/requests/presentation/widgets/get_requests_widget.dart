import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/home/presentation/widgets/app_drawer.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../../../../common/widgets/generic_error_screen.dart';
import '../providers/get_requests_state_notifier_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../map/presentation/screens/map_input.dart';
import '../screens/track_request_screen.dart';
import './row_details.dart';

class GetRequestsWidget extends ConsumerStatefulWidget {
  const GetRequestsWidget({super.key});

  @override
  ConsumerState<GetRequestsWidget> createState() => _GetRequestsWidgetState();
}

class _GetRequestsWidgetState extends ConsumerState<GetRequestsWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final estados = ['Open', 'Accepted', 'Finished'];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: estados.length, vsync: this);
    Future.microtask(() {
      ref
          .read(getRequestsStateNotifierProvider.notifier)
          .getRequests(estados[0]);
    });

    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      final estado = estados[tabController.index];
      ref.read(getRequestsStateNotifierProvider.notifier).getRequests(estado);
    });
  }

  void onRetry() {
    final estadoActual = estados[tabController.index];
    ref
        .read(getRequestsStateNotifierProvider.notifier)
        .getRequests(estadoActual);
  }

  @override
  Widget build(BuildContext context) {
    final requestState = ref.watch(getRequestsStateNotifierProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    return requestState.when(
      data: (requests) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.go(MapInputScreen.path);
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ),
          drawer: AppDrawer(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 249, 247, 247),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final requestIndex = requests[index];
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Request details',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          buildDetailRow('ID', id.toString()),
                                          buildDetailRow(
                                            'Date',
                                            DateFormat('MM/dd/yyy').format(
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
                          SlidableAction(
                            onPressed: (context) {
                              context.pushNamed(
                                TrackRequestScreen.name,
                                extra: id,
                              );
                            },
                            icon: Icons.location_on_outlined,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => GenericErrorScreen(onRetry: onRetry),
      loading: () => const LoaderWidget(),
    );
  }
}
