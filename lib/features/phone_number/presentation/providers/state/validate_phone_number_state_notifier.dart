import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/validate_phone_number_model.dart';
import '../../../domain/use_cases/validate_phone_number_use_case.dart';

class ValidatePhoneNumberStateNotifier
    extends StateNotifier<AsyncValue<ValidatePhoneNumberModel?>> {
  final ValidatePhoneNumberUseCase validatePhoneNumberUseCase;

  ValidatePhoneNumberStateNotifier({required this.validatePhoneNumberUseCase})
    : super(const AsyncValue.data(null));

  late ValidatePhoneNumberModel? validatePhoneNumberModel;

  Future<void> validatePhoneNumber(String number) async {
    try {
      state = AsyncValue.loading();
      final result = await validatePhoneNumberUseCase(number);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          validatePhoneNumberModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
