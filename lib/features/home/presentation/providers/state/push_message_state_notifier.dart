import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../domain/use_cases/push_message_use_case.dart';

class SendPushMessageStateNotifier extends StateNotifier<AsyncValue<Unit>> {
  final SendPushMessageUseCase sendPushMessageUseCase;

  SendPushMessageStateNotifier({required this.sendPushMessageUseCase})
    : super(const AsyncValue.data(unit));

  Future<void> sendPushMessage() async {
    try {
      state = const AsyncValue.loading();
      final result = await sendPushMessageUseCase();

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) => AsyncValue.data(data),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
