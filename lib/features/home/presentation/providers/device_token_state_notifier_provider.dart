import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/device_token_model.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/device_token_state_notifier.dart';

final registerDeviceTokenStateNotifierProvider = StateNotifierProvider<
  RegisterDeviceTokenStateNotifier,
  AsyncValue<RegisterDeviceTokenModel?>
>((ref) {
  return RegisterDeviceTokenStateNotifier(
    registerDeviceTokenUseCase: ref.read((registerDeviceTokenUseCaseProvider)),
  );
});
