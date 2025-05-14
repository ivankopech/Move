import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/user_response_model.dart';
import '../repositories/user_repository_interface.dart';

class UserDataUseCase {
  final UserRepositoryInterface userRepositoryInterface;

  UserDataUseCase({required this.userRepositoryInterface});

  Future<Either<ApiException, UserResponseModel?>> call(int id) async {
    return userRepositoryInterface.getUserData(id);
  }
}
