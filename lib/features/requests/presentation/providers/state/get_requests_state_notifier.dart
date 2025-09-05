import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/get_requests_model.dart';
import '../../../domain/use_cases/get_requests_data_use_case.dart';

class GetRequestsStateNotifier
    extends StateNotifier<AsyncValue<List<GetRequestsModel?>>> {
  final GetRequestsDataUseCase getRequestsDataUseCase;

  GetRequestsStateNotifier({required this.getRequestsDataUseCase})
    : super(const AsyncValue.loading());

  late List<GetRequestsModel?> getRequestsModelList;

  Future<void> getRequests(String estado, bool hasTip) async {
    try {
      state = AsyncValue.loading();
      final result = await getRequestsDataUseCase(estado, hasTip);

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          getRequestsModelList = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
