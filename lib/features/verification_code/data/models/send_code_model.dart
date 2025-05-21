class SendCodeModel {
  String? phoneNumber;

  SendCodeModel({this.phoneNumber});

  SendCodeModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
