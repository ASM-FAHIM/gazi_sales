// To parse this JSON data, do
//
//     final productAccessoriesModel = productAccessoriesModelFromJson(jsonString);

import 'dart:convert';

List<ProductAccessoriesModel> productAccessoriesModelFromJson(String str) => List<ProductAccessoriesModel>.from(json.decode(str).map((x) => ProductAccessoriesModel.fromJson(x)));

String productAccessoriesModelToJson(List<ProductAccessoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductAccessoriesModel {
  int? id;
  int zid;
  int xrow;
  String xitem;
  String xitemaccessories;
  String name;
  String xunit;
  String xqty;

  ProductAccessoriesModel({
    this.id,
    required this.zid,
    required this.xrow,
    required this.xitem,
    required this.xitemaccessories,
    required this.name,
    required this.xunit,
    required this.xqty,
  });

  factory ProductAccessoriesModel.fromJson(Map<String, dynamic> json) => ProductAccessoriesModel(
    id: json["id"],
    zid: json["zid"],
    xrow: json["xrow"],
    xitem: json["xitem"],
    xitemaccessories: json["xitemaccessories"],
    name: json["name"],
    xunit: json["xunit"],
    xqty: json["xqty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "zid": zid,
    "xrow": xrow,
    "xitem": xitem,
    "xitemaccessories": xitemaccessories,
    "name": name,
    "xunit": xunit,
    "xqty": xqty,
  };
}
