import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/create_profile_repository_interface.dart';
import '../../data/models/create_profile.dart';

class CreateProfileUseCase {
  final CreateProfileRepositoryInterface createProfileRepositoryInterface;

  CreateProfileUseCase({required this.createProfileRepositoryInterface});

  Future<Either<ApiException, CreateProfileModel?>> call(
    String? emailAddress,
    String? name,
    String? surname,
  ) async {
    return createProfileRepositoryInterface.createProfile(
      emailAddress,
      name,
      surname,
    );
  }
}
