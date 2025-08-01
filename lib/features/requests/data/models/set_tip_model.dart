class SetTipModel {
  double? tipPercentaje;
  double? tipAmount;

  SetTipModel({this.tipPercentaje, this.tipAmount});

  SetTipModel.fromJson(Map<String, dynamic> json) {
    tipPercentaje = json['tipPercentaje'];
    tipAmount = json['tipAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tipPercentaje'] = tipPercentaje;
    data['tipAmount'] = tipAmount;
    return data;
  }
}
