import '../../../../config/api_client.dart';
import '../../data/models/device_token_model.dart';

abstract class RegisterDeviceTokenRepositoryInterface {
  Future<Result<RegisterDeviceTokenModel?>> registerDeviceToken(
    String? apn,
    String? token,
  );
}
