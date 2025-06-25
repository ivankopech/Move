import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/track_request_model.dart';
import '../../../domain/use_cases/track_request_data_use_case.dart';

class TrackRequestStateNotifier
    extends StateNotifier<AsyncValue<TrackRequestModel?>> {
  final TrackRequestDataUseCase trackRequestDataUseCase;

  TrackRequestStateNotifier({required this.trackRequestDataUseCase})
    : super(const AsyncValue.loading());

  late TrackRequestModel? trackRequestModel;

  Future<void> trackRequest(int id) async {
    try {
      state = AsyncValue.loading();
      final result = await trackRequestDataUseCase(id);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          trackRequestModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
