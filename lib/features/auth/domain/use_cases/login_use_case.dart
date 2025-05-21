import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/auth_response_model.dart';
import '../../domain/repositories/auth_repository_interface.dart';

class LoginUseCase {
  final AuthRepositoryInterface authRepositoryInterface;

  LoginUseCase({required this.authRepositoryInterface});

  Future<Either<ApiException, AuthResponseModel?>> call(
    String number,
    String code,
  ) async {
    return authRepositoryInterface.login(number, code);
  }
}
