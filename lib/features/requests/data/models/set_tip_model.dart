class SetTipModel {
  double? tipPercentaje;
  double? tipAmount;
  bool? noTip;

  SetTipModel({this.tipPercentaje, this.tipAmount});

  SetTipModel.fromJson(Map<String, dynamic> json) {
    tipPercentaje = json['tipPercentaje'];
    tipAmount = json['tipAmount'];
    noTip = json['noTip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tipPercentaje'] = tipPercentaje;
    data['tipAmount'] = tipAmount;
    data['noTip'] = noTip;
    return data;
  }
}
