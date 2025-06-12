import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/create_profile.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/create_profile_state_notifier.dart';

final createProfileStateNotifierProvider = StateNotifierProvider<
  CreateProfileStateNotifier,
  AsyncValue<CreateProfileModel?>
>((ref) {
  return CreateProfileStateNotifier(
    createProfileUseCase: ref.read(createProfileUseCaseProvider),
  );
});
