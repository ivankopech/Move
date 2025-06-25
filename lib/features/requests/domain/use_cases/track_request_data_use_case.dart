import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/track_request_model.dart';
import '../../domain/repositories/track_request_repository_interface.dart';

class TrackRequestDataUseCase {
  final TrackRequestRepositoryInterface trackRequestRepositoryInterface;

  TrackRequestDataUseCase({required this.trackRequestRepositoryInterface});

  Future<Either<ApiException, TrackRequestModel?>> call(int id) async {
    return trackRequestRepositoryInterface.trackRequest(id);
  }
}
