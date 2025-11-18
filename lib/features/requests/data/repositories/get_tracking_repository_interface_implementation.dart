import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/get_tracking_model.dart';
import '../../domain/repositories/get_tracking_repository_interface.dart';

class GetTrackingRepositoryInterfaceImplementation
    extends GetTrackingRepositoryInterface {
  final ApiClient apiClient;

  GetTrackingRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<List<GetTrackingModel?>>> trackRequest({
    required int id,
  }) async {
    try {
      final response = await apiClient.getData(
        'services/app/Solicitud/GetTracking/$id?maxResultCount=100',
        (json) {
          final result = GetTrackingModelResponse.fromJson(json);
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
