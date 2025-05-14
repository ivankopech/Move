class AuthResponseModel {
  ResultModel? result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  AuthResponseModel({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      result: json['result'] != null ? ResultModel.fromJson(json['result']) : null,
      targetUrl: json['targetUrl'],
      success: json['success'],
      error: json['error'],
      unAuthorizedRequest: json['unAuthorizedRequest'],
      abp: json['__abp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result?.toJson(),
      'targetUrl': targetUrl,
      'success': success,
      'error': error,
      'unAuthorizedRequest': unAuthorizedRequest,
      '__abp': abp,
    };
  }
}

class ResultModel {
  String accessToken;
  String encryptedAccessToken;
  int expiresInSeconds;
  int userId;

  ResultModel({
    required this.accessToken,
    required this.encryptedAccessToken,
    required this.expiresInSeconds,
    required this.userId,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      accessToken: json['accessToken'],
      encryptedAccessToken: json['encryptedAccessToken'],
      expiresInSeconds: json['expireInSeconds'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'encryptedAccessToken': encryptedAccessToken,
      'expireInSeconds': expiresInSeconds,
      'userId': userId,
    };
  }
}