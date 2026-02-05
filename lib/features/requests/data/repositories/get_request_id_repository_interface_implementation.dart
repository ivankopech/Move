import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/get_request_id_model.dart';
import '../../domain/repositories/get_request_id_repository_interface.dart';

class GetRequestByIdRepositoryInterfaceImplementation
    extends GetRequestByIdRepositoryInterface {
  final ApiClient apiClient;

  GetRequestByIdRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<GetRequestByIdModel?>> getRequestById({required int id}) async {
    try {
      final response = await apiClient.getData(
        'services/app/Solicitud/GetSolicitudByIdSolicitud?id=$id',
        (json) {
          return GetRequestByIdModel.fromJson(json['result']);
        },
      );
      return response.fold((error) => Left(error), (data) async {
        return Right(data!);
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
