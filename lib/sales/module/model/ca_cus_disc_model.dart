// To parse this JSON data, do
//
//     final caCusDiscModel = caCusDiscModelFromJson(jsonString);

import 'dart:convert';

List<CaCusDiscModel> caCusDiscModelFromJson(String str) =>
    List<CaCusDiscModel>.from(
        json.decode(str).map((x) => CaCusDiscModel.fromJson(x)));

String caCusDiscModelToJson(List<CaCusDiscModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CaCusDiscModel {
  int? id;
  int zid;
  String xcus;
  String xitem;
  String xdisc;
  String xdateeff;
  String xdateexp;

  CaCusDiscModel({
    this.id,
    required this.zid,
    required this.xcus,
    required this.xitem,
    required this.xdisc,
    required this.xdateeff,
    required this.xdateexp,
  });

  factory CaCusDiscModel.fromJson(Map<String, dynamic> json) => CaCusDiscModel(
        id: json["id"],
        zid: json["zid"],
        xcus: json["xcus"],
        xitem: json["xitem"],
        xdisc: json["xdisc"],
        xdateeff: json["xdateeff"],
        xdateexp: json["xdateexp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xcus": xcus,
        "xitem": xitem,
        "xdisc": xdisc,
        "xdateeff": xdateeff,
        "xdateexp": xdateexp,
      };
}
