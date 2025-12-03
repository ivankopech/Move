import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:move/features/home/presentation/widgets/app_drawer.dart';
import 'package:move/features/requests/data/models/get_requests_model.dart';
import '../../../../common/widgets/generic_error_screen.dart';
import '../providers/user_state_notifier_provider.dart';
import '../../../auth/presentation/providers/login_state_notifier_provider.dart';
import '../providers/create_profile_state_notifier_provider.dart';
import 'inputs.dart';
import '../../../requests/presentation/providers/get_requests_state_notifier_provider.dart';
import '../../../requests/presentation/screens/get_requests_screen.dart';
import '../../../map/presentation/screens/map_input.dart';
import './delivery_card.dart';
import 'package:flutter/services.dart';

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({super.key});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {
  int? userId;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  static const MethodChannel activityChannel = MethodChannel(
    'live_activity_channel',
  );
  late ProviderSubscription<AsyncValue<List<GetRequestsModel?>>> subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
      liveActivity();
    });
  }

  void onRetry() {
    if (userId != null) {
      ref.read(userStateNotifierProvider.notifier).getUserData(userId!);
      ref
          .read(getRequestsStateNotifierProvider.notifier)
          .getRequests(userId!, false);
    }
  }

  Future<void> loadData() async {
    if (!mounted) return;
    userId =
        ref
            .read(loginStateNotifierProvider.notifier)
            .authResponseModel
            ?.result
            ?.userId;
    if (userId != null) {
      ref.read(userStateNotifierProvider.notifier).getUserData(userId!);
      ref
          .read(getRequestsStateNotifierProvider.notifier)
          .getRequests(userId!, false);
    }
  }

  void liveActivity() {
    subscription = ref.listenManual(getRequestsStateNotifierProvider, (
      previous,
      next,
    ) async {
      if (!Platform.isIOS) return;

      final requests = next.value ?? [];

      final inProgress =
          requests
              .where(
                (r) => r?.estado == 'InProgress' && r!.tracking!.isNotEmpty,
              )
              .toList();

      if (inProgress.isNotEmpty) {
        final req = inProgress.first!;
        final destinationAddress =
            '${req.calleHasta ?? ''} ${req.numeroHasta ?? ''}';
        await startLiveActivity(id: req.id!, destination: destinationAddress);
      } else {
        await stopLiveActivity();
      }
    });
  }

  Widget showInputDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color(0xFFF3EDF7),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            buildTextField(
              controller: emailController,
              hint: 'Email',
              icon: Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 16),

            buildTextField(
              controller: nameController,
              hint: 'Name',
              icon: Icon(Icons.person_outline_rounded),
            ),
            const SizedBox(height: 16),

            buildTextField(
              controller: surnameController,
              hint: 'Surname',
              icon: Icon(Icons.person_outline_rounded),
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('Cancel', () {
                  Navigator.pop(context);
                  emailController.clear();
                  nameController.clear();
                  surnameController.clear();
                }),
                const SizedBox(width: 16),
                buildButton('Submit', () async {
                  await ref
                      .read(createProfileStateNotifierProvider.notifier)
                      .createProfile(
                        emailController.text,
                        nameController.text,
                        surnameController.text,
                      );
                  emailController.clear();
                  nameController.clear();
                  surnameController.clear();
                  context.pop();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRequestRow(
    BuildContext context, {
    required String title,
    required int? count,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLoading = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(icon, color: color),
              title: Text(title),
              trailing: CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child:
                    isLoading || count == null
                        ? CircularProgressIndicator()
                        : Text(
                          count.toString(),
                          style: TextStyle(color: color),
                        ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
          ),
          icon: Icon(Icons.remove_red_eye_sharp),
        ),
      ],
    );
  }

  Future<void> startLiveActivity({
    required int id,
    required String destination,
  }) async {
    if (!Platform.isIOS) return;
    try {
      await activityChannel.invokeMethod('startActivity', {
        'id': id,
        'destination': destination,
      });
    } catch (e) {
      debugPrint("Error starting activity: $e");
    }
  }

  Future<void> stopLiveActivity() async {
    if (!Platform.isIOS) return;
    try {
      await activityChannel.invokeMethod('stopActivity');
    } catch (e) {
      debugPrint("Error stopping activity: $e");
    }
  }

  int countByStatus(List<GetRequestsModel?> requests, String status) {
    return requests.where((r) => r?.estado == status).length;
  }

  List<GetRequestsModel> activeDeliveries(List<GetRequestsModel?> requests) {
    return requests
        .where(
          (r) => r?.estado == 'InProgress' && r?.tracking?.isNotEmpty == true,
        )
        .map((r) => r!)
        .toList();
  }

  @override
  void dispose() {
    subscription.close();
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestState = ref.watch(getRequestsStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),

      body: requestState.when(
        data: (requests) {
          final openCount = countByStatus(requests, 'Open');
          final acceptedCount = countByStatus(requests, 'Assigned');
          final finishedCount = countByStatus(requests, 'Finished');

          final activeList = activeDeliveries(requests);

          String name =
              ref
                  .read(userStateNotifierProvider.notifier)
                  .userResponseModel
                  ?.name ??
              '';
          String surname =
              ref
                  .read(userStateNotifierProvider.notifier)
                  .userResponseModel
                  ?.surname ??
              '';

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (name == surname) ...[
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => showInputDialog(),
                          );
                        },
                        child: Text(
                          'Press here to complete your personal information',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name == surname
                                  ? 'Welcome back! 👋'
                                  : 'Welcome back, $name! 👋',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Requests overview",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            context.pushReplacementNamed(MapInputScreen.name);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            foregroundColor: Colors.white,
                            shape: const CircleBorder(),
                          ),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    buildRequestRow(
                      context,
                      title: 'Requested',
                      count: openCount,
                      color: Colors.deepPurpleAccent,
                      icon: Icons.pending_actions_rounded,
                      onPressed:
                          () => context.pushNamed(
                            GetRequestsScreen.name,
                            extra: 0,
                          ),
                      isLoading: requestState.isLoading,
                    ),
                    const SizedBox(height: 10),
                    buildRequestRow(
                      context,
                      title: 'Accepted',
                      count: acceptedCount,
                      color: Colors.deepPurpleAccent,
                      icon: Icons.pending_actions_rounded,
                      onPressed:
                          () => context.pushNamed(
                            GetRequestsScreen.name,
                            extra: 1,
                          ),
                      isLoading: requestState.isLoading,
                    ),
                    const SizedBox(height: 10),
                    buildRequestRow(
                      context,
                      title: 'Finished',
                      count: finishedCount,
                      color: Colors.deepPurpleAccent,
                      icon: Icons.pending_actions_rounded,
                      onPressed:
                          () => context.pushNamed(
                            GetRequestsScreen.name,
                            extra: 2,
                          ),
                      isLoading: requestState.isLoading,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child:
                          activeList.isEmpty
                              ? SizedBox(
                                height: 300,
                                child: Center(
                                  child: Text(
                                    'You currently have no active deliveries...',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ),
                              )
                              : Column(
                                key: ValueKey(activeList.length),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Active deliveries',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ...activeList.map(
                                    (r) => DeliveryCard(requestModel: r),
                                  ),
                                ],
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, _) => GenericErrorScreen(onRetry: onRetry),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
