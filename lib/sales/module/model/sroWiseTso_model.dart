// To parse this JSON data, do
//
//     final sroWiseTsoModel = sroWiseTsoModelFromJson(jsonString);

import 'dart:convert';

List<SroWiseTsoModel> sroWiseTsoModelFromJson(String str) => List<SroWiseTsoModel>.from(json.decode(str).map((x) => SroWiseTsoModel.fromJson(x)));

String sroWiseTsoModelToJson(List<SroWiseTsoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SroWiseTsoModel {
  SroWiseTsoModel({
    required this.zid,
    required this.xterritory,
    required this.xsp,
    required this.xso,
    required this.name,
    required this.xrole,
  });

  int zid;
  String xterritory;
  String xsp;
  String xso;
  String name;
  String xrole;

  factory SroWiseTsoModel.fromJson(Map<String, dynamic> json) => SroWiseTsoModel(
    zid: json["zid"],
    xterritory: json["xterritory"],
    xsp: json["xsp"],
    xso: json["xso"],
    name: json["name"],
    xrole: json["xrole"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xterritory": xterritory,
    "xsp": xsp,
    "xso": xso,
    "name": name,
    "xrole": xrole,
  };
}
