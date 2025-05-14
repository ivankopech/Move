import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/get_requests_model.dart';
import '../../domain/repositories/get_requests_repository_interface.dart';

class GetRequestsDataUseCase {
  final GetRequestsRepositoryInterface getRequestsRepositoryInterface;

  GetRequestsDataUseCase({required this.getRequestsRepositoryInterface});

  Future<Either<ApiException, List<GetRequestsModel?>>> call() async {
    return getRequestsRepositoryInterface.getRequests();
  }
}
