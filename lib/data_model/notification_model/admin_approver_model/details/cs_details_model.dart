// To parse this JSON data, do
//
//     final csDetailsModel = csDetailsModelFromJson(jsonString);

import 'dart:convert';

List<CsDetailsModel> csDetailsModelFromJson(String str) => List<CsDetailsModel>.from(json.decode(str).map((x) => CsDetailsModel.fromJson(x)));

String csDetailsModelToJson(List<CsDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsDetailsModel {
  CsDetailsModel({
    required this.xrow,
    required this.xitem,
    required this.productName,
    required this.xunitpur,
    required this.xqtyreq,
  });

  String xrow;
  String xitem;
  String productName;
  String xunitpur;
  String xqtyreq;

  factory CsDetailsModel.fromJson(Map<String, dynamic> json) => CsDetailsModel(
    xrow: json["xrow"],
    xitem: json["xitem"],
    productName: json["product_Name"],
    xunitpur: json["xunitpur"],
    xqtyreq: json["xqtyreq"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xitem": xitem,
    "product_Name": productName,
    "xunitpur": xunitpur,
    "xqtyreq": xqtyreq,
  };
}
