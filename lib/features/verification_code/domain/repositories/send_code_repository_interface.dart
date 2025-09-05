import '../../../../config/api_client.dart';
import '../../data/models/send_code_model.dart';

abstract class SendCodeRepositoryInterface {
  Future<Result<bool?>> sendCode(String number);
}
