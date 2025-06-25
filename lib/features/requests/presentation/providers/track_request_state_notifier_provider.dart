import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/track_request_model.dart';
import '../../presentation/providers/providers.dart';
import 'state/track_request_state_notifier.dart';

final trackRequestStateNotifierProvider = StateNotifierProvider<
  TrackRequestStateNotifier,
  AsyncValue<TrackRequestModel?>
>((ref) {
  return TrackRequestStateNotifier(
    trackRequestDataUseCase: ref.read(trackRequestDataUseCaseProvider),
  );
});
