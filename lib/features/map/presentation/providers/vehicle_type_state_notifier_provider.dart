import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/vehicle_type.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/vehicle_type_state_notifier.dart';

final vehicleTypeStateNotifierProvider = StateNotifierProvider<
  VehicleTypeStateNotifier,
  AsyncValue<VehicleTypeModel?>
>((ref) {
  return VehicleTypeStateNotifier(
    vehicleTypeUseCase: ref.read(vehicleTypeUseCaseProvider),
  );
});
