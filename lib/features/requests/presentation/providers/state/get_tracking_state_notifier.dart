import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/get_tracking_model.dart';
import '../../../domain/use_cases/get_tracking_data_use_case.dart';

class GetTrackingStateNotifier
    extends StateNotifier<AsyncValue<List<GetTrackingModel?>>> {
  final GetTrackingDataUseCase getTrackingDataUseCase;

  GetTrackingStateNotifier({required this.getTrackingDataUseCase})
    : super(const AsyncValue.loading());

  late List<GetTrackingModel?> getTrackingModelList;

  Future<void> trackRequest(int id) async {
    try {
      state = AsyncValue.loading();
      final result = await getTrackingDataUseCase(id);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          getTrackingModelList = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print('Error fetching data: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
