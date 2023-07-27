// To parse this JSON data, do
//
//     final pendingMrModel = pendingMrModelFromJson(jsonString);

import 'dart:convert';

List<PendingMrModel> pendingMrModelFromJson(String str) =>
    List<PendingMrModel>.from(
        json.decode(str).map((x) => PendingMrModel.fromJson(x)));

String pendingMrModelToJson(List<PendingMrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingMrModel {
  String xvoucher;
  String xprime;
  String xcusdesc;
  String xdate;
  String xarnature;
  String xcus;
  String xorg;
  String xpaymenttype;
  String xbank;
  String xbankname;
  String xtypeobj;
  String xwh;
  String xwhdesc;
  String xbalprime;
  String xvatamt;
  String xref;
  String xdateref;
  String xaitamt;
  String xstatusmr;
  String xstatusmrdesc;
  String xstatusjv;
  String xstatusjvdesc;
  String xdocnum;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  PendingMrModel({
    required this.xvoucher,
    required this.xprime,
    required this.xcusdesc,
    required this.xdate,
    required this.xarnature,
    required this.xcus,
    required this.xorg,
    required this.xpaymenttype,
    required this.xbank,
    required this.xbankname,
    required this.xtypeobj,
    required this.xwh,
    required this.xwhdesc,
    required this.xbalprime,
    required this.xvatamt,
    required this.xref,
    required this.xdateref,
    required this.xaitamt,
    required this.xstatusmr,
    required this.xstatusmrdesc,
    required this.xstatusjv,
    required this.xstatusjvdesc,
    required this.xdocnum,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory PendingMrModel.fromJson(Map<String, dynamic> json) => PendingMrModel(
        xvoucher: json["xvoucher"],
        xprime: json["xprime"],
        xcusdesc: json["xcusdesc"],
        xdate: json["xdate"],
        xarnature: json["xarnature"],
        xcus: json["xcus"],
        xorg: json["xorg"],
        xpaymenttype: json["xpaymenttype"],
        xbank: json["xbank"],
        xbankname: json["xbankname"],
        xtypeobj: json["xtypeobj"],
        xwh: json["xwh"],
        xwhdesc: json["xwhdesc"],
        xbalprime: json["xbalprime"],
        xvatamt: json["xvatamt"],
        xref: json["xref"],
        xdateref: json["xdateref"],
        xaitamt: json["xaitamt"],
        xstatusmr: json["xstatusmr"],
        xstatusmrdesc: json["xstatusmrdesc"],
        xstatusjv: json["xstatusjv"],
        xstatusjvdesc: json["xstatusjvdesc"],
        xdocnum: json["xdocnum"],
        xnote: json["xnote"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xvoucher": xvoucher,
        "xprime": xprime,
        "xcusdesc": xcusdesc,
        "xdate": xdate,
        "xarnature": xarnature,
        "xcus": xcus,
        "xorg": xorg,
        "xpaymenttype": xpaymenttype,
        "xbank": xbank,
        "xbankname": xbankname,
        "xtypeobj": xtypeobj,
        "xwh": xwh,
        "xwhdesc": xwhdesc,
        "xbalprime": xbalprime,
        "xvatamt": xvatamt,
        "xref": xref,
        "xdateref": xdateref,
        "xaitamt": xaitamt,
        "xstatusmr": xstatusmr,
        "xstatusmrdesc": xstatusmrdesc,
        "xstatusjv": xstatusjv,
        "xstatusjvdesc": xstatusjvdesc,
        "xdocnum": xdocnum,
        "xnote": xnote,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
