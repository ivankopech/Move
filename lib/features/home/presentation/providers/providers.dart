import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/repositories/user_repository_interface_implementation.dart';
import '../../domain/repositories/user_repository_interface.dart';
import '../../domain/use_cases/user_data_use_case.dart';
import '../../data/repositories/create_profile_repository_interface_implementation.dart';
import '../../domain/repositories/create_profile_repository_interface.dart';
import '../../domain/use_cases/create_profile_use_case.dart';

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

//CREATE PROFILE
final createProfileRepositoryInterfaceProvider =
    Provider<CreateProfileRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return CreateProfileRepositoryInterfaceImplementation(apiClient);
    });
// USE CASE PROVIDERS
final createProfileUseCaseProvider = Provider<CreateProfileUseCase>(
  (ref) => CreateProfileUseCase(
    createProfileRepositoryInterface: ref.watch(
      createProfileRepositoryInterfaceProvider,
    ),
  ),
);
