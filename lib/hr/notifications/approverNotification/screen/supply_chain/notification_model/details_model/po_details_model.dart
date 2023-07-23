// To parse this JSON data, do
//
//     final inventoryCountModel = inventoryCountModelFromJson(jsonString);

import 'dart:convert';

List<POdetailsModel> inventoryCountModelFromJson(String str) =>
    List<POdetailsModel>.from(
        json.decode(str).map((x) => POdetailsModel.fromJson(x)));

String inventoryCountModelToJson(List<POdetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class POdetailsModel {
  POdetailsModel({
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

  int xrow;
  String xitem;
  String xdesc;
  String xspecification;
  String xqtypur;
  String xunitpur;
  String xrate;
  String xlineamt;
  dynamic partno;
  String currency;
  String povatrate;
  String povalue;
  String xrategrn;

  factory POdetailsModel.fromJson(Map<String, dynamic> json) => POdetailsModel(
        xrow: json["xrow"] ?? ' ',
        xitem: json["xitem"] ?? ' ',
        xdesc: json["xdesc"] ?? ' ',
        xspecification: json["xspecification"] ?? ' ',
        xqtypur: json["xqtypur"] ?? ' ',
        xunitpur: json["xunitpur"] ?? ' ',
        xrate: json["xrate"] ?? ' ',
        xlineamt: json["xlineamt"] ?? ' ',
        partno: json["partno"] ?? ' ',
        currency: json["currency"] ?? ' ',
        povatrate: json["povatrate"] ?? ' ',
        povalue: json["povalue"] ?? ' ',
        xrategrn: json["xrategrn"] ?? ' ',
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
