import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/create_review.dart';
import '../../../domain/use_cases/create_review_use_case.dart';

class CreateReviewStateNotifier
    extends StateNotifier<AsyncValue<CreateReviewModel?>> {
  final CreateReviewUseCase createReviewUseCase;

  CreateReviewStateNotifier({required this.createReviewUseCase})
    : super(const AsyncValue.data(null));

  late CreateReviewModel? createRequestModel;

  Future<void> createReview({
    required int? id,
    required String? comment,
    required int? rating,
  }) async {
    try {
      state = AsyncValue.loading();
      final result = await createReviewUseCase(
        id: id,
        comment: comment,
        rating: rating,
      );

      state = result.fold(
        (error) => AsyncValue.error(error, StackTrace.current),
        (data) {
          createRequestModel = data;
          return AsyncValue.data(data);
        },
      );
    } catch (error, stackTrace) {
      print("Error fetching data: $error");
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
