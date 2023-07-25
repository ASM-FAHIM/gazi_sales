// To parse this JSON data, do
//
//     final boMdetailsModel = boMdetailsModelFromJson(jsonString);

import 'dart:convert';

List<BoMdetailsModel> boMdetailsModelFromJson(String str) =>
    List<BoMdetailsModel>.from(
        json.decode(str).map((x) => BoMdetailsModel.fromJson(x)));

String boMdetailsModelToJson(List<BoMdetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoMdetailsModel {
  String xbomrow;
  String xbomcomp;
  String xdesc;
  String xwh;
  String xqtymix;
  String xunit;
  String xstype;

  BoMdetailsModel({
    required this.xbomrow,
    required this.xbomcomp,
    required this.xdesc,
    required this.xwh,
    required this.xqtymix,
    required this.xunit,
    required this.xstype,
  });

  factory BoMdetailsModel.fromJson(Map<String, dynamic> json) =>
      BoMdetailsModel(
        xbomrow: json["xbomrow"],
        xbomcomp: json["xbomcomp"],
        xdesc: json["xdesc"],
        xwh: json["xwh"],
        xqtymix: json["xqtymix"],
        xunit: json["xunit"],
        xstype: json["xstype"],
      );

  Map<String, dynamic> toJson() => {
        "xbomrow": xbomrow,
        "xbomcomp": xbomcomp,
        "xdesc": xdesc,
        "xwh": xwh,
        "xqtymix": xqtymix,
        "xunit": xunit,
        "xstype": xstype,
      };
}
