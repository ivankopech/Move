import 'package:riverpod/riverpod.dart';
import '../../data/models/validate_phone_number_model.dart';
import './providers.dart';
import './state/validate_phone_number_state_notifier.dart';

final validatePhoneNumberStateNotifierProvider = StateNotifierProvider<
  ValidatePhoneNumberStateNotifier,
  AsyncValue<ValidatePhoneNumberModel?>
>((ref) {
  return ValidatePhoneNumberStateNotifier(
    validatePhoneNumberUseCase: ref.read(validatePhoneNumberUseCaseProvider),
  );
});
