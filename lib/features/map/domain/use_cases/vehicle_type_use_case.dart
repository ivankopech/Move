import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/vehicle_type_repository_interface.dart';
import '../../data/models/vehicle_type.dart';

class VehicleTypeUseCase {
  final VehicleTypeRepositoryInterface vehicleTypeRepositoryInterface;

  VehicleTypeUseCase({required this.vehicleTypeRepositoryInterface});

  Future<Either<ApiException, List<VehicleTypeModel?>>> call() async {
    return vehicleTypeRepositoryInterface.getTypes();
  }
}
