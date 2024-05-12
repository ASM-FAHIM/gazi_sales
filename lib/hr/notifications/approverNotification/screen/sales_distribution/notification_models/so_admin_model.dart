// To parse this JSON data, do
//
//     final soModel = soModelFromJson(jsonString);

import 'dart:convert';

List<SoModel> soModelFromJson(String str) => List<SoModel>.from(json.decode(str).map((x) => SoModel.fromJson(x)));

String soModelToJson(List<SoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoModel {
  String? xsonumber;
  String? xdate;
  String? xcus;
  String? cusname;
  String? xstatus;
  String? statusName;
  String? xterritory;
  String? xfwh;
  String? xwhdesc;
  String? xref;
  String? xdepositnum;
  String? xopincapply;
  String? xdisctype;
  String? xpnature;
  String? xdeliloc;
  String? tsoName;
  String? xtsoname;
  String? location;

  SoModel({
    this.xsonumber,
    this.xdate,
    this.xcus,
    this.cusname,
    this.xstatus,
    this.statusName,
    this.xterritory,
    this.xfwh,
    this.xwhdesc,
    this.xref,
    this.xdepositnum,
    this.xopincapply,
    this.xdisctype,
    this.xpnature,
    this.xdeliloc,
    this.tsoName,
    this.xtsoname,
    this.location,
  });

  factory SoModel.fromJson(Map<String, dynamic> json) => SoModel(
    xsonumber: json["xsonumber"],
    xdate: json["xdate"],
    xcus: json["xcus"],
    cusname: json["cusname"],
    xstatus: json["xstatus"],
    statusName: json["statusName"],
    xterritory: json["xterritory"],
    xfwh: json["xfwh"],
    xwhdesc: json["xwhdesc"],
    xref: json["xref"],
    xdepositnum: json["xdepositnum"],
    xopincapply: json["xopincapply"],
    xdisctype: json["xdisctype"],
    xpnature: json["xpnature"],
    xdeliloc: json["xdeliloc"],
    tsoName: json["tsoName"],
    xtsoname: json["xtsoname"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "xsonumber": xsonumber,
    "xdate": xdate,
    "xcus": xcus,
    "cusname": cusname,
    "xstatus": xstatus,
    "statusName": statusName,
    "xterritory": xterritory,
    "xfwh": xfwh,
    "xwhdesc": xwhdesc,
    "xref": xref,
    "xdepositnum": xdepositnum,
    "xopincapply": xopincapply,
    "xdisctype": xdisctype,
    "xpnature": xpnature,
    "xdeliloc": xdeliloc,
    "tsoName": tsoName,
    "xtsoname": xtsoname,
    "location": location,
  };
}
