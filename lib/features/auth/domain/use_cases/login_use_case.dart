import 'package:fpdart/fpdart.dart';
import 'package:move/config/api_exception.dart';
import 'package:move/features/auth/data/models/auth_response_model.dart';
import 'package:move/features/auth/domain/repositories/auth_repository_interface.dart';

class LoginUseCase {
  final AuthRepositoryInterface authRepositoryInterface;

  LoginUseCase({required this.authRepositoryInterface});

  Future<Either<ApiException, AuthResponseModel?>> call(
    String user,
    String password,
  ) async {
    return authRepositoryInterface.login(user, password);
  }
}
