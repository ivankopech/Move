import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/validate_phone_number_model.dart';
import '../../domain/repositories/validate_phone_number_repository_interface.dart';

class ValidatePhoneNumberRepositoryInterfaceImplementation
    extends ValidatePhoneNumberRepositoryInterface {
  final ApiClient apiClient;

  ValidatePhoneNumberRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<ValidatePhoneNumberModel?>> validatePhoneNumber(
    String number,
  ) async {
    try {
      final body = {'phoneNumber': number};

      final response = await apiClient.postData(
        'TokenAuth/SendOtp',
        body,
        (json) => ValidatePhoneNumberModel.fromJson(json),
      );

      return response.fold((error) => Left(error), (data) async {
        return Right(data);
      });
    } catch (e, stackTrace) {
      return Left(
        ApiException(
          code: '500',
          message: 'Error inesperado: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
