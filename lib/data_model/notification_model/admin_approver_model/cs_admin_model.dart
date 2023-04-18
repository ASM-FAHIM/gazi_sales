// To parse this JSON data, do
//
//     final csModel = csModelFromJson(jsonString);

import 'dart:convert';

List<CsModel> csModelFromJson(String str) => List<CsModel>.from(json.decode(str).map((x) => CsModel.fromJson(x)));

String csModelToJson(List<CsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsModel {
  CsModel({
    required this.zid,
    required this.requisition,
    required this.xdate,
    required this.xregi,
    required this.xtwh,
    required this.name,
    required this.xstatusreq,
  });

  String zid;
  String requisition;
  String xdate;
  String xregi;
  String xtwh;
  String name;
  String xstatusreq;

  factory CsModel.fromJson(Map<String, dynamic> json) => CsModel(
    zid: json["zid"],
    requisition: json["requisition"],
    xdate: json["xdate"],
    xregi: json["xregi"],
    xtwh: json["xtwh"],
    name: json["name"],
    xstatusreq: json["xstatusreq"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "requisition": requisition,
    "xdate": xdate,
    "xregi": xregi,
    "xtwh": xtwh,
    "name": name,
    "xstatusreq": xstatusreq,
  };
}
