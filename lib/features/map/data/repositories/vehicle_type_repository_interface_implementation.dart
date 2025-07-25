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
  Future<Result<List<VehicleTypeModel?>>> getTypes() async {
    try {
      final response = await apiClient.postData(
        'services/app/Pricing/ListVehicleTypePrice',
        {},
        (json) {
          final result = VehicleTypeModelResponse.fromJson(json);
          var list = result.items;
          return list ?? [];
        },
      );
      return response.fold((error) => Left(error), (data) async {
        return Right(data!);
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
