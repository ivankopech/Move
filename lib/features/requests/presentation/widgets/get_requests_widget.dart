import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../providers/get_requests_state_notifier_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../map/presentation/screens/map_input.dart';

class GetRequestsWidget extends ConsumerStatefulWidget {
  const GetRequestsWidget({super.key});

  @override
  ConsumerState<GetRequestsWidget> createState() => _GetRequestsWidgetState();
}

class _GetRequestsWidgetState extends ConsumerState<GetRequestsWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getRequestsStateNotifierProvider.notifier).getRequests();
    });
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final requestIndex = requests[index];
                    final date = requestIndex!.fechaViaje;
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
                            onPressed: (ctx) async {},
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
      error:
          (error, stackTrace) =>
              const Center(child: Text('Error loading requests')),
      loading: () => const LoaderWidget(),
    );
  }
}
