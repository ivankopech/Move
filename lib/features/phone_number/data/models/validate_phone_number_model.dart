class ValidatePhoneNumberModel {
  String? phoneNumber;

  ValidatePhoneNumberModel({this.phoneNumber});

  ValidatePhoneNumberModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
