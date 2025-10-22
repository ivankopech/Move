import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/config/api_client.dart';
import 'package:move/features/home/data/repositories/push_message_repository_interface_implementation.dart';
import 'package:move/features/home/domain/repositories/push_message_repository_interface.dart';
import 'package:move/features/home/domain/use_cases/push_message_use_case.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/repositories/user_repository_interface_implementation.dart';
import '../../domain/repositories/user_repository_interface.dart';
import '../../domain/use_cases/user_data_use_case.dart';
import '../../data/repositories/create_profile_repository_interface_implementation.dart';
import '../../domain/repositories/create_profile_repository_interface.dart';
import '../../domain/use_cases/create_profile_use_case.dart';
import '../../data/repositories/device_token_interface_implementation.dart';
import '../../domain/repositories/device_token_repository_interface.dart';
import '../../domain/use_cases/device_token_use_case.dart';

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

//DEVICE TOKEN
final registerDeviceTokenRepositoryInterfaceProvider =
    Provider<RegisterDeviceTokenRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return RegisterDeviceTokenInterfaceImplementation(apiClient);
    });

// USE CASE PROVIDERS
final registerDeviceTokenUseCaseProvider = Provider<RegisterDeviceTokenUseCase>(
  (ref) => RegisterDeviceTokenUseCase(
    registerDeviceTokenRepositoryInterface: ref.watch(
      registerDeviceTokenRepositoryInterfaceProvider,
    ),
  ),
);

//SEND PUSH MESSAGE
final sendPushMessageRepositoryProvider =
    Provider<SendPushMessageRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return SendPushMessageInterfaceImplementation(apiClient);
    });

// USE CASE PROVIDERS
final sendPushMessageUseCaseProvider = Provider<SendPushMessageUseCase>(
  (ref) => SendPushMessageUseCase(
    sendPushMessageRepositoryInterface: ref.watch(
      sendPushMessageRepositoryProvider,
    ),
  ),
);
