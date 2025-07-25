import '../../../../config/api_client.dart';
import '../../data/models/vehicle_type.dart';

abstract class VehicleTypeRepositoryInterface {
  Future<Result<List<VehicleTypeModel?>>> getTypes();
}
