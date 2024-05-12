// To parse this JSON data, do
//
//     final grnDetailsModel = grnDetailsModelFromJson(jsonString);

import 'dart:convert';

List<GrnDetailsModel> grnDetailsModelFromJson(String str) =>
    List<GrnDetailsModel>.from(
        json.decode(str).map((x) => GrnDetailsModel.fromJson(x)));

String grnDetailsModelToJson(List<GrnDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrnDetailsModel {
  String xgrnnum;
  String xrow;
  String xunitpur;
  String xitem;
  String descr;
  String xcpoqty;
  String xqtygrn;
  String xqtybonus;
  String xdocrow;
  String xlong;

  GrnDetailsModel({
    required this.xgrnnum,
    required this.xrow,
    required this.xunitpur,
    required this.xitem,
    required this.descr,
    required this.xcpoqty,
    required this.xqtygrn,
    required this.xqtybonus,
    required this.xdocrow,
    required this.xlong,
  });

  factory GrnDetailsModel.fromJson(Map<String, dynamic> json) =>
      GrnDetailsModel(
        xgrnnum: json["xgrnnum"],
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
        "xgrnnum": xgrnnum,
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
