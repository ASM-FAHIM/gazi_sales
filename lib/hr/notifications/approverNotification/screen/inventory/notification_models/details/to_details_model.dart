// To parse this JSON data, do
//
//     final toDetailsModel = toDetailsModelFromJson(jsonString);

import 'dart:convert';

List<ToDetailsModel> toDetailsModelFromJson(String str) =>
    List<ToDetailsModel>.from(
        json.decode(str).map((x) => ToDetailsModel.fromJson(x)));

String toDetailsModelToJson(List<ToDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDetailsModel {
  ToDetailsModel({
    required this.xrow,
    required this.xunit,
    required this.xitem,
    required this.productName,
    required this.xprepqty,
    required this.xdphqty,
    required this.xnote,
  });

  int xrow;
  String xunit;
  String xitem;
  String productName;
  String xprepqty;
  String xdphqty;
  String xnote;

  factory ToDetailsModel.fromJson(Map<String, dynamic> json) => ToDetailsModel(
        xrow: json["xrow"] ?? ' ',
        xunit: json["xunit"] ?? ' ',
        xitem: json["xitem"] ?? ' ',
        productName: json["product_Name"] ?? ' ',
        xprepqty: json["xprepqty"] ?? ' ',
        xdphqty: json["xdphqty"] ?? ' ',
        xnote: json["xnote"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xunit": xunit,
        "xitem": xitem,
        "product_Name": productName,
        "xprepqty": xprepqty,
        "xdphqty": xdphqty,
        "xnote": xnote,
      };
}
