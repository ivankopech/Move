import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_response_model.dart';
import '../../../domain/use_cases/user_data_use_case.dart';

class UserStateNotifier extends StateNotifier<AsyncValue<UserResponseModel?>> {
  final UserDataUseCase userDataUseCase;

  UserStateNotifier({required this.userDataUseCase})
    : super(const AsyncValue.loading());

  late UserResponseModel? userResponseModel;

  Future<void> getUserData(int id) async {
    try {
      state = AsyncValue.loading();
      final result = await userDataUseCase(id);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          userResponseModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
