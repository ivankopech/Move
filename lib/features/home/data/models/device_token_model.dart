class RegisterDeviceTokenModel {
  String? platform;
  String? deviceToken;

  RegisterDeviceTokenModel({this.platform, this.deviceToken});

  RegisterDeviceTokenModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['deviceToken'] = deviceToken;
    return data;
  }
}
