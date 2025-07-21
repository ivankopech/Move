import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/vehicle_type.dart';
import '../../domain/repositories/vehicle_type_repository_interface.dart';

class VehicleTypeRepositoryInterfaceImplementation
    extends VehicleTypeRepositoryInterface {
  final ApiClient apiClient;

  VehicleTypeRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<VehicleTypeModel?>> getTypes() async {
    try {
      final response = await apiClient.postData(
        'services/app/Pricing/ListVehicleTypePrice',
        {},
        (json) => VehicleTypeModel.fromJson(json),
      );
      return response.fold((error) => Left(error), (data) async {
        return Right(data);
      });
    } catch (e, stackTrace) {
      return Left(
        ApiException(
          code: '500',
          message: 'Error inesperado: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
