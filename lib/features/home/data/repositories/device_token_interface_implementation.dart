import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/device_token_model.dart';
import '../../domain/repositories/device_token_repository_interface.dart';

class RegisterDeviceTokenInterfaceImplementation
    extends RegisterDeviceTokenRepositoryInterface {
  final ApiClient apiClient;

  RegisterDeviceTokenInterfaceImplementation(this.apiClient);

  @override
  Future<Result<RegisterDeviceTokenModel?>> registerDeviceToken(
    String? apn,
    String? token,
  ) async {
    try {
      final body = {'platform': apn, 'deviceToken': token};

      final response = await apiClient.postData(
        'services/app/User/RegisterDeviceToken',
        body,
        (json) => RegisterDeviceTokenModel.fromJson(json),
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
