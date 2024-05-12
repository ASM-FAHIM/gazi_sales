// To parse this JSON data, do
//
//     final batDetailsModel = batDetailsModelFromJson(jsonString);

import 'dart:convert';

List<BatDetailsModel> batDetailsModelFromJson(String str) =>
    List<BatDetailsModel>.from(
        json.decode(str).map((x) => BatDetailsModel.fromJson(x)));

String batDetailsModelToJson(List<BatDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatDetailsModel {
  String xbomrow;
  String xbatch;
  String xitem;
  String xdesc;
  String xqtyreq;
  String unit;
  String xavail;
  String xsstype;

  BatDetailsModel({
    required this.xbomrow,
    required this.xbatch,
    required this.xitem,
    required this.xdesc,
    required this.xqtyreq,
    required this.unit,
    required this.xavail,
    required this.xsstype,
  });

  factory BatDetailsModel.fromJson(Map<String, dynamic> json) =>
      BatDetailsModel(
        xbomrow: json["xbomrow"],
        xbatch: json["xbatch"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        xqtyreq: json["xqtyreq"],
        unit: json["unit"],
        xavail: json["xavail"],
        xsstype: json["xsstype"],
      );

  Map<String, dynamic> toJson() => {
        "xbomrow": xbomrow,
        "xbatch": xbatch,
        "xitem": xitem,
        "xdesc": xdesc,
        "xqtyreq": xqtyreq,
        "unit": unit,
        "xavail": xavail,
        "xsstype": xsstype,
      };
}
