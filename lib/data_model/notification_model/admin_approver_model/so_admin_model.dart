// To parse this JSON data, do
//
//     final soModel = soModelFromJson(jsonString);

import 'dart:convert';

List<SoModel> soModelFromJson(String str) => List<SoModel>.from(json.decode(str).map((x) => SoModel.fromJson(x)));

String soModelToJson(List<SoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoModel {
  SoModel({
    required this.zid,
    required this.org,
    required this.xidsup,
    required this.xtotamt,
    this.xnote1,
    this.xlong,
    required this.xterritory,
    required this.xtso,
    required this.xtsoname,
    required this.xsonumber,
    required this.cusname,
    required this.xstatusso,
    required this.xdatedel,
    required this.xdate,
  });

  int zid;
  String org;
  String xidsup;
  String xtotamt;
  dynamic xnote1;
  dynamic xlong;
  String xterritory;
  String xtso;
  String xtsoname;
  String xsonumber;
  String cusname;
  String xstatusso;
  String xdatedel;
  String xdate;

  factory SoModel.fromJson(Map<String, dynamic> json) => SoModel(
    zid: json["zid"],
    org: json["org"],
    xidsup: json["xidsup"],
    xtotamt: json["xtotamt"],
    xnote1: json["xnote1"],
    xlong: json["xlong"],
    xterritory: json["xterritory"],
    xtso: json["xtso"],
    xtsoname: json["xtsoname"],
    xsonumber: json["xsonumber"],
    cusname: json["cusname"],
    xstatusso: json["xstatusso"],
    xdatedel: json["xdatedel"],
    xdate: json["xdate"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "org": org,
    "xidsup": xidsup,
    "xtotamt": xtotamt,
    "xnote1": xnote1,
    "xlong": xlong,
    "xterritory": xterritory,
    "xtso": xtso,
    "xtsoname": xtsoname,
    "xsonumber": xsonumber,
    "cusname": cusname,
    "xstatusso": xstatusso,
    "xdatedel": xdatedel,
    "xdate": xdate,
  };
}
