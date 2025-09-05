import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/send_code_model.dart';
import '../../domain/use_cases/send_code_use_case.dart';

class SendCodeStateNotifier extends StateNotifier<AsyncValue<bool?>> {
  final SendCodeUseCase sendCodeUseCase;

  SendCodeStateNotifier({required this.sendCodeUseCase})
    : super(const AsyncValue.data(false));

  late SendCodeModel? sendCodeModel;

  Future<void> sendCode(String number) async {
    try {
      state = AsyncValue.loading();
      final result = await sendCodeUseCase(number);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) => AsyncValue.data(data),
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
