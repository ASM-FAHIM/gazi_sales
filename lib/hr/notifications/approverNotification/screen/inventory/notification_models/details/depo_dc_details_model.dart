// To parse this JSON data, do
//
//     final depoDcDetailsModel = depoDcDetailsModelFromJson(jsonString);

import 'dart:convert';

List<DepoDcDetailsModel> depoDcDetailsModelFromJson(String str) =>
    List<DepoDcDetailsModel>.from(
        json.decode(str).map((x) => DepoDcDetailsModel.fromJson(x)));

String depoDcDetailsModelToJson(List<DepoDcDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepoDcDetailsModel {
  String? xrow;
  String? xunit;
  String? xitem;
  String? descp;
  String? xqtyord;
  String? xnote;

  DepoDcDetailsModel({
    this.xrow,
    this.xunit,
    this.xitem,
    this.descp,
    this.xqtyord,
    this.xnote,
  });

  factory DepoDcDetailsModel.fromJson(Map<String, dynamic> json) =>
      DepoDcDetailsModel(
        xrow: json["xrow"],
        xunit: json["xunit"],
        xitem: json["xitem"],
        descp: json["descp"],
        xqtyord: json["xqtyord"],
        xnote: json["xnote"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xunit": xunit,
        "xitem": xitem,
        "descp": descp,
        "xqtyord": xqtyord,
        "xnote": xnote,
      };
}
