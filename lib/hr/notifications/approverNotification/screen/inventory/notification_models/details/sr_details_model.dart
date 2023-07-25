// To parse this JSON data, do
//
//     final srDetailsModel = srDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SrDetailsModel> srDetailsModelFromJson(String str) =>
    List<SrDetailsModel>.from(
        json.decode(str).map((x) => SrDetailsModel.fromJson(x)));

String srDetailsModelToJson(List<SrDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SrDetailsModel {
  String xrow;
  String xitem;
  String xdesc;
  String xqtyreq;
  String xdphqty;
  String xunit;

  SrDetailsModel({
    required this.xrow,
    required this.xitem,
    required this.xdesc,
    required this.xqtyreq,
    required this.xdphqty,
    required this.xunit,
  });

  factory SrDetailsModel.fromJson(Map<String, dynamic> json) => SrDetailsModel(
        xrow: json["xrow"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        xqtyreq: json["xqtyreq"],
        xdphqty: json["xdphqty"],
        xunit: json["xunit"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xitem": xitem,
        "xdesc": xdesc,
        "xqtyreq": xqtyreq,
        "xdphqty": xdphqty,
        "xunit": xunit,
      };
}
