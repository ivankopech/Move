import 'package:flutter/foundation.dart';
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
    if (number.isEmpty) {
      setState(() => isVerifying = false);
      return;
    }

    try {
      debugPrint('Sending code to: $number');
      await ref.read(sendCodeStateNotifierProvider.notifier).sendCode(number);
      debugPrint('Code sent successfully');
      if (mounted) {
        setState(() => showCodeField = true);
      }
    } catch (e, stackTrace) {
      debugPrint('Error sending code: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('An error occurred: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() => isVerifying = false);
      }
    }
  }

  Future<void> handleLogin() async {
    setState(() {
      isVerifying = true;
      code = codeController.text.trim();
    });
    if (code.isEmpty) {
      setState(() => isVerifying = false);
      return;
    }

    try {
      debugPrint('Attempting login with number: $number and code: ${code.substring(0, 2)}***');
      await ref.read(loginStateNotifierProvider.notifier).login(number, code);
      debugPrint('Login successful');
    } catch (e, stackTrace) {
      debugPrint('Error during login: $e');
      debugPrint('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Login failed: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isVerifying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthResponseModel?>>(loginStateNotifierProvider, (
      previous,
      next,
    ) {
      debugPrint('Login state changed: ${next.runtimeType}');
      if (!mounted) return;
      
      if (next is AsyncData && next.value != null) {
        debugPrint('Login successful, navigating to map');
        context.go(MapInputScreen.path);
      }
      if (next is AsyncError) {
        debugPrint('Login error: ${next.error}');
        if (mounted) {
          setState(() => isVerifying = false);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Incorrect phone number or password. Try again\nError: ${next.error}',
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
                          if (kDebugMode)
                            ElevatedButton(
                              onPressed: () async {
                                await ref
                                    .read(loginStateNotifierProvider.notifier)
                                    .login('+3416381219', '463463');
                              },
                              child: Text('Fast Login'),
                            ),
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
