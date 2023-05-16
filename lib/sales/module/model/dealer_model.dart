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
    required this.zid,
    required this.xcus,
    required this.xorg,
    required this.xphone,
    required this.xmadd,
    required this.xgcus,
    required this.xterritory,
    required this.xcontact,
    required this.xmobile,
    required this.xtso,
    required this.xzone,
    required this.xzm,
    required this.xdivision,
    required this.xdm,
    required this.xthana,
    required this.xdistrict,
  });

  int? id;
  int zid;
  String xcus;
  String xorg;
  String xphone;
  String xmadd;
  String xgcus;
  String xterritory;
  String xcontact;
  String xmobile;
  String xtso;
  String xzone;
  String xzm;
  String xdivision;
  String xdm;
  String xthana;
  String xdistrict;

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json["id"],
        zid: json["zid"],
        xcus: json["xcus"],
        xorg: json["xorg"] ?? ' ',
        xphone: json["xphone"] ?? ' ',
        xmadd: json["xmadd"] ?? ' ',
        xgcus: json["xgcus"] ?? ' ',
        xterritory: json["xterritory"] ?? ' ',
        xcontact: json["xcontact"] ?? ' ',
        xmobile: json["xmobile"] ?? ' ',
        xtso: json["xtso"] ?? ' ',
        xzone: json["xzone"] ?? ' ',
        xzm: json["xzm"] ?? ' ',
        xdivision: json["xdivision"] ?? ' ',
        xdm: json["xdm"] ?? ' ',
        xthana: json["xthana"] ?? ' ',
        xdistrict: json["xdistrict"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xcus": xcus,
        "xorg": xorg,
        "xphone": xphone,
        "xmadd": xmadd,
        "xgcus": xgcus,
        "xterritory": xterritory,
        "xcontact": xcontact,
        "xmobile": xmobile,
        "xtso": xtso,
        "xzone": xzone,
        "xzm": xzm,
        "xdivision": xdivision,
        "xdm": xdm,
        "xthana": xthana,
        "xdistrict": xdistrict,
      };
}
