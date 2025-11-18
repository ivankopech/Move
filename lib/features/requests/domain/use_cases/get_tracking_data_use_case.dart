import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/get_tracking_model.dart';
import '../../domain/repositories/get_tracking_repository_interface.dart';

class GetTrackingDataUseCase {
  final GetTrackingRepositoryInterface getTrackingRepositoryInterface;

  GetTrackingDataUseCase({required this.getTrackingRepositoryInterface});

  Future<Either<ApiException, List<GetTrackingModel?>>> call(int id) async {
    return getTrackingRepositoryInterface.trackRequest(id: id);
  }
}
