// To parse this JSON data, do
//
//     final damageDetailsModel = damageDetailsModelFromJson(jsonString);

import 'dart:convert';

List<DamageDetailsModel> damageDetailsModelFromJson(String str) => List<DamageDetailsModel>.from(json.decode(str).map((x) => DamageDetailsModel.fromJson(x)));

String damageDetailsModelToJson(List<DamageDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DamageDetailsModel {
  String? xrow;
  String? xunit;
  String? xitem;
  String? productName;
  String? xprepqty;
  String? xdphqty;
  String? xnote;
  String? xbrand;
  String? xitemconv;
  String? convProductName;
  String? xqtylead;
  String? convUnit;
  String? damageQty;

  DamageDetailsModel({
    this.xrow,
    this.xunit,
    this.xitem,
    this.productName,
    this.xprepqty,
    this.xdphqty,
    this.xnote,
    this.xbrand,
    this.xitemconv,
    this.convProductName,
    this.xqtylead,
    this.convUnit,
    this.damageQty,
  });

  factory DamageDetailsModel.fromJson(Map<String, dynamic> json) => DamageDetailsModel(
    xrow: json["xrow"],
    xunit: json["xunit"],
    xitem: json["xitem"],
    productName: json["product_Name"],
    xprepqty: json["xprepqty"],
    xdphqty: json["xdphqty"],
    xnote: json["xnote"],
    xbrand: json["xbrand"],
    xitemconv: json["xitemconv"],
    convProductName: json["conv_product_Name"],
    xqtylead: json["xqtylead"],
    convUnit: json["conv_unit"],
    damageQty: json["damageQty"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xunit": xunit,
    "xitem": xitem,
    "product_Name": productName,
    "xprepqty": xprepqty,
    "xdphqty": xdphqty,
    "xnote": xnote,
    "xbrand": xbrand,
    "xitemconv": xitemconv,
    "conv_product_Name": convProductName,
    "xqtylead": xqtylead,
    "conv_unit": convUnit,
    "damageQty": damageQty,
  };
}
