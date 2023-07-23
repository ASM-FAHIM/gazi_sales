// To parse this JSON data, do
//
//     final csNotiModel = csNotiModelFromJson(jsonString);

import 'dart:convert';

List<CsNotiModel> csNotiModelFromJson(String str) => List<CsNotiModel>.from(json.decode(str).map((x) => CsNotiModel.fromJson(x)));

String csNotiModelToJson(List<CsNotiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsNotiModel {
  CsNotiModel({
    required this.requisition,
    required this.xdate,
    required this.xregi,
    required this.xtwh,
    required this.name,
    required this.xstatusreq,
  });

  dynamic requisition;
  dynamic xdate;
  dynamic xregi;
  dynamic xtwh;
  dynamic name;
  dynamic xstatusreq;

  factory CsNotiModel.fromJson(Map<String, dynamic> json) => CsNotiModel(
    requisition: json["requisition"],
    xdate: json["xdate"],
    xregi: json["xregi"],
    xtwh: json["xtwh"],
    name: json["name"],
    xstatusreq: json["xstatusreq"],
  );

  Map<String, dynamic> toJson() => {
    "requisition": requisition,
    "xdate": xdate,
    "xregi": xregi,
    "xtwh": xtwh,
    "name": name,
    "xstatusreq": xstatusreq,
  };
}
