import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/get_requests_model.dart';
import '../../presentation/providers/providers.dart';
import 'state/get_requests_state_notifier.dart';

final getRequestsStateNotifierProvider = StateNotifierProvider<
  GetRequestsStateNotifier,
  AsyncValue<List<GetRequestsModel?>>
>((ref) {
  return GetRequestsStateNotifier(
    getRequestsDataUseCase: ref.read(getRequestsDataUseCaseProvider),
  );
});

final openRequestsCount = Provider<int>((ref) {
  final state = ref.watch(getRequestsStateNotifierProvider);
  return state.when(
    data: (requests) => requests.where((r) => r?.estado == "Open").length,
    error: (_, _) => 0,
    loading: () => 0,
  );
});

final acceptedRequestsCount = Provider<int>((ref) {
  final state = ref.watch(getRequestsStateNotifierProvider);
  return state.when(
    data: (requests) => requests.where((r) => r?.estado == "Assigned").length,
    error: (_, _) => 0,
    loading: () => 0,
  );
});

final finishedRequestsCount = Provider<int>((ref) {
  final state = ref.watch(getRequestsStateNotifierProvider);
  return state.when(
    data: (requests) => requests.where((r) => r?.estado == "Finished").length,
    error: (_, _) => 0,
    loading: () => 0,
  );
});
