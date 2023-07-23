// To parse this JSON data, do
//
//     final pafDetailsModel = pafDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PafDetailsModel> pafDetailsModelFromJson(String str) =>
    List<PafDetailsModel>.from(
        json.decode(str).map((x) => PafDetailsModel.fromJson(x)));

String pafDetailsModelToJson(List<PafDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PafDetailsModel {
  PafDetailsModel({
    required this.xrow,
    required this.xgrnnum,
    required this.xlineamt,
    required this.xamtother,
    required this.xprnamt,
    required this.total,
    required this.xnote,
  });

  int xrow;
  String xgrnnum;
  String xlineamt;
  String xamtother;
  String xprnamt;
  String total;
  String xnote;

  factory PafDetailsModel.fromJson(Map<String, dynamic> json) =>
      PafDetailsModel(
        xrow: json["xrow"] ?? " ",
        xgrnnum: json["xgrnnum"] ?? " ",
        xlineamt: json["xlineamt"] ?? " ",
        xamtother: json["xamtother"] ?? " ",
        xprnamt: json["xprnamt"] ?? " ",
        total: json["total"] ?? " ",
        xnote: json["xnote"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xgrnnum": xgrnnum,
        "xlineamt": xlineamt,
        "xamtother": xamtother,
        "xprnamt": xprnamt,
        "total": total,
        "xnote": xnote,
      };
}
