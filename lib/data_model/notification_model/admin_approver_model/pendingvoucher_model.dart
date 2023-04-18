// To parse this JSON data, do
//
//     final pendingvoucherModel = pendingvoucherModelFromJson(jsonString);

import 'dart:convert';

List<PendingvoucherModel> pendingvoucherModelFromJson(String str) => List<PendingvoucherModel>.from(json.decode(str).map((x) => PendingvoucherModel.fromJson(x)));

String pendingvoucherModelToJson(List<PendingvoucherModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingvoucherModel {
  PendingvoucherModel({
    this.xlong,
    this.xvoucher,
    this.xtrn,
    this.xdate,
    this.xref,
    this.xlcno,
    this.xwh,
    this.xwhdec,
    this.xchequeno,
    this.xdatechq,
    this.xbank,
    this.bname,
    this.xyear,
    this.xper,
    this.xstatus,
    this.xstatusjv,
    this.xnote,
    this.preparer,
    this.designation,
    this.deptname,
    this.signname,
    this.signdesignation,
    this.signdeptname,
  });

  String? xlong;
  String? xvoucher;
  String? xtrn;
  String? xdate;
  String? xref;
  String? xlcno;
  String? xwh;
  String? xwhdec;
  String? xchequeno;
  String? xdatechq;
  String? xbank;
  dynamic bname;
  int? xyear;
  int? xper;
  String? xstatus;
  String? xstatusjv;
  String? xnote;
  String? preparer;
  dynamic designation;
  dynamic deptname;
  dynamic signname;
  dynamic signdesignation;
  dynamic signdeptname;

  factory PendingvoucherModel.fromJson(Map<String, dynamic> json) => PendingvoucherModel(
    xlong: json["xlong"],
    xvoucher: json["xvoucher"],
    xtrn: json["xtrn"],
    xdate: json["xdate"],
    xref: json["xref"],
    xlcno: json["xlcno"],
    xwh: json["xwh"],
    xwhdec: json["xwhdec"],
    xchequeno: json["xchequeno"],
    xdatechq: json["xdatechq"],
    xbank: json["xbank"] ?? ' ',
    bname: json["bname"] ?? ' ',
    xyear: json["xyear"] ?? ' ',
    xper: json["xper"] ?? ' ',
    xstatus: json["xstatus"] ?? ' ',
    xstatusjv: json["xstatusjv"] ?? ' ',
    xnote: json["xnote"] ?? ' ',
    preparer: json["preparer"] ?? ' ',
    designation: json["designation"] ?? ' ',
    deptname: json["deptname"] ?? ' ',
    signname: json["signname"] ?? ' ',
    signdesignation: json["signdesignation"] ?? ' ',
    signdeptname: json["signdeptname"] ?? ' ',
  );

  Map<String, dynamic> toJson() => {
    "xlong": xlong,
    "xvoucher": xvoucher,
    "xtrn": xtrn,
    "xdate": xdate,
    "xref": xref,
    "xlcno": xlcno,
    "xwh": xwh,
    "xwhdec": xwhdec,
    "xchequeno": xchequeno,
    "xdatechq": xdatechq,
    "xbank": xbank,
    "bname": bname,
    "xyear": xyear,
    "xper": xper,
    "xstatus": xstatus,
    "xstatusjv": xstatusjv,
    "xnote": xnote,
    "preparer": preparer,
    "designation": designation,
    "deptname": deptname,
    "signname": signname,
    "signdesignation": signdesignation,
    "signdeptname": signdeptname,
  };
}
