import '../../../../config/api_client.dart';
import '../../data/models/user_response_model.dart';

abstract class UserRepositoryInterface {
  Future<Result<UserResponseModel?>> getUserData(int id);
}
