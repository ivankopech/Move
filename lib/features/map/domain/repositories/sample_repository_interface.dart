import 'package:move/config/api_client.dart';
import 'package:move/features/map/data/models/models.dart';

abstract class SampleRepositoryInterface {
  Future<Result<SampleResponseModel?>> getData();
}
