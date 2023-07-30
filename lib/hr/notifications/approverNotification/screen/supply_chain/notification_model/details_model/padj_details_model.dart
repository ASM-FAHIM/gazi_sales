// To parse this JSON data, do
//
//     final padjDetailsModel = padjDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PadjDetailsModel> padjDetailsModelFromJson(String str) =>
    List<PadjDetailsModel>.from(
        json.decode(str).map((x) => PadjDetailsModel.fromJson(x)));

String padjDetailsModelToJson(List<PadjDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PadjDetailsModel {
  String xrow;
  String xgrnnum;
  String xitem;
  String xdesc;
  String xlineamt;

  PadjDetailsModel({
    required this.xrow,
    required this.xgrnnum,
    required this.xitem,
    required this.xdesc,
    required this.xlineamt,
  });

  factory PadjDetailsModel.fromJson(Map<String, dynamic> json) =>
      PadjDetailsModel(
        xrow: json["xrow"],
        xgrnnum: json["xgrnnum"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        xlineamt: json["xlineamt"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xgrnnum": xgrnnum,
        "xitem": xitem,
        "xdesc": xdesc,
        "xlineamt": xlineamt,
      };
}
