// To parse this JSON data, do
//
//     final pendingSoModel = pendingSoModelFromJson(jsonString);

import 'dart:convert';

List<PendingSoModel> pendingSoModelFromJson(String str) =>
    List<PendingSoModel>.from(
        json.decode(str).map((x) => PendingSoModel.fromJson(x)));

String pendingSoModelToJson(List<PendingSoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingSoModel {
  int zid;
  String xsonumber;
  String xdate;
  String xcus;
  String xorg;
  String xitem;
  String xdesc;
  String soQty;
  String dcQty;
  String xpendingqty;
  String xpreclosedqty;

  PendingSoModel({
    required this.zid,
    required this.xsonumber,
    required this.xdate,
    required this.xcus,
    required this.xorg,
    required this.xitem,
    required this.xdesc,
    required this.soQty,
    required this.dcQty,
    required this.xpendingqty,
    required this.xpreclosedqty,
  });

  factory PendingSoModel.fromJson(Map<String, dynamic> json) => PendingSoModel(
        zid: json["zid"],
        xsonumber: json["xsonumber"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        xorg: json["xorg"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        soQty: json["SO_Qty"],
        dcQty: json["DC_QTY"],
        xpendingqty: json["xpendingqty"],
        xpreclosedqty: json["xpreclosedqty"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xsonumber": xsonumber,
        "xdate": xdate,
        "xcus": xcus,
        "xorg": xorg,
        "xitem": xitem,
        "xdesc": xdesc,
        "SO_Qty": soQty,
        "DC_QTY": dcQty,
        "xpendingqty": xpendingqty,
        "xpreclosedqty": xpreclosedqty,
      };
}
