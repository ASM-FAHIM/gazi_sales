// To parse this JSON data, do
//
//     final cashDetailsModel = cashDetailsModelFromJson(jsonString);

import 'dart:convert';

List<CashDetailsModel> cashDetailsModelFromJson(String str) =>
    List<CashDetailsModel>.from(
        json.decode(str).map((x) => CashDetailsModel.fromJson(x)));

String cashDetailsModelToJson(List<CashDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashDetailsModel {
  CashDetailsModel({
    required this.xrow,
    required this.xitem,
    required this.xdesc,
    required this.xbrand,
    required this.xqtyreq,
    required this.xqtyapv,
    required this.xunitpur,
    required this.xrate,
    required this.xlineamt,
  });

  int xrow;
  String xitem;
  String xdesc;
  String xbrand;
  String xqtyreq;
  String xqtyapv;
  String xunitpur;
  String xrate;
  String xlineamt;

  factory CashDetailsModel.fromJson(Map<String, dynamic> json) =>
      CashDetailsModel(
        xrow: json["xrow"] ?? " ",
        xitem: json["xitem"] ?? " ",
        xdesc: json["xdesc"] ?? " ",
        xbrand: json["xbrand"] ?? " ",
        xqtyreq: json["xqtyreq"] ?? " ",
        xqtyapv: json["xqtyapv"] ?? " ",
        xunitpur: json["xunitpur"] ?? " ",
        xrate: json["xrate"] ?? " ",
        xlineamt: json["xlineamt"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xitem": xitem,
        "xdesc": xdesc,
        "xbrand": xbrand,
        "xqtyreq": xqtyreq,
        "xqtyapv": xqtyapv,
        "xunitpur": xunitpur,
        "xrate": xrate,
        "xlineamt": xlineamt,
      };
}
