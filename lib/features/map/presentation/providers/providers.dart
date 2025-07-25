import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/config/api_client_provider.dart';
import 'package:move/features/map/data/models/create_request.dart';
import 'package:move/features/map/data/repositories/repositories.dart';
import 'package:move/features/map/domain/repositories/repositories.dart';
import 'package:move/features/map/domain/repositories/vehicle_type_repository_interface.dart';
import 'package:move/features/map/domain/use_cases/use_cases.dart';
import 'package:move/features/map/presentation/providers/state/details_notifier.dart';
import 'package:move/features/map/presentation/providers/state/images_notifier.dart';
import '../../data/repositories/create_request_repository_interface_implementation.dart';
import '../../domain/repositories/create_request_repository_interface.dart';
import '../../domain/use_cases/create_request_use_case.dart';
import '../../data/repositories/vehicle_type_repository_interface_implementation.dart';
import '../../domain/repositories/vehicle_type_repository_interface.dart';
import '../../domain/use_cases/vehicle_type_use_case.dart';
import '../../data/models/request_info.dart';

// REPOSITORY PROVIDERS
final sampleRepositoryInterfaceProvider = Provider<SampleRepositoryInterface>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return SampleRepositoryInterfaceImplementation(apiClient);
});
// USE CASE PROVIDERS
final sampleUseCaseProvider = Provider<SampleUseCase>(
  (ref) => SampleUseCase(
    sampleRepositoryInterface: ref.watch(sampleRepositoryInterfaceProvider),
  ),
);

//CREATE REQUEST

final createRequestRepositoryInterfaceProvider =
    Provider<CreateRequestRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return CreateRequestRepositoryInterfaceImplementation(apiClient);
    });

// USE CASE PROVIDERS
final createRequestUseCaseProvider = Provider<CreateRequestUseCase>(
  (ref) => CreateRequestUseCase(
    createRequestRepositoryInterface: ref.watch(
      createRequestRepositoryInterfaceProvider,
    ),
  ),
);

//VEHICLE TYPE

final vehicleTypeRepositoryInterfaceProvider =
    Provider<VehicleTypeRepositoryInterface>((ref) {
      final apiClient = ref.read(apiClientProvider);
      return VehicleTypeRepositoryInterfaceImplementation(apiClient);
    });

// USE CASE PROVIDERS
final vehicleTypeUseCaseProvider = Provider<VehicleTypeUseCase>(
  (ref) => VehicleTypeUseCase(
    vehicleTypeRepositoryInterface: ref.watch(
      vehicleTypeRepositoryInterfaceProvider,
    ),
  ),
);

//PROVIDERS
final originAddressProvider = StateProvider<AddressModel?>((ref) => null);
final destinationAddressProvider = StateProvider<AddressModel?>((ref) => null);
final distanceProvider = StateProvider<Distance?>((ref) => null);
final vehicleProvider = StateProvider<int?>((ref) => null);
final imagesProvider = StateNotifierProvider<ImagesNotifier, ImagesModel>((
  ref,
) {
  return ImagesNotifier();
});
final detailsProvider = StateNotifierProvider<DetailsNotifier, DetailsModel>((
  ref,
) {
  return DetailsNotifier();
});
