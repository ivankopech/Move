import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/auth_response_model.dart';
import '../providers/login_state_notifier_provider.dart';
import '../../../../utils/utils.dart';
import '../../../verification_code/providers/send_code_state_notifier_provider.dart';
import '../../../map/presentation/screens/map_input.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool isVerifying = false;
  bool showCodeField = false;
  String number = '';
  String code = '';

  Future<void> handleRequest() async {
    setState(() {
      isVerifying = true;
      number = numberController.text.trim();
    });
    if (number.isEmpty) return;

    try {
      await ref.read(sendCodeStateNotifierProvider.notifier).sendCode(number);
      setState(() => showCodeField = true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('An error ocurred')));
    } finally {
      setState(() => isVerifying = false);
    }
  }

  Future<void> handleLogin() async {
    setState(() {
      code = codeController.text.trim();
    });
    if (code.isEmpty) return;

    try {
      await ref.read(loginStateNotifierProvider.notifier).login(number, code);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthResponseModel?>>(loginStateNotifierProvider, (
      previous,
      next,
    ) {
      if (next is AsyncData && next.value != null) {
        context.go(MapInputScreen.path);
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              'Incorrect phone number or password. Try again',
            ),
          ),
        );
        return;
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: appPaddings.medium,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Log in to continue',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(width: 200, child: appImage(AppAssets.loginJeet)),
                  const SizedBox(height: 24),

                  // FORM SECTION
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: 'Enter your phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (showCodeField) ...[
                            TextField(
                              controller: codeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter verification code',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child:
                                isVerifying
                                    ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                    : ElevatedButton(
                                      onPressed:
                                          showCodeField
                                              ? handleLogin
                                              : handleRequest,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.indigo,
                                              Colors.purple,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                            minWidth: 100,
                                            minHeight: 60,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            showCodeField
                                                ? 'Log in'
                                                : 'Send code',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
