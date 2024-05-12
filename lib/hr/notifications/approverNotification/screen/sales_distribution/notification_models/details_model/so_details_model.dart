// To parse this JSON data, do
//
//     final soDetailsModel = soDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SoDetailsModel> soDetailsModelFromJson(String str) => List<SoDetailsModel>.from(json.decode(str).map((x) => SoDetailsModel.fromJson(x)));

String soDetailsModelToJson(List<SoDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoDetailsModel {
  String? zid;
  String? xsonumber;
  String? xfwh;
  String? xitem;
  String? name;
  String? xqtyreq;
  String? xdphqty;
  String? xqtypor;
  String? xrate;
  String? xdisc;
  String? xdiscamt;
  String? xlineamt;
  String? xpartno;

  SoDetailsModel({
    this.zid,
    this.xsonumber,
    this.xfwh,
    this.xitem,
    this.name,
    this.xqtyreq,
    this.xdphqty,
    this.xqtypor,
    this.xrate,
    this.xdisc,
    this.xdiscamt,
    this.xlineamt,
    this.xpartno,
  });

  factory SoDetailsModel.fromJson(Map<String, dynamic> json) => SoDetailsModel(
    zid: json["zid"],
    xsonumber: json["xsonumber"],
    xfwh: json["xfwh"],
    xitem: json["xitem"],
    name: json["name"],
    xqtyreq: json["xqtyreq"],
    xdphqty: json["xdphqty"],
    xqtypor: json["xqtypor"],
    xrate: json["xrate"],
    xdisc: json["xdisc"],
    xdiscamt: json["xdiscamt"],
    xlineamt: json["xlineamt"],
    xpartno: json["xpartno"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xsonumber": xsonumber,
    "xfwh": xfwh,
    "xitem": xitem,
    "name": name,
    "xqtyreq": xqtyreq,
    "xdphqty": xdphqty,
    "xqtypor": xqtypor,
    "xrate": xrate,
    "xdisc": xdisc,
    "xdiscamt": xdiscamt,
    "xlineamt": xlineamt,
    "xpartno": xpartno,
  };
}
