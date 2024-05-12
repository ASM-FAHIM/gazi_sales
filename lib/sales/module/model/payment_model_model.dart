// To parse this JSON data, do
//
//     final paymentModeModel = paymentModeModelFromJson(jsonString);

import 'dart:convert';

List<PaymentModeModel> paymentModeModelFromJson(String str) =>
    List<PaymentModeModel>.from(
        json.decode(str).map((x) => PaymentModeModel.fromJson(x)));

String paymentModeModelToJson(List<PaymentModeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModeModel {
  int? id;
  int zid;
  String xcode;

  PaymentModeModel({
    this.id,
    required this.zid,
    required this.xcode,
  });

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) =>
      PaymentModeModel(
        id: json["id"],
        zid: json["zid"],
        xcode: json["xcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xcode": xcode,
      };
}
