import 'package:fpdart/fpdart.dart';
import '../../../../config/api_exception.dart';
import '../repositories/set_tip_repository_interface.dart';
import '../../data/models/set_tip_model.dart';

class SetTipUseCase {
  final SetTipRepositoryInterface setTipRepositoryInterface;

  SetTipUseCase({required this.setTipRepositoryInterface});

  Future<Either<ApiException, SetTipModel?>> call(
    int? id,
    double? tipPercentaje,
    double? tipAmount,
  ) async {
    return setTipRepositoryInterface.setTip(id, tipPercentaje, tipAmount);
  }
}
