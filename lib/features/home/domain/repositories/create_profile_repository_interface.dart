import '../../../../config/api_client.dart';
import '../../data/models/create_profile.dart';

abstract class CreateProfileRepositoryInterface {
  Future<Result<CreateProfileModel?>> createProfile(
    String? emailAddress,
    String? name,
    String? surname,
  );
}
