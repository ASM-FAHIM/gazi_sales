// To parse this JSON data, do
//
//     final poDetailsModel = poDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PoDetailsModel> poDetailsModelFromJson(String str) => List<PoDetailsModel>.from(json.decode(str).map((x) => PoDetailsModel.fromJson(x)));

String poDetailsModelToJson(List<PoDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoDetailsModel {
  PoDetailsModel({
    required this.xrow,
    required this.xitem,
    required this.xdesc,
    required this.xspecification,
    required this.xqtypur,
    required this.xunitpur,
    required this.xrate,
    required this.xlineamt,
    required this.partno,
    required this.currency,
    required this.povatrate,
    required this.povalue,
    required this.xrategrn,
  });

  String xrow;
  String xitem;
  String xdesc;
  String xspecification;
  String xqtypur;
  String xunitpur;
  String xrate;
  String xlineamt;
  String partno;
  String currency;
  String povatrate;
  String povalue;
  String xrategrn;

  factory PoDetailsModel.fromJson(Map<String, dynamic> json) => PoDetailsModel(
    xrow: json["xrow"],
    xitem: json["xitem"],
    xdesc: json["xdesc"],
    xspecification: json["xspecification"],
    xqtypur: json["xqtypur"],
    xunitpur: json["xunitpur"],
    xrate: json["xrate"],
    xlineamt: json["xlineamt"],
    partno: json["partno"],
    currency: json["currency"],
    povatrate: json["povatrate"],
    povalue: json["povalue"],
    xrategrn: json["xrategrn"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xitem": xitem,
    "xdesc": xdesc,
    "xspecification": xspecification,
    "xqtypur": xqtypur,
    "xunitpur": xunitpur,
    "xrate": xrate,
    "xlineamt": xlineamt,
    "partno": partno,
    "currency": currency,
    "povatrate": povatrate,
    "povalue": povalue,
    "xrategrn": xrategrn,
  };
}
