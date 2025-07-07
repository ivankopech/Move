import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/track_request_model.dart';
import '../providers/providers.dart';
import '../providers/state/track_request_state_notifier.dart';

final trackRequestStateNotifierProvider = StateNotifierProvider<
  TrackRequestStateNotifier,
  AsyncValue<TrackRequestModel?>
>((ref) {
  return TrackRequestStateNotifier(
    trackRequestDataUseCase: ref.read(trackRequestDataUseCaseProvider),
  );
});
