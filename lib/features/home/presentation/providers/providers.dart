import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/repositories/user_repository_interface_implementation.dart';
import '../../domain/repositories/user_repository_interface.dart';
import '../../domain/use_cases/user_data_use_case.dart';

final userRepositoryInterfaceProvider = Provider<UserRepositoryInterface>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return UserRepositoryInterfaceImplementation(apiClient);
});
// USE CASE PROVIDERS
final userDataUseCaseProvider = Provider<UserDataUseCase>(
  (ref) => UserDataUseCase(
    userRepositoryInterface: ref.watch(userRepositoryInterfaceProvider),
  ),
);
