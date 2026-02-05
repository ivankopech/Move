import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/get_request_id_model.dart';
import '../../../domain/use_cases/get_request_id_data_use_case.dart';

class GetRequestByIdStateNotifier
    extends StateNotifier<AsyncValue<GetRequestByIdModel?>> {
  final GetRequestByIdDataUseCase getRequestByIdDataUseCase;

  GetRequestByIdStateNotifier({required this.getRequestByIdDataUseCase})
    : super(const AsyncValue.loading());

  late GetRequestByIdModel? getRequestByIdModel;

  Future<void> getRequestById(int id) async {
    try {
      state = AsyncValue.loading();
      final result = await getRequestByIdDataUseCase(id);

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
