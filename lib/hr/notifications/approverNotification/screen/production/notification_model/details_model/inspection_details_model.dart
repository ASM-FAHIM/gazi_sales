// To parse this JSON data, do
//
//     final inspectionDetailsModel = inspectionDetailsModelFromJson(jsonString);

import 'dart:convert';

List<InspectionDetailsModel> inspectionDetailsModelFromJson(String str) =>
    List<InspectionDetailsModel>.from(
        json.decode(str).map((x) => InspectionDetailsModel.fromJson(x)));

String inspectionDetailsModelToJson(List<InspectionDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InspectionDetailsModel {
  InspectionDetailsModel({
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
  dynamic xprepqty;
  dynamic xdphqty;
  dynamic xnote;

  factory InspectionDetailsModel.fromJson(Map<String, dynamic> json) =>
      InspectionDetailsModel(
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
