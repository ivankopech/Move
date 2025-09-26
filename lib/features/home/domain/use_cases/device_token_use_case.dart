import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/device_token_repository_interface.dart';
import '../../data/models/device_token_model.dart';

class RegisterDeviceTokenUseCase {
  final RegisterDeviceTokenRepositoryInterface
  registerDeviceTokenRepositoryInterface;

  RegisterDeviceTokenUseCase({
    required this.registerDeviceTokenRepositoryInterface,
  });

  Future<Either<ApiException, RegisterDeviceTokenModel?>> call(
    String? apn,
    String? token,
  ) async {
    return registerDeviceTokenRepositoryInterface.registerDeviceToken(
      apn,
      token,
    );
  }
}
