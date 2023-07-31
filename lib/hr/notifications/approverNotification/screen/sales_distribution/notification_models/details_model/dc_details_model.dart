// To parse this JSON data, do
//
//     final dcDetailsModel = dcDetailsModelFromJson(jsonString);

import 'dart:convert';

List<DcDetailsModel> dcDetailsModelFromJson(String str) =>
    List<DcDetailsModel>.from(
        json.decode(str).map((x) => DcDetailsModel.fromJson(x)));

String dcDetailsModelToJson(List<DcDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DcDetailsModel {
  String xrow;
  String xitem;
  String xdesc;
  String xqtyord;
  String xunit;
  String xrate;
  String xlineamt;
  String xvatamt;
  String xnetamt;
  String xdiscdet;
  String xdiscdetamt;

  DcDetailsModel({
    required this.xrow,
    required this.xitem,
    required this.xdesc,
    required this.xqtyord,
    required this.xunit,
    required this.xrate,
    required this.xlineamt,
    required this.xvatamt,
    required this.xnetamt,
    required this.xdiscdet,
    required this.xdiscdetamt,
  });

  factory DcDetailsModel.fromJson(Map<String, dynamic> json) => DcDetailsModel(
        xrow: json["xrow"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        xqtyord: json["xqtyord"],
        xunit: json["xunit"],
        xrate: json["xrate"],
        xlineamt: json["xlineamt"],
        xvatamt: json["xvatamt"],
        xnetamt: json["xnetamt"],
        xdiscdet: json["xdiscdet"],
        xdiscdetamt: json["xdiscdetamt"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xitem": xitem,
        "xdesc": xdesc,
        "xqtyord": xqtyord,
        "xunit": xunit,
        "xrate": xrate,
        "xlineamt": xlineamt,
        "xvatamt": xvatamt,
        "xnetamt": xnetamt,
        "xdiscdet": xdiscdet,
        "xdiscdetamt": xdiscdetamt,
      };
}
