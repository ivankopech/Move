import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/track_request_model.dart';
import '../../domain/repositories/track_request_repository_interface.dart';

class TrackRequestRepositoryInterfaceImplementation
    extends TrackRequestRepositoryInterface {
  final ApiClient apiClient;

  TrackRequestRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<TrackRequestModel?>> trackRequest(int id) async {
    try {
      final response = await apiClient.getData(
        'services/app/Solicitud/GetTracking?serviceId=$id&skipCount=0&maxResultCount=1',
        (json) => TrackRequestModel.fromJson(json),
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
