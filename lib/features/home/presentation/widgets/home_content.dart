import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:move/features/home/presentation/widgets/app_drawer.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../../../../common/widgets/generic_error_screen.dart';
import '../providers/user_state_notifier_provider.dart';
import '../../../../utils/utils.dart';
import '../../../auth/presentation/providers/login_state_notifier_provider.dart';
import '../providers/create_profile_state_notifier_provider.dart';
import 'inputs.dart';

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
              Container(
                margin: const EdgeInsets.only(top: 250),
                child: Text(
                  'Welcome back, $name!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
                ),
              ),
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
