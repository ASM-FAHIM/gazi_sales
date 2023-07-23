// To parse this JSON data, do
//
//     final cSdetailsModel = cSdetailsModelFromJson(jsonString);

import 'dart:convert';

List<CSdetailsModel> cSdetailsModelFromJson(String str) =>
    List<CSdetailsModel>.from(
        json.decode(str).map((x) => CSdetailsModel.fromJson(x)));

String cSdetailsModelToJson(List<CSdetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CSdetailsModel {
  CSdetailsModel({
    required this.xrow,
    required this.xitem,
    required this.productName,
    required this.xunitpur,
    required this.xqtyreq,
  });

  int xrow;
  String xitem;
  String productName;
  String xunitpur;
  String xqtyreq;

  factory CSdetailsModel.fromJson(Map<String, dynamic> json) => CSdetailsModel(
        xrow: json["xrow"] ?? ' ',
        xitem: json["xitem"] ?? ' ',
        productName: json["product_Name"] ?? ' ',
        xunitpur: json["xunitpur"] ?? ' ',
        xqtyreq: json["xqtyreq"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xitem": xitem,
        "product_Name": productName,
        "xunitpur": xunitpur,
        "xqtyreq": xqtyreq,
      };
}
