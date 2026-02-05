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
  Future<Result<GetTrackingModelResponse>> trackRequest({
    required int id,
  }) async {
    try {
      final response = await apiClient.getData(
        'services/app/Solicitud/GetTracking/$id?maxResultCount=1',
        (json) {
          final resultJson = json['result'];
          if (resultJson is! Map<String, dynamic>) {
            return GetTrackingModelResponse(items: []);
          }
          return GetTrackingModelResponse.fromJson(resultJson);
        },
      );

      return response.fold((error) => Left(error), (data) => Right(data!));
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
