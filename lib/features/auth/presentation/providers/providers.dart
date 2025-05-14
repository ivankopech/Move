// REPOSITORY PROVIDERS
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/repositories/auth_repository_interface_implementation.dart';
import '../../domain/repositories/auth_repository_interface.dart';
import '../../domain/use_cases/login_use_case.dart';

final authRepositoryInterfaceProvider = Provider<AuthRepositoryInterface>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return AuthRepositoryInterfaceImplementation(apiClient);
});
// USE CASE PROVIDERS
final loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(
    authRepositoryInterface: ref.watch(authRepositoryInterfaceProvider),
  ),
);
