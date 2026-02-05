import '../../../../config/api_client.dart';
import '../../data/models/get_request_id_model.dart';

abstract class GetRequestByIdRepositoryInterface {
  Future<Result<GetRequestByIdModel?>> getRequestById({required int id});
}
