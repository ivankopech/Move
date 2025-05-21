import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/send_code_model.dart';
import '../repositories/send_code_repository_interface.dart';

class SendCodeUseCase {
  final SendCodeRepositoryInterface sendCodeRepositoryInterface;

  SendCodeUseCase({required this.sendCodeRepositoryInterface});

  Future<Either<ApiException, SendCodeModel?>> call(String number) async {
    return sendCodeRepositoryInterface.sendCode(number);
  }
}
