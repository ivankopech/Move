import '../../../../config/api_client.dart';
import '../../data/models/get_requests_model.dart';

abstract class GetRequestsRepositoryInterface {
  Future<Result<List<GetRequestsModel?>>> getRequests();
}
