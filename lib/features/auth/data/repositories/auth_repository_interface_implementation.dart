import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../../../../config/secure_storage.dart';
import '../../data/models/auth_response_model.dart';
import '../../domain/repositories/auth_repository_interface.dart';

class AuthRepositoryInterfaceImplementation extends AuthRepositoryInterface {
  final ApiClient _apiClient;
  final SecureStorageManager _secureStorage;

  AuthRepositoryInterfaceImplementation(
    this._apiClient, {
    SecureStorageManager? secureStorage,
  }) : _secureStorage = secureStorage ?? SecureStorageManager();

  @override
  Future<Result<AuthResponseModel?>> login(String number, String code) async {
    try {
      final body = {"phoneNumber": number, "otp": code};

      final response = await _apiClient.postData(
        'TokenAuth/ValidateOtp',
        body,
        (json) => AuthResponseModel.fromJson(json),
      );

      return response.fold((error) => Left(error), (data) async {
        if (data != null && data.result != null) {
          final token = data.result!.accessToken;

          await _secureStorage.writeToken(token);

          return Right(data);
        } else {
          return const Left(
            ApiException(message: 'Respuesta de inicio de sesión inválida'),
          );
        }
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
