import 'package:fpdart/fpdart.dart';
import '../../../../config/api_client.dart';
import '../../../../config/api_exception.dart';
import '../models/set_tip_model.dart';
import '../../domain/repositories/set_tip_repository_interface.dart';

class SetTipRepositoryInterfaceImplementation
    extends SetTipRepositoryInterface {
  final ApiClient apiClient;

  SetTipRepositoryInterfaceImplementation(this.apiClient);

  @override
  Future<Result<SetTipModel?>> setTip(
    int? id,
    double? tipPercentaje,
    double? tipAmount,
  ) async {
    try {
      final body = {'tipPercentaje': tipPercentaje, 'tipAmount': tipAmount};

      final response = await apiClient.putData(
        'services/app/Solicitud/SetTip/$id',
        body,
        (json) => SetTipModel.fromJson(json),
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
