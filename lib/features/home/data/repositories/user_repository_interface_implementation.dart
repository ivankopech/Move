import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/user_response_model.dart';
import '../../domain/repositories/user_repository_interface.dart';

class UserRepositoryInterfaceImplementation extends UserRepositoryInterface {
  final ApiClient _apiClient;

  UserRepositoryInterfaceImplementation(this._apiClient);

  @override
  Future<Result<UserResponseModel?>> getUserData(int id) async {
    try {
      final response = await _apiClient.getData(
        'services/app/User/Get?Id=$id',
        (json) => UserResponseModel.fromJson(json),
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
