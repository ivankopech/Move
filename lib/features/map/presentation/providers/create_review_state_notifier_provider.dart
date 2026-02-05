import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/create_review.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/providers/state/create_review_state_notifier.dart';

final createReviewStateNotifierProvider = StateNotifierProvider<
  CreateReviewStateNotifier,
  AsyncValue<CreateReviewModel?>
>((ref) {
  return CreateReviewStateNotifier(
    createReviewUseCase: ref.read(createReviewUseCaseProvider),
  );
});
