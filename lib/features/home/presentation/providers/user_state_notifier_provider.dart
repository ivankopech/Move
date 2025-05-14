import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_response_model.dart';
import '../providers/providers.dart';
import '../providers/state/user_state_notifier.dart';

final userStateNotifierProvider = StateNotifierProvider<
  UserStateNotifier,
  AsyncValue<UserResponseModel?>
>((ref) {
  return UserStateNotifier(userDataUseCase: ref.read(userDataUseCaseProvider));
});
