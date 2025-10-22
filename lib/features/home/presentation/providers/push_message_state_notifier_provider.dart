import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/push_message_state_notifier.dart';

final sendPushMessageStateNotifierProvider =
    StateNotifierProvider<SendPushMessageStateNotifier, AsyncValue<Unit>>((
      ref,
    ) {
      return SendPushMessageStateNotifier(
        sendPushMessageUseCase: ref.read(sendPushMessageUseCaseProvider),
      );
    });
