import 'dart:convert';

order_view_model order_view_modelFromJson(String str) => order_view_model.fromJson(json.decode(str));

String order_view_modelToJson(order_view_model data) => json.encode(data.toJson());

class order_view_model {
    order_view_model({
        required this.isactive,
        required this.modifiedBy,
        required this.modifiedWhen,
        this.modifiedWorkstation,
    });

    String isactive;
    String modifiedBy;
    DateTime modifiedWhen;
    dynamic modifiedWorkstation;

    factory order_view_model.fromJson(Map<String, dynamic> json) => order_view_model(
        isactive: json["isactive"],
        modifiedBy: json["modified_BY"],
        modifiedWhen: DateTime.parse(json["modified_WHEN"]),
        modifiedWorkstation: json["modified_WORKSTATION"],
    );

    Map<String, dynamic> toJson() => {
        "isactive": isactive,
        "modified_BY": modifiedBy,
        "modified_WHEN": modifiedWhen.toIso8601String(),
        "modified_WORKSTATION": modifiedWorkstation,
    };
}