import 'package:move/config/api_client.dart';
import '../../data/models/set_tip_model.dart';

abstract class SetTipRepositoryInterface {
  Future<Result<SetTipModel?>> setTip(
    int? id,
    double? tipPercentaje,
    double? tipAmount,
    bool? noTip,
  );
}
