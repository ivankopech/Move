import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/auth_response_model.dart';
import '../../../domain/use_cases/login_use_case.dart';

class LoginStateNotifier extends StateNotifier<AsyncValue<AuthResponseModel?>> {
  final LoginUseCase loginUseCase;

  LoginStateNotifier({required this.loginUseCase})
    : super(const AsyncValue.data(null));

  late AuthResponseModel? authResponseModel;

  Future<void> login(String number, String code) async {
    try {
      state = AsyncValue.loading();
      final result = await loginUseCase(number, code);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          authResponseModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
