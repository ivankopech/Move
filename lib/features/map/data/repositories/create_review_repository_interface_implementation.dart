import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/create_review.dart';
import '../../domain/repositories/create_review_repository_interface.dart';

class CreateReviewRepositoryInterfaceImplementation
    extends CreateReviewRepositoryInterface {
  final ApiClient apiClient;

  CreateReviewRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<CreateReviewModel?>> createReview({
    required int? id,
    required String? comment,
    required int? rating,
  }) async {
    try {
      final body = {'comment': comment, 'rating': rating};

      final response = await apiClient.postData(
        'services/app/Review/CreateReview/$id',
        body,
        (json) => CreateReviewModel.fromJson(json),
      );

      return response.fold((error) => Left(error), (data) async {
        return Right(data);
      });
    } catch (e, stackTrace) {
      return Left(
        ApiException(
          code: '500',
          message: 'Error inesperado: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
