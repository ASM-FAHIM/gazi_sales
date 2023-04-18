// To parse this JSON data, do
//
//     final dealerModel = dealerModelFromJson(jsonString);

import 'dart:convert';

List<DealerModel> dealerModelFromJson(String str) => List<DealerModel>.from(
    json.decode(str).map((x) => DealerModel.fromJson(x)));

String dealerModelToJson(List<DealerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealerModel {
  DealerModel({
    this.id,
    this.zid,
    required this.xso,
    required this.xsp,
    required this.xcus,
    required this.xorg,
    required this.xmadd,
    required this.xterritory,
    required this.xfield,
    required this.xphone,
    required this.xgcus,
    required this.xdateeff,
    required this.xdateexp,
  });

  int? id;
  int? zid;
  String xso;
  String xsp;
  String xcus;
  String xorg;
  String xmadd;
  String xterritory;
  String xfield;
  String xphone;
  String xgcus;
  String xdateeff;
  String xdateexp;

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json["id"],
        zid: json["zid"],
        xso: json["xso"] ?? ' ',
        xsp: json["xsp"] ?? ' ',
        xcus: json["xcus"] ?? ' ',
        xorg: json["xorg"] ?? ' ',
        xmadd: json["xmadd"] ?? ' ',
        xterritory: json["xterritory"] ?? ' ',
        xfield: json["xfield"] ?? ' ',
        xphone: json["xphone"] ?? ' ',
        xgcus: json["xgcus"] ?? ' ',
        xdateeff: json["xdateeff"] ?? ' ',
        xdateexp: json["xdateexp"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xso": xso,
        "xsp": xsp,
        "xcus": xcus,
        "xorg": xorg,
        "xmadd": xmadd,
        "xterritory": xterritory,
        "xfield": xfield,
        "xphone": xphone,
        "xgcus": xgcus,
        "xdateeff": xdateeff,
        "xdateexp": xdateexp,
      };
}
