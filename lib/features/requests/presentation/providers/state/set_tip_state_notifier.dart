import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/set_tip_model.dart';
import '../../../domain/use_cases/set_tip_data_use_case.dart';

class SetTipStateNotifier extends StateNotifier<AsyncValue<SetTipModel?>> {
  final SetTipUseCase setTipUseCase;

  SetTipStateNotifier({required this.setTipUseCase})
    : super(const AsyncValue.data(null));

  late SetTipModel? setTipModel;

  Future<void> setTip(int? id, double? tipPercentage, double? tipAmount) async {
    try {
      state = AsyncValue.loading();
      final result = await setTipUseCase(id, tipPercentage, tipAmount);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          setTipModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
