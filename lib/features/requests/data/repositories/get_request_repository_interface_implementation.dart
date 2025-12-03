import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../../data/models/get_requests_model.dart';
import '../../domain/repositories/get_requests_repository_interface.dart';

class GetRequestRepositoryInterfaceImplementation
    extends GetRequestsRepositoryInterface {
  final ApiClient apiClient;

  GetRequestRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<List<GetRequestsModel?>>> getRequests({
    required int id,
    required bool noTip,
  }) async {
    try {
      final response = await apiClient.getData(
        'services/app/Solicitud/GetSolicitudes/GetAll?UserId=$id&WithNoTip=$noTip&MaxResultCount=100',
        (json) {
          final result = GetRequestsModelResponse.fromJson(json['result']);
          var list = result.items;
          return list ?? [];
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
