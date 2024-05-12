// To parse this JSON data, do
//
//     final stOdetailsModel = stOdetailsModelFromJson(jsonString);

import 'dart:convert';

List<StOdetailsModel> stOdetailsModelFromJson(String str) =>
    List<StOdetailsModel>.from(
        json.decode(str).map((x) => StOdetailsModel.fromJson(x)));

String stOdetailsModelToJson(List<StOdetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StOdetailsModel {
  String xtornum;
  String xrow;
  String xunit;
  String xitem;
  String productName;
  String xprepqty;
  String xdphqty;
  String xnote;

  StOdetailsModel({
    required this.xtornum,
    required this.xrow,
    required this.xunit,
    required this.xitem,
    required this.productName,
    required this.xprepqty,
    required this.xdphqty,
    required this.xnote,
  });

  factory StOdetailsModel.fromJson(Map<String, dynamic> json) =>
      StOdetailsModel(
        xtornum: json["xtornum"],
        xrow: json["xrow"],
        xunit: json["xunit"],
        xitem: json["xitem"],
        productName: json["product_Name"],
        xprepqty: json["xprepqty"],
        xdphqty: json["xdphqty"],
        xnote: json["xnote"],
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xrow": xrow,
        "xunit": xunit,
        "xitem": xitem,
        "product_Name": productName,
        "xprepqty": xprepqty,
        "xdphqty": xdphqty,
        "xnote": xnote,
      };
}
