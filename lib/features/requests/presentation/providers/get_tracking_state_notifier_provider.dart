import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/get_tracking_model.dart';
import '../../presentation/providers/providers.dart';
import 'state/get_tracking_state_notifier.dart';

final getTrackingStateNotifierProvider = StateNotifierProvider<
  GetTrackingStateNotifier,
  AsyncValue<List<GetTrackingModel?>>
>((ref) {
  return GetTrackingStateNotifier(
    getTrackingDataUseCase: ref.read(getTrackingDataUseCaseProvider),
  );
});
