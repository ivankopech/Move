import '../../../../config/api_client.dart';
import '../../data/models/auth_response_model.dart';

abstract class AuthRepositoryInterface {
  Future<Result<AuthResponseModel?>> login(String user, String password);
}
