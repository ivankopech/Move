import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/push_message_repository_interface.dart';

class SendPushMessageUseCase {
  final SendPushMessageRepositoryInterface sendPushMessageRepositoryInterface;

  SendPushMessageUseCase({required this.sendPushMessageRepositoryInterface});

  Future<Either<ApiException, Unit>> call() async {
    return sendPushMessageRepositoryInterface.sendPushMessage();
  }
}
