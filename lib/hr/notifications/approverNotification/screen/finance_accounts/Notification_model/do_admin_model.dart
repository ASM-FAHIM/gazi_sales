// To parse this JSON data, do
//
//     final doModel = doModelFromJson(jsonString);

import 'dart:convert';

List<DoModel> doModelFromJson(String str) =>
    List<DoModel>.from(json.decode(str).map((x) => DoModel.fromJson(x)));

String doModelToJson(List<DoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoModel {
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
  String bname;
  String xyear;
  String xper;
  String xstatus;
  String xstatusrdesc;
  String xstatusjv;
  String xxstatusjvdesc;
  String xnote;
  String preparer;
  String designation;
  String deptname;
  String signname;
  String signdesignation;
  String signdeptname;

  DoModel({
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
    required this.xstatusrdesc,
    required this.xstatusjv,
    required this.xxstatusjvdesc,
    required this.xnote,
    required this.preparer,
    required this.designation,
    required this.deptname,
    required this.signname,
    required this.signdesignation,
    required this.signdeptname,
  });

  factory DoModel.fromJson(Map<String, dynamic> json) => DoModel(
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
        xbank: json["xbank"],
        bname: json["bname"],
        xyear: json["xyear"],
        xper: json["xper"],
        xstatus: json["xstatus"],
        xstatusrdesc: json["xstatusrdesc"],
        xstatusjv: json["xstatusjv"],
        xxstatusjvdesc: json["xxstatusjvdesc"],
        xnote: json["xnote"],
        preparer: json["preparer"],
        designation: json["designation"],
        deptname: json["deptname"],
        signname: json["signname"],
        signdesignation: json["signdesignation"],
        signdeptname: json["signdeptname"],
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
        "xstatusrdesc": xstatusrdesc,
        "xstatusjv": xstatusjv,
        "xxstatusjvdesc": xxstatusjvdesc,
        "xnote": xnote,
        "preparer": preparer,
        "designation": designation,
        "deptname": deptname,
        "signname": signname,
        "signdesignation": signdesignation,
        "signdeptname": signdeptname,
      };
}
