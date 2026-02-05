import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/get_request_id_model.dart';
import '../../presentation/providers/providers.dart';
import 'state/get_request_id_state_notifier.dart';

final getRequestByIdStateNotifierProvider = StateNotifierProvider<
  GetRequestByIdStateNotifier,
  AsyncValue<GetRequestByIdModel?>
>((ref) {
  return GetRequestByIdStateNotifier(
    getRequestByIdDataUseCase: ref.read(getRequestByIdDataUseCaseProvider),
  );
});
