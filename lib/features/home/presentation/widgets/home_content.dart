import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:move/features/home/presentation/widgets/app_drawer.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../../../../common/widgets/generic_error_screen.dart';
import '../providers/user_state_notifier_provider.dart';
import '../../../../utils/utils.dart';
import '../../../auth/presentation/providers/login_state_notifier_provider.dart';
import '../providers/create_profile_state_notifier_provider.dart';
import 'inputs.dart';
import '../../../requests/presentation/providers/get_requests_state_notifier_provider.dart';
import '../../../requests/presentation/screens/get_requests_screen.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userId =
          ref
              .read(loginStateNotifierProvider.notifier)
              .authResponseModel
              ?.result
              ?.userId;
      if (userId != null) {
        ref.read(userStateNotifierProvider.notifier).getUserData(userId!);
      }
    });
    Future.microtask(() {
      ref
          .read(getRequestsStateNotifierProvider.notifier)
          .getRequests('Accepted');
    });
  }

  void onRetry() {
    if (userId != null) {
      ref.read(userStateNotifierProvider.notifier).getUserData(userId!);
    }
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

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateNotifierProvider);
    final requestState = ref.watch(getRequestsStateNotifierProvider);
    final requests = requestState.value ?? [];

    return userState.when(
      data: (user) {
        final name =
            ref
                .read(userStateNotifierProvider.notifier)
                .userResponseModel
                ?.name ??
            '';
        final surname =
            ref
                .read(userStateNotifierProvider.notifier)
                .userResponseModel
                ?.surname ??
            '';
        return Scaffold(
          appBar: AppBar(),
          drawer: AppDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Welcome back, $name!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
              ),

              SizedBox(height: 20),
              if (requests.isNotEmpty) ...[
                GestureDetector(
                  onTap: () => context.pushNamed(GetRequestsScreen.name),
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        final date = request!.fechaViaje;
                        final id = request.id;
                        DateTime dateTime = DateTime.parse(date.toString());
                        String requestDate = DateFormat(
                          'dd/MM/yyyy',
                        ).format(dateTime);
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ID: $id',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      requestDate,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                //SizedBox(height: 8),
                                Text(
                                  'Origin: ${request.calleDesde} ${request.numeroDesde}',
                                ),
                                Text(
                                  'Destination: ${request.calleHasta} ${request.numeroHasta}',
                                ),
                                SizedBox(height: 8),

                                // Status
                                Text(
                                  'Status: ${request.estado}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ] else ...[
                const Center(
                  child: Text('You currently have no accepted requests'),
                ),
              ],

              SizedBox(height: 20),
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

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: appImage(AppAssets.loginJeet),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, _) => GenericErrorScreen(onRetry: onRetry),
      loading: () => const LoaderWidget(),
    );
  }
}
