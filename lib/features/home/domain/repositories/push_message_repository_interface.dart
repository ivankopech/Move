import 'package:fpdart/fpdart.dart';
import 'package:move/config/api_client.dart';

abstract class SendPushMessageRepositoryInterface {
  Future<Result<Unit>> sendPushMessage();
}
