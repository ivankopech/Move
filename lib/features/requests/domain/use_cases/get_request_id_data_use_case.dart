import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/get_request_id_model.dart';
import '../../domain/repositories/get_request_id_repository_interface.dart';

class GetRequestByIdDataUseCase {
  final GetRequestByIdRepositoryInterface getRequestByIdRepositoryInterface;

  GetRequestByIdDataUseCase({required this.getRequestByIdRepositoryInterface});

  Future<Either<ApiException, GetRequestByIdModel?>> call(int id) async {
    final result = await getRequestByIdRepositoryInterface.getRequestById(
      id: id,
    );
    return result.fold((error) => Left(error), (data) => Right(data));
  }
}
