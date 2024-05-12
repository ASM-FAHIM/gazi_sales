// To parse this JSON data, do
//
//     final sqcDetailsModel = sqcDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SqcDetailsModel> sqcDetailsModelFromJson(String str) => List<SqcDetailsModel>.from(json.decode(str).map((x) => SqcDetailsModel.fromJson(x)));

String sqcDetailsModelToJson(List<SqcDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SqcDetailsModel {
  String? xrow;
  String? xunitpur;
  String? xitem;
  String? descr;
  String? xcpoqty;
  String? xqtygrn;
  String? xqtybonus;
  String? xdocrow;
  String? xlong;

  SqcDetailsModel({
    this.xrow,
    this.xunitpur,
    this.xitem,
    this.descr,
    this.xcpoqty,
    this.xqtygrn,
    this.xqtybonus,
    this.xdocrow,
    this.xlong,
  });

  factory SqcDetailsModel.fromJson(Map<String, dynamic> json) => SqcDetailsModel(
    xrow: json["xrow"],
    xunitpur: json["xunitpur"],
    xitem: json["xitem"],
    descr: json["descr"],
    xcpoqty: json["xcpoqty"],
    xqtygrn: json["xqtygrn"],
    xqtybonus: json["xqtybonus"],
    xdocrow: json["xdocrow"],
    xlong: json["xlong"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xunitpur": xunitpur,
    "xitem": xitem,
    "descr": descr,
    "xcpoqty": xcpoqty,
    "xqtygrn": xqtygrn,
    "xqtybonus": xqtybonus,
    "xdocrow": xdocrow,
    "xlong": xlong,
  };
}
