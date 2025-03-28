import 'package:fpdart/fpdart.dart';
import 'package:move/config/api_client.dart';
import 'package:move/config/api_exception.dart';
import 'package:move/features/map/data/models/models.dart';
import 'package:move/features/map/domain/repositories/repositories.dart';

class SampleRepositoryInterfaceImplementation
    extends SampleRepositoryInterface {
  final ApiClient _apiClient;

  SampleRepositoryInterfaceImplementation(this._apiClient);

  @override
  Future<Result<SampleResponseModel?>> getData() async {
    try {
      final response = await _apiClient.getData(
        'customUrl',
        (json) => SampleResponseModel.fromJson(json),
      );

      return response.fold((error) => Left(error), (data) {
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
