import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/create_profile.dart';
import '../../../domain/use_cases/create_profile_use_case.dart';

class CreateProfileStateNotifier
    extends StateNotifier<AsyncValue<CreateProfileModel?>> {
  final CreateProfileUseCase createProfileUseCase;

  CreateProfileStateNotifier({required this.createProfileUseCase})
    : super(const AsyncValue.data(null));

  late CreateProfileModel? createProfileModel;

  Future<void> createProfile(
    String? emailAddress,
    String? name,
    String? surname,
  ) async {
    try {
      state = AsyncValue.loading();
      final result = await createProfileUseCase(emailAddress, name, surname);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          createProfileModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
