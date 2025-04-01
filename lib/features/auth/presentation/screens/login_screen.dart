import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:move/common/widgets/loader_widget.dart';
import 'package:move/config/api_exception.dart';
import 'package:move/features/auth/data/models/auth_response_model.dart';
import 'package:move/features/auth/presentation/providers/login_state_notifier_provider.dart';
import 'package:move/utils/utils.dart';

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
        context.go('/location-input');
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
                  const Text('Bienvenido!', style: TextStyle(fontSize: 30)),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    width: 200,
                    child: appImage(AppAssets.loginJheet),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.all(18),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                name: 'email',
                                decoration: InputDecoration(labelText: 'Email'),
                                textInputAction: TextInputAction.next,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              SizedBox(height: 16),
                              FormBuilderTextField(
                                name: 'password',
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                ),
                                validator: FormBuilderValidators.required(),
                              ),
                              SizedBox(height: 24),
                              if (authState is AsyncLoading) LoaderWidget(),
                              if (authState is AsyncData)
                                ElevatedButton(
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
                                  child: Text('Login'),
                                ),
                            ],
                          ),
                        ),
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
