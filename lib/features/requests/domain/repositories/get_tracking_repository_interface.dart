import '../../../../config/api_client.dart';
import '../../data/models/get_tracking_model.dart';

abstract class GetTrackingRepositoryInterface {
  Future<Result<List<GetTrackingModel?>>> trackRequest({required int id});
}
