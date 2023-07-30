// To parse this JSON data, do
//
//     final salesReturnDetailsModel = salesReturnDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SalesReturnDetailsModel> salesReturnDetailsModelFromJson(String str) =>
    List<SalesReturnDetailsModel>.from(
        json.decode(str).map((x) => SalesReturnDetailsModel.fromJson(x)));

String salesReturnDetailsModelToJson(List<SalesReturnDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalesReturnDetailsModel {
  String xrow;
  String xitem;
  String xdesc;
  String xqtyord;
  String xrate;
  String xcost;
  String xlineamt;

  SalesReturnDetailsModel({
    required this.xrow,
    required this.xitem,
    required this.xdesc,
    required this.xqtyord,
    required this.xrate,
    required this.xcost,
    required this.xlineamt,
  });

  factory SalesReturnDetailsModel.fromJson(Map<String, dynamic> json) =>
      SalesReturnDetailsModel(
        xrow: json["xrow"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        xqtyord: json["xqtyord"],
        xrate: json["xrate"],
        xcost: json["xcost"],
        xlineamt: json["xlineamt"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xitem": xitem,
        "xdesc": xdesc,
        "xqtyord": xqtyord,
        "xrate": xrate,
        "xcost": xcost,
        "xlineamt": xlineamt,
      };
}
