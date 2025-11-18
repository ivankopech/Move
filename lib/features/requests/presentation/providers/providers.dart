import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/requests/domain/repositories/set_tip_repository_interface.dart';
import 'package:move/features/requests/domain/use_cases/set_tip_data_use_case.dart';
import '../../../../config/api_client_provider.dart';
import '../../data/repositories/get_request_repository_interface_implementation.dart';
import '../../data/repositories/set_tip_repository_interface_implementation.dart';
import '../../domain/repositories/get_requests_repository_interface.dart';
import '../../domain/use_cases/get_requests_data_use_case.dart';
import '../../data/repositories/get_tracking_repository_interface_implementation.dart';
import '../../domain/repositories/get_tracking_repository_interface.dart';
import '../../domain/use_cases/get_tracking_data_use_case.dart';

final getRequestsRepositoryInterfaceProvider =
    Provider<GetRequestsRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return GetRequestRepositoryInterfaceImplementation(apiClient);
    });

//USE CASE PROVIDER
final getRequestsDataUseCaseProvider = Provider<GetRequestsDataUseCase>(
  (ref) => GetRequestsDataUseCase(
    getRequestsRepositoryInterface: ref.watch(
      getRequestsRepositoryInterfaceProvider,
    ),
  ),
);

//SET TIP
final setTipRepositoryInterfaceProvider = Provider<SetTipRepositoryInterface>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return SetTipRepositoryInterfaceImplementation(apiClient);
});
// USE CASE PROVIDERS
final setTipUseCaseProvider = Provider<SetTipUseCase>(
  (ref) => SetTipUseCase(
    setTipRepositoryInterface: ref.watch(setTipRepositoryInterfaceProvider),
  ),
);

//GET TRACKING
final getTrackingRepositoryInterfaceProvider =
    Provider<GetTrackingRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return GetTrackingRepositoryInterfaceImplementation(apiClient);
    });

//USE CASE PROVIDER
final getTrackingDataUseCaseProvider = Provider<GetTrackingDataUseCase>(
  (ref) => GetTrackingDataUseCase(
    getTrackingRepositoryInterface: ref.watch(
      getTrackingRepositoryInterfaceProvider,
    ),
  ),
);
