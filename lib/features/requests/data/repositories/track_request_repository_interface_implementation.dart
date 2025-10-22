import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/track_request_model.dart';
import '../../domain/repositories/track_request_repository_interface.dart';

class TrackRequestRepositoryInterfaceImplementation
    extends TrackRequestRepositoryInterface {
  final ApiClient _apiClient;

  TrackRequestRepositoryInterfaceImplementation(this._apiClient);

  @override
  Future<Result<TrackRequestModel?>> trackRequest(int id) async {
    try {
      final response = await _apiClient.getData(
        'services/app/Solicitud/GetTracking/$id?skipCount=0&maxResultCount=100',
        (json) => TrackRequestModel.fromJson(json),
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
