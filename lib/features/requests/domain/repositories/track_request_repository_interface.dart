import '../../../../config/api_client.dart';
import '../../data/models/track_request_model.dart';

abstract class TrackRequestRepositoryInterface {
  Future<Result<TrackRequestModel?>> trackRequest(int id);
}
