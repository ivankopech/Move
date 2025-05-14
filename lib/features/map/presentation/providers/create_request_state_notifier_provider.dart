import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/create_request.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/create_request_state_notifier.dart';

final createRequestStateNotifierProvider = StateNotifierProvider<
  CreateRequestStateNotifier,
  AsyncValue<CreateRequestModel?>
>((ref) {
  return CreateRequestStateNotifier(
    createRequestUseCase: ref.read(createRequestUseCaseProvider),
  );
});
