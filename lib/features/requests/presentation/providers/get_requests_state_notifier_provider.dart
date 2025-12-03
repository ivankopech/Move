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

final getRequestsToTipStateNotifierProvider = StateNotifierProvider<
  GetRequestsStateNotifier,
  AsyncValue<List<GetRequestsModel?>>
>((ref) {
  return GetRequestsStateNotifier(
    getRequestsDataUseCase: ref.read(getRequestsDataUseCaseProvider),
  );
});
