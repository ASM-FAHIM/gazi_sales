// To parse this JSON data, do
//
//     final productNatureModel = productNatureModelFromJson(jsonString);

import 'dart:convert';

List<ProductNatureModel> productNatureModelFromJson(String str) =>
    List<ProductNatureModel>.from(
        json.decode(str).map((x) => ProductNatureModel.fromJson(x)));

String productNatureModelToJson(List<ProductNatureModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductNatureModel {
  int zid;
  String xcode;
  String xlong;

  ProductNatureModel({
    required this.zid,
    required this.xcode,
    required this.xlong,
  });

  factory ProductNatureModel.fromJson(Map<String, dynamic> json) =>
      ProductNatureModel(
        zid: json["zid"],
        xcode: json["xcode"],
        xlong: json["xlong"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xcode": xcode,
        "xlong": xlong,
      };
}
