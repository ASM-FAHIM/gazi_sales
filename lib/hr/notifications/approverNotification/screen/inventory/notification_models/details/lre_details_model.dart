// To parse this JSON data, do
//
//     final inspectionDetailsModel = inspectionDetailsModelFromJson(jsonString);

import 'dart:convert';

List<LreDetailsModel> inspectionDetailsModelFromJson(String str) =>
    List<LreDetailsModel>.from(
        json.decode(str).map((x) => LreDetailsModel.fromJson(x)));

String inspectionDetailsModelToJson(List<LreDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LreDetailsModel {
  LreDetailsModel({
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

  factory LreDetailsModel.fromJson(Map<String, dynamic> json) =>
      LreDetailsModel(
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
