import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/auth_response_model.dart';
import '../providers/login_state_notifier_provider.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../../utils/utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const String path = '/login';
  static const String name = 'login';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<AuthResponseModel?>>(loginStateNotifierProvider, (
      previous,
      next,
    ) {
      if (next is AsyncData && next.value != null) {
        context.go(HomeScreen.path);
      }
      if (next is AsyncError) {
        // final error = next.error;
        // if (error is ApiException && error.data != null) {
        //   final errorData = error.data!;
        //   errorMessageDetail = errorData['detail'] ?? '';
        // } else {
        //   print('Error: ${error?.toString()}');
        // }
      }
    });
    final authState = ref.watch(loginStateNotifierProvider);
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
                    'Inicia sesión para continuar',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(width: 200, child: appImage(AppAssets.loginJheet)),
                  const SizedBox(height: 24),

                  // FORM SECTION
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF3FA),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: appColors.primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            name: 'email',
                            decoration: AppInputStyles.inputDecoration(
                              label: 'Email',
                              hintText: 'ejemplo@correo.com',
                              prefixIcon: const Icon(Icons.email),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              // FormBuilderValidators.email(),
                            ]),
                          ),
                          const SizedBox(height: 16),
                          FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            decoration: AppInputStyles.inputDecoration(
                              label: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            validator: FormBuilderValidators.required(),
                          ),
                          const SizedBox(height: 24),
                          authState is AsyncLoading
                              ? const LoaderWidget()
                              : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: AppButtonStyles.primaryButton,
                                  onPressed: () async {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      final formData =
                                          _formKey.currentState!.value;
                                      final email = formData['email'];
                                      final password = formData['password'];
                                      await ref
                                          .read(
                                            loginStateNotifierProvider.notifier,
                                          )
                                          .login(email, password);
                                    }
                                  },
                                  child: const Text("Login"),
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
