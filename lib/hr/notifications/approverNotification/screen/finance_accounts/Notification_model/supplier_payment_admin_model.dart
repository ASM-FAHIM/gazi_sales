// To parse this JSON data, do
//
//     final pendingPmModel = pendingPmModelFromJson(jsonString);

import 'dart:convert';

List<PendingPmModel> pendingPmModelFromJson(String str) =>
    List<PendingPmModel>.from(
        json.decode(str).map((x) => PendingPmModel.fromJson(x)));

String pendingPmModelToJson(List<PendingPmModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingPmModel {
  String xvoucher;
  String xprime;
  String xcusdesc;
  String xdate;
  String xarnature;
  String xref;
  String xcus;
  String xorg;
  String xdateref;
  String xbank;
  String xbankname;
  String xcur;
  String xaccdr;
  String xaccdrdesc;
  String xnote;
  String xtypeobj;
  String xwh;
  String xexch;
  String xbase;
  String xpaymenttype;
  String xwhdesc;
  String xvatamt;
  String xaitamt;
  String xdocnum;
  String xpornum;
  String xstatusmr;
  String xstatusmrdesc;
  String xstatusjv;
  String xstatusjvdesc;
  String xcusledbal;
  String xtypetrn;
  String xpobalance;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  PendingPmModel({
    required this.xvoucher,
    required this.xprime,
    required this.xcusdesc,
    required this.xdate,
    required this.xarnature,
    required this.xref,
    required this.xcus,
    required this.xorg,
    required this.xdateref,
    required this.xbank,
    required this.xbankname,
    required this.xcur,
    required this.xaccdr,
    required this.xaccdrdesc,
    required this.xnote,
    required this.xtypeobj,
    required this.xwh,
    required this.xexch,
    required this.xbase,
    required this.xpaymenttype,
    required this.xwhdesc,
    required this.xvatamt,
    required this.xaitamt,
    required this.xdocnum,
    required this.xpornum,
    required this.xstatusmr,
    required this.xstatusmrdesc,
    required this.xstatusjv,
    required this.xstatusjvdesc,
    required this.xcusledbal,
    required this.xtypetrn,
    required this.xpobalance,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory PendingPmModel.fromJson(Map<String, dynamic> json) => PendingPmModel(
        xvoucher: json["xvoucher"],
        xprime: json["xprime"],
        xcusdesc: json["xcusdesc"],
        xdate: json["xdate"],
        xarnature: json["xarnature"],
        xref: json["xref"],
        xcus: json["xcus"],
        xorg: json["xorg"],
        xdateref: json["xdateref"],
        xbank: json["xbank"],
        xbankname: json["xbankname"],
        xcur: json["xcur"],
        xaccdr: json["xaccdr"],
        xaccdrdesc: json["xaccdrdesc"],
        xnote: json["xnote"],
        xtypeobj: json["xtypeobj"],
        xwh: json["xwh"],
        xexch: json["xexch"],
        xbase: json["xbase"],
        xpaymenttype: json["xpaymenttype"],
        xwhdesc: json["xwhdesc"],
        xvatamt: json["xvatamt"],
        xaitamt: json["xaitamt"],
        xdocnum: json["xdocnum"],
        xpornum: json["xpornum"],
        xstatusmr: json["xstatusmr"],
        xstatusmrdesc: json["xstatusmrdesc"],
        xstatusjv: json["xstatusjv"],
        xstatusjvdesc: json["xstatusjvdesc"],
        xcusledbal: json["xcusledbal"],
        xtypetrn: json["xtypetrn"],
        xpobalance: json["xpobalance"],
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
        "xref": xref,
        "xcus": xcus,
        "xorg": xorg,
        "xdateref": xdateref,
        "xbank": xbank,
        "xbankname": xbankname,
        "xcur": xcur,
        "xaccdr": xaccdr,
        "xaccdrdesc": xaccdrdesc,
        "xnote": xnote,
        "xtypeobj": xtypeobj,
        "xwh": xwh,
        "xexch": xexch,
        "xbase": xbase,
        "xpaymenttype": xpaymenttype,
        "xwhdesc": xwhdesc,
        "xvatamt": xvatamt,
        "xaitamt": xaitamt,
        "xdocnum": xdocnum,
        "xpornum": xpornum,
        "xstatusmr": xstatusmr,
        "xstatusmrdesc": xstatusmrdesc,
        "xstatusjv": xstatusjv,
        "xstatusjvdesc": xstatusjvdesc,
        "xcusledbal": xcusledbal,
        "xtypetrn": xtypetrn,
        "xpobalance": xpobalance,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
