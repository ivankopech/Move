import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/send_code_model.dart';
import '../../domain/repositories/send_code_repository_interface.dart';

class SendCodeRepositoryInterfaceImplementation
    extends SendCodeRepositoryInterface {
  final ApiClient apiClient;

  SendCodeRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<SendCodeModel?>> sendCode(String number) async {
    try {
      final body = {'phoneNumber': number};

      final response = await apiClient.postData(
        'TokenAuth/SendOtp',
        body,
        (json) => SendCodeModel.fromJson(json),
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
