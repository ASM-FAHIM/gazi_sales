// To parse this JSON data, do
//
//     final astiDetailsModel = astiDetailsModelFromJson(jsonString);

import 'dart:convert';

List<AstiDetailsModel> astiDetailsModelFromJson(String str) =>
    List<AstiDetailsModel>.from(
        json.decode(str).map((x) => AstiDetailsModel.fromJson(x)));

String astiDetailsModelToJson(List<AstiDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AstiDetailsModel {
  AstiDetailsModel({
    required this.xrow,
    required this.xunit,
    required this.xitem,
    required this.productName,
    required this.partno,
    required this.xprepqty,
    required this.xdphqty,
    required this.xnote,
  });

  int xrow;
  String xunit;
  String xitem;
  String productName;
  String partno;
  String xprepqty;
  String xdphqty;
  String xnote;

  factory AstiDetailsModel.fromJson(Map<String, dynamic> json) =>
      AstiDetailsModel(
        xrow: json["xrow"] ?? ' ',
        xunit: json["xunit"] ?? ' ',
        xitem: json["xitem"] ?? ' ',
        productName: json["product_Name"] ?? ' ',
        partno: json["partno"] ?? ' ',
        xprepqty: json["xprepqty"] ?? ' ',
        xdphqty: json["xdphqty"] ?? ' ',
        xnote: json["xnote"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xunit": xunit,
        "xitem": xitem,
        "product_Name": productName,
        "partno": partno,
        "xprepqty": xprepqty,
        "xdphqty": xdphqty,
        "xnote": xnote,
      };
}
