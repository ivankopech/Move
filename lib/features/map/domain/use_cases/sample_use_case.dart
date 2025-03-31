import 'package:fpdart/fpdart.dart';
import 'package:move/config/api_exception.dart';
import 'package:move/features/map/data/models/models.dart';
import 'package:move/features/map/domain/repositories/repositories.dart';

class SampleUseCase {
  final SampleRepositoryInterface sampleRepositoryInterface;

  SampleUseCase({required this.sampleRepositoryInterface});

  Future<Either<ApiException, SampleResponseModel?>> call() async {
    return sampleRepositoryInterface.getData();
  }
}
