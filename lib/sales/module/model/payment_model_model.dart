// To parse this JSON data, do
//
//     final paymentModeModel = paymentModeModelFromJson(jsonString);

import 'dart:convert';

List<PaymentModeModel> paymentModeModelFromJson(String str) => List<PaymentModeModel>.from(json.decode(str).map((x) => PaymentModeModel.fromJson(x)));

String paymentModeModelToJson(List<PaymentModeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModeModel {
  String xcode;

  PaymentModeModel({
    required this.xcode,
  });

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) => PaymentModeModel(
    xcode: json["xcode"],
  );

  Map<String, dynamic> toJson() => {
    "xcode": xcode,
  };
}
