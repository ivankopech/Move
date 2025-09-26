import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/device_token_model.dart';
import '../../../domain/use_cases/device_token_use_case.dart';

class RegisterDeviceTokenStateNotifier
    extends StateNotifier<AsyncValue<RegisterDeviceTokenModel?>> {
  final RegisterDeviceTokenUseCase registerDeviceTokenUseCase;

  RegisterDeviceTokenStateNotifier({required this.registerDeviceTokenUseCase})
    : super(const AsyncValue.data(null));

  late RegisterDeviceTokenModel? registerDeviceTokenModel;

  Future<void> registerDeviceToken(String? apn, String? token) async {
    try {
      state = AsyncValue.loading();
      final result = await registerDeviceTokenUseCase(apn, token);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          registerDeviceTokenModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
