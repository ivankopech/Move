import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/create_profile.dart';
import '../../domain/repositories/create_profile_repository_interface.dart';

class CreateProfileRepositoryInterfaceImplementation
    extends CreateProfileRepositoryInterface {
  final ApiClient apiClient;

  CreateProfileRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<CreateProfileModel?>> createProfile(
    String? emailAddress,
    String? name,
    String? surname,
  ) async {
    try {
      final body = {
        'emailAddress': emailAddress,
        "name": name,
        'surname': surname,
      };

      final response = await apiClient.postData(
        'TokenAuth/CreateInitialProfile',
        body,
        (json) => CreateProfileModel.fromJson(json),
      );

      return response.fold((error) => Left(error), (data) async {
        return Right(data);
      });
    } catch (e, stackTrace) {
      return Left(
        ApiException(
          code: '500',
          message: 'Error inesperado: $e',
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
