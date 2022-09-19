import 'dart:convert';
import 'package:ttranport_01/model01/orserview.dart';
import 'package:http/http.dart' as http;


class OrderView_Service {
  Future<order_view_model> orderview(var token) async {
    var url = Uri.parse("http://api.cwiztech.com:8079/v1/apigateway");
    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          'request_BODY': '{}',
          'request_TYPE': "GET",
          'request_URI': "salesorder",
          'service_NAME': "SALESORDER"
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return order_view_model.fromJson(json.decode(response.body));
    } else {
      return order_view_model
          .fromJson(json.decode(jsonEncode({'message': 'Invalid Input...'})));
    }
  }
}