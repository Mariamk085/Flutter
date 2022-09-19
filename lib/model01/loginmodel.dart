class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username?.trim(),
      'password': password?.trim(),
    };

    return map;
  }
}

class AccessTokenResponse {
  final String? token;
  final String? message;
  final String? error;

  AccessTokenResponse({this.token, this.message, this.error});

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return AccessTokenResponse(
      token: json["access_token"] != null ? json["access_token"] : null,
      message: json["message"] != null ? json["message"] : null,
      error: json["error"] != null ? json["error"] : null,
    );
  }
}