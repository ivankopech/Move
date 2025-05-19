import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/validate_phone_number_model.dart';
import '../../domain/repositories/validate_phone_number_repository_interface.dart';

class ValidatePhoneNumberUseCase {
  final ValidatePhoneNumberRepositoryInterface
  validatePhoneNumberRepositoryInterface;

  ValidatePhoneNumberUseCase({
    required this.validatePhoneNumberRepositoryInterface,
  });

  Future<Either<ApiException, ValidatePhoneNumberModel?>> call(
    String number,
  ) async {
    return validatePhoneNumberRepositoryInterface.validatePhoneNumber(number);
  }
}
