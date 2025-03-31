import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/features/map/data/models/models.dart';
import 'package:move/features/map/domain/use_cases/use_cases.dart';

class SampleStateNotifier
    extends StateNotifier<AsyncValue<SampleResponseModel?>> {
  final SampleUseCase sampleUseCase;

  SampleStateNotifier({required this.sampleUseCase})
      : super(const AsyncValue.loading());

  late SampleResponseModel sampleResponseModel;

  Future<void> getData() async {
    try {
      state = AsyncValue.loading();
      final result = await sampleUseCase();

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          print("get Data: ${data.toString()}");

          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
