// To parse this JSON data, do
//
//     final ddcDetailsModel = ddcDetailsModelFromJson(jsonString);

import 'dart:convert';

List<DdcDetailsModel> ddcDetailsModelFromJson(String str) =>
    List<DdcDetailsModel>.from(
        json.decode(str).map((x) => DdcDetailsModel.fromJson(x)));

String ddcDetailsModelToJson(List<DdcDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DdcDetailsModel {
  String? xrow;
  String? xunit;
  String? xitem;
  String? descp;
  String? xqtycom;
  String? xqtylead;
  String? xqtycrn;
  String? xnote;

  DdcDetailsModel({
    this.xrow,
    this.xunit,
    this.xitem,
    this.descp,
    this.xqtycom,
    this.xqtylead,
    this.xqtycrn,
    this.xnote,
  });

  factory DdcDetailsModel.fromJson(Map<String, dynamic> json) =>
      DdcDetailsModel(
        xrow: json["xrow"],
        xunit: json["xunit"],
        xitem: json["xitem"],
        descp: json["descp"],
        xqtycom: json["xqtycom"],
        xqtylead: json["xqtylead"],
        xqtycrn: json["xqtycrn"],
        xnote: json["xnote"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xunit": xunit,
        "xitem": xitem,
        "descp": descp,
        "xqtycom": xqtycom,
        "xqtylead": xqtylead,
        "xqtycrn": xqtycrn,
        "xnote": xnote,
      };
}
