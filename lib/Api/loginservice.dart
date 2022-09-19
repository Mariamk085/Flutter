import 'dart:convert';
import 'dart:io';
import 'package:ttranport_01/Api/loginresponse.dart';
import 'package:ttranport_01/Api/setting.dart';
import 'package:ttranport_01/model01/loginmodel.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';




class LoginService {
  Settings settings = Settings();
  final LocalStorage TokenStorage = LocalStorage('Token_storage');
  final LocalStorage LoginStorage = LocalStorage('Login_storage');
  final LocalStorage privilegesStorage = LocalStorage('privileges_storage');
  void addTokenToLocalStorage(var token) {
    TokenStorage.setItem('Access', token);
  }

  void addLoginToLocalStorage(var login) {
    LoginStorage.setItem('Login', login);
  }

  void addprivilegesToLocalStorage(var privileges) {
    privilegesStorage.setItem('Privileges', privileges);
  }

  String getTokenFromLocalStorage() {
    String Token = TokenStorage.getItem('Access');
    return Token;
  }

  String getLoginFromLocalStorage() {
    String Login = LoginStorage.getItem('Login');
    return Login;
  }

  String getprivilegesFromLocalStorage() {
    String Privileges = privilegesStorage.getItem('Privileges');
    return Privileges;
  }

  Future<AccessTokenResponse> login(requestModel) async {
    var basicAuth = settings.GetAuthBasic();
    var url = Uri.parse(
        "http://api.cwiztech.com:8080/v1/oauth/token?username=${requestModel?.username}&password=${requestModel?.password}&grant_type=password");
    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $basicAuth',
      },
    );
    if (response.statusCode == 200) {
      addTokenToLocalStorage(response.body);
      var tokenJ = jsonDecode(getTokenFromLocalStorage());
      var token = tokenJ['access_token'];
      var url2 = Uri.parse("http://api.cwiztech.com:8080/v1/login");
      var response2 = await http.post(url2,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
              {"application_CODE": "${settings.GetapplicationCODE()}"}));
      if (response2.statusCode == 200) {
        addLoginToLocalStorage(response2.body);
        var url3 =
            Uri.parse("http://api.cwiztech.com:8080/v1/login/userprivileges");
        var response3 = await http.post(
          url3,
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          body: json.encode({
            'application_ID': settings.GetApplicationID(),
          }),
        );
        if (response3.statusCode == 200) {
          addprivilegesToLocalStorage(response3.body);
          return AccessTokenResponse.fromJson(json.decode(response.body));
        } else {
          return AccessTokenResponse.fromJson(json.decode(response3.body));
        }
      } else {
        return AccessTokenResponse.fromJson(json.decode(response2.body));
      }
    } else {
      return AccessTokenResponse.fromJson(
          json.decode(jsonEncode({'message': 'Invalid Input...'})));
    }
  }
}