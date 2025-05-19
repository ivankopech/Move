import '../../../../config/api_client.dart';
import '../../data/models/validate_phone_number_model.dart';

abstract class ValidatePhoneNumberRepositoryInterface {
  Future<Result<ValidatePhoneNumberModel?>> validatePhoneNumber(String number);
}
