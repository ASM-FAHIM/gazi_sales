// To parse this JSON data, do
//
//     final territoryListModel = territoryListModelFromJson(jsonString);

import 'dart:convert';

List<TerritoryListModel> territoryListModelFromJson(String str) => List<TerritoryListModel>.from(json.decode(str).map((x) => TerritoryListModel.fromJson(x)));

String territoryListModelToJson(List<TerritoryListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TerritoryListModel {
  int zid;
  String xterritory;
  String xtso;
  String xzone;
  String xzm;
  String xdivision;
  String xdm;

  TerritoryListModel({
    required this.zid,
    required this.xterritory,
    required this.xtso,
    required this.xzone,
    required this.xzm,
    required this.xdivision,
    required this.xdm,
  });

  factory TerritoryListModel.fromJson(Map<String, dynamic> json) => TerritoryListModel(
    zid: json["zid"],
    xterritory: json["xterritory"],
    xtso: json["xtso"],
    xzone: json["xzone"],
    xzm: json["xzm"],
    xdivision: json["xdivision"],
    xdm: json["xdm"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xterritory": xterritory,
    "xtso": xtso,
    "xzone": xzone,
    "xzm": xzm,
    "xdivision": xdivision,
    "xdm": xdm,
  };
}
