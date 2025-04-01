import 'package:fpdart/fpdart.dart';
import 'package:move/config/api_client.dart';
import 'package:move/config/api_exception.dart';
import 'package:move/config/secure_storage.dart'; // Importa SecureStorageManager
import 'package:move/features/auth/data/models/auth_response_model.dart';
import 'package:move/features/auth/domain/repositories/auth_repository_interface.dart';

class AuthRepositoryInterfaceImplementation extends AuthRepositoryInterface {
  final ApiClient _apiClient;
  final SecureStorageManager _secureStorage;

  AuthRepositoryInterfaceImplementation(
    this._apiClient, {
    SecureStorageManager? secureStorage,
  }) : _secureStorage = secureStorage ?? SecureStorageManager();

  @override
  Future<Result<AuthResponseModel?>> login(String user, String password) async {
    try {
      final body = {"userNameOrEmailAddress": user, "password": password};

      final response = await _apiClient.postData(
        'TokenAuth/Authenticate',
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
