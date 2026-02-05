import 'package:fpdart/fpdart.dart';
import 'package:move/config/api_exception.dart';

import '../../../../config/api_client.dart';
import '../../data/models/get_tracking_model.dart';

abstract class GetTrackingRepositoryInterface {
  Future<Either<ApiException, GetTrackingModelResponse>> trackRequest({
    required int id,
  });
}
