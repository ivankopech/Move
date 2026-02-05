import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/create_review_repository_interface.dart';
import '../../data/models/create_review.dart';

class CreateReviewUseCase {
  final CreateReviewRepositoryInterface createReviewRepositoryInterface;

  CreateReviewUseCase({required this.createReviewRepositoryInterface});

  Future<Either<ApiException, CreateReviewModel?>> call({
    required int? id,
    required String? comment,
    required int? rating,
  }) async {
    return createReviewRepositoryInterface.createReview(
      id: id!,
      comment: comment,
      rating: rating,
    );
  }
}
