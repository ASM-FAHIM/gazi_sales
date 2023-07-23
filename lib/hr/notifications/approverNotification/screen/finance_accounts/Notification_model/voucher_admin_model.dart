// To parse this JSON data, do
//
//     final voucherNoticationModel = voucherNoticationModelFromJson(jsonString);

import 'dart:convert';

List<VoucherNoticationModel> voucherNoticationModelFromJson(String str) =>
    List<VoucherNoticationModel>.from(
        json.decode(str).map((x) => VoucherNoticationModel.fromJson(x)));

String voucherNoticationModelToJson(List<VoucherNoticationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VoucherNoticationModel {
  VoucherNoticationModel({
    required this.xlong,
    required this.xvoucher,
    required this.xtrn,
    required this.xdate,
    required this.xref,
    required this.xlcno,
    required this.xwh,
    required this.xwhdec,
    required this.xchequeno,
    required this.xdatechq,
    required this.xbank,
    required this.bname,
    required this.xyear,
    required this.xper,
    required this.xstatus,
    required this.xstatusjv,
    required this.xnote,
    required this.preparer,
    required this.designation,
    required this.deptname,
    required this.signname,
    required this.signdesignation,
    required this.signdeptname,
  });

  String xlong;
  String xvoucher;
  String xtrn;
  String xdate;
  String xref;
  String xlcno;
  String xwh;
  String xwhdec;
  String xchequeno;
  String xdatechq;
  String xbank;
  dynamic bname;
  int xyear;
  int xper;
  String xstatus;
  String xstatusjv;
  String xnote;
  String preparer;
  String designation;
  String deptname;
  String signname;
  String signdesignation;
  String signdeptname;

  factory VoucherNoticationModel.fromJson(Map<String, dynamic> json) =>
      VoucherNoticationModel(
        xlong: json["xlong"] ?? ' ',
        xvoucher: json["xvoucher"] ?? ' ',
        xtrn: json["xtrn"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xref: json["xref"] ?? ' ',
        xlcno: json["xlcno"] ?? ' ',
        xwh: json["xwh"] ?? ' ',
        xwhdec: json["xwhdec"] ?? ' ',
        xchequeno: json["xchequeno"] ?? ' ',
        xdatechq: json["xdatechq"] ?? ' ',
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
