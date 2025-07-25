import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/vehicle_type.dart';
import '../../../domain/use_cases/vehicle_type_use_case.dart';

class VehicleTypeStateNotifier
    extends StateNotifier<AsyncValue<List<VehicleTypeModel?>>> {
  final VehicleTypeUseCase vehicleTypeUseCase;

  VehicleTypeStateNotifier({required this.vehicleTypeUseCase})
    : super(const AsyncValue.loading());

  late List<VehicleTypeModel?> vehicleTypeModelList;

  Future<void> getTypes() async {
    try {
      state = AsyncValue.loading();
      final result = await vehicleTypeUseCase();

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          vehicleTypeModelList = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
