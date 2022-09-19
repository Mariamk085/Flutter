import 'package:flutter/cupertino.dart';

class Transport {
  String? code;
  String? desc;
  String? colordesc;
  String? type;
  int? id;

  Transport({this.code, this.desc, this.colordesc, this.type, this.id});
}

class TransportR {
  String? code;
  String? desc;
  dynamic colorid;
  String? type;
  int? id;

  TransportR({this.code, this.desc, this.colorid, this.type, this.id});
  factory TransportR.fromJson(Map<String, dynamic> json) {
    return TransportR(
      code: json["transportroute_CODE"],
      desc: json["transportroute_DESC"],
      type: json["transportroute_TYPE"],
      colorid: json["colour_ID"],
      id: json["transportroute_ID"],
    );
  }
}

class TransportColor {
  String? desc;
  int? id;

  TransportColor({this.desc, this.id});
  factory TransportColor.fromJson(Map<String, dynamic> json) {
    return TransportColor(
      desc: json["description"],
      id: json["id"],
    );
  }
}
