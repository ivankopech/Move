import 'package:fpdart/fpdart.dart';
import 'package:move/features/home/domain/repositories/push_message_repository_interface.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../../domain/repositories/push_message_repository_interface.dart';

class SendPushMessageInterfaceImplementation
    extends SendPushMessageRepositoryInterface {
  final ApiClient apiClient;

  SendPushMessageInterfaceImplementation(this.apiClient);

  @override
  Future<Result<Unit>> sendPushMessage() async {
    try {
      final response = await apiClient.postData(
        'services/app/User/SendPushMessage',
        {},
        (_) => unit,
      );

      return response.map((_) => unit);
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
