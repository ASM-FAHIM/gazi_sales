// To parse this JSON data, do
//
//     final rrDetailsModel = rrDetailsModelFromJson(jsonString);

import 'dart:convert';

List<RrDetailsModel> rrDetailsModelFromJson(String str) =>
    List<RrDetailsModel>.from(
        json.decode(str).map((x) => RrDetailsModel.fromJson(x)));

String rrDetailsModelToJson(List<RrDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RrDetailsModel {
  String xrow;
  String xunit;
  String xitem;
  String productName;
  String xprepqty;
  String xdphqty;
  String xnote;

  RrDetailsModel({
    required this.xrow,
    required this.xunit,
    required this.xitem,
    required this.productName,
    required this.xprepqty,
    required this.xdphqty,
    required this.xnote,
  });

  factory RrDetailsModel.fromJson(Map<String, dynamic> json) => RrDetailsModel(
        xrow: json["xrow"],
        xunit: json["xunit"],
        xitem: json["xitem"],
        productName: json["product_Name"],
        xprepqty: json["xprepqty"],
        xdphqty: json["xdphqty"],
        xnote: json["xnote"],
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
