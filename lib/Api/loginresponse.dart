class LoginResponseModel {
  String token = '';
  String error = '';

  LoginResponseModel({token, error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> data) {
    return LoginResponseModel(
      token: data["access_token"],
      error: data["error"] ?? "",
    );
  }
}

class LoginRequestModel {
  String email = '';
  String password = '';

  LoginRequestModel({
    email,
    password,
  });

  set username(String username) {}

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
