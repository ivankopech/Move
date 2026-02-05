import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/get_tracking_model.dart';
import '../../../domain/use_cases/get_tracking_data_use_case.dart';

class GetTrackingStateNotifier
    extends StateNotifier<AsyncValue<GetTrackingModelResponse>> {
  final GetTrackingDataUseCase getTrackingDataUseCase;

  GetTrackingStateNotifier({required this.getTrackingDataUseCase})
    : super(const AsyncValue.loading());

  Future<void> trackRequest(int id) async {
    try {
      // Si esto te “titila” la UI en polling, decime y te lo dejo sin loading.
      state = const AsyncValue.loading();

      final result = await getTrackingDataUseCase(id);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) => AsyncValue.data(data),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
