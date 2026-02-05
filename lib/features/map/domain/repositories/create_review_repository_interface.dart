import '../../../../config/api_client.dart';
import '../../data/models/create_review.dart';

abstract class CreateReviewRepositoryInterface {
  Future<Result<CreateReviewModel?>> createReview({
    required int id,
    required String? comment,
    required int? rating,
  });
}
