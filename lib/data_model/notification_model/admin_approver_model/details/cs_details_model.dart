// To parse this JSON data, do
//
//     final csDetailsModel = csDetailsModelFromJson(jsonString);

import 'dart:convert';

List<CsDetailsModel> csDetailsModelFromJson(String str) =>
    List<CsDetailsModel>.from(
        json.decode(str).map((x) => CsDetailsModel.fromJson(x)));

String csDetailsModelToJson(List<CsDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsDetailsModel {
  String xrow;
  String xqotnum;
  String xporeqnum;
  String xitem;
  String productName;
  String xunitpur;
  String xqtyreq;
  String xrate;
  String xratenegotiate;

  CsDetailsModel({
    required this.xrow,
    required this.xqotnum,
    required this.xporeqnum,
    required this.xitem,
    required this.productName,
    required this.xunitpur,
    required this.xqtyreq,
    required this.xrate,
    required this.xratenegotiate,
  });

  factory CsDetailsModel.fromJson(Map<String, dynamic> json) => CsDetailsModel(
        xrow: json["xrow"],
        xqotnum: json["xqotnum"],
        xporeqnum: json["xporeqnum"],
        xitem: json["xitem"],
        productName: json["product_Name"],
        xunitpur: json["xunitpur"],
        xqtyreq: json["xqtyreq"],
        xrate: json["xrate"],
        xratenegotiate: json["xratenegotiate"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xqotnum": xqotnum,
        "xporeqnum": xporeqnum,
        "xitem": xitem,
        "product_Name": productName,
        "xunitpur": xunitpur,
        "xqtyreq": xqtyreq,
        "xrate": xrate,
        "xratenegotiate": xratenegotiate,
      };
}
