// To parse this JSON data, do
//
//     final exeChangeModel = exeChangeModelFromJson(jsonString);

import 'dart:convert';

List<ExeChangeModel> exeChangeModelFromJson(String str) => List<ExeChangeModel>.from(json.decode(str).map((x) => ExeChangeModel.fromJson(x)));

String exeChangeModelToJson(List<ExeChangeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExeChangeModel {
  String? zid;
  String? xrow;
  String? xdate;
  String? xfstaff;
  String? tstaff;
  String? xstaff;
  String? staff;
  String? xtype;
  String? xpfeffdate;
  String? xterritory;
  String? xzone;
  String? xdivision;
  String? xstatus;
  String? status;

  ExeChangeModel({
    this.zid,
    this.xrow,
    this.xdate,
    this.xfstaff,
    this.tstaff,
    this.xstaff,
    this.staff,
    this.xtype,
    this.xpfeffdate,
    this.xterritory,
    this.xzone,
    this.xdivision,
    this.xstatus,
    this.status,
  });

  factory ExeChangeModel.fromJson(Map<String, dynamic> json) => ExeChangeModel(
    zid: json["zid"],
    xrow: json["xrow"],
    xdate: json["xdate"],
    xfstaff: json["xfstaff"],
    tstaff: json["tstaff"],
    xstaff: json["xstaff"],
    staff: json["staff"],
    xtype: json["xtype"],
    xpfeffdate: json["xpfeffdate"],
    xterritory: json["xterritory"],
    xzone: json["xzone"],
    xdivision: json["xdivision"],
    xstatus: json["xstatus"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xrow": xrow,
    "xdate": xdate,
    "xfstaff": xfstaff,
    "tstaff": tstaff,
    "xstaff": xstaff,
    "staff": staff,
    "xtype": xtype,
    "xpfeffdate": xpfeffdate,
    "xterritory": xterritory,
    "xzone": xzone,
    "xdivision": xdivision,
    "xstatus": xstatus,
    "status": status,
  };
}
