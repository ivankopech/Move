import 'package:riverpod/riverpod.dart';
import '../data/models/send_code_model.dart';
import 'providers.dart';
import 'state/send_code_state_notifier.dart';

final sendCodeStateNotifierProvider =
    StateNotifierProvider<SendCodeStateNotifier, AsyncValue<SendCodeModel?>>((
      ref,
    ) {
      return SendCodeStateNotifier(
        sendCodeUseCase: ref.read(sendCodeUseCaseProvider),
      );
    });
