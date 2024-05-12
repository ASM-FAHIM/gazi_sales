// To parse this JSON data, do
//
//     final caCusPriceModel = caCusPriceModelFromJson(jsonString);

import 'dart:convert';

List<CaCusPriceModel> caCusPriceModelFromJson(String str) => List<CaCusPriceModel>.from(json.decode(str).map((x) => CaCusPriceModel.fromJson(x)));

String caCusPriceModelToJson(List<CaCusPriceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaCusPriceModel {
  CaCusPriceModel({
    this.id,
    required this.xrow,
    required this.xcus,
    required this.xitem,
    required this.xrate,
    required this.xcost,
    required this.xdateeff,
    required this.xdateexp,
  });

  int? id;
  int xrow;
  String xcus;
  String xitem;
  int xrate;
  String xcost;
  String xdateeff;
  String xdateexp;

  factory CaCusPriceModel.fromJson(Map<String, dynamic> json) => CaCusPriceModel(
    id: json["id"],
    xrow: json["xrow"],
    xcus: json["xcus"],
    xitem: json["xitem"],
    xrate: json["xrate"],
    xcost: json["xcost"],
    xdateeff: json["xdateeff"],
    xdateexp: json["xdateexp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "xrow": xrow,
    "xcus": xcus,
    "xitem": xitem,
    "xrate": xrate,
    "xcost": xcost,
    "xdateeff": xdateeff,
    "xdateexp": xdateexp,
  };
}
