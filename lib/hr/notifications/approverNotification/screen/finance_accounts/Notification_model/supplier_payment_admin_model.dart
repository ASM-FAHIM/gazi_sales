// To parse this JSON data, do
//
//     final pendingPmModel = pendingPmModelFromJson(jsonString);

import 'dart:convert';

List<PendingPmModel> pendingPmModelFromJson(String str) => List<PendingPmModel>.from(json.decode(str).map((x) => PendingPmModel.fromJson(x)));

String pendingPmModelToJson(List<PendingPmModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingPmModel {
  String? xvoucher;
  String? xprime;
  String? xcusdesc;
  String? xdate;
  String? xarnature;
  String? xref;
  String? xcus;
  String? xorg;
  String? xdateref;
  String? xbank;
  String? xbankname;
  String? xcur;
  String? xaccdr;
  String? xaccdrdesc;
  String? xnote;
  String? xtypeobj;
  String? xwh;
  String? xexch;
  String? xbase;
  String? xpaymenttype;
  String? xsub;
  String? xsubdesc;
  String? xwhdesc;
  String? xvatamt;
  String? xaitamt;
  String? xdocnum;
  String? xpornum;
  String? xstatusmr;
  String? xstatusmrdesc;
  String? xstatusjv;
  String? xstatusjvdesc;
  String? xcusledbal;
  String? xtypetrn;
  String? xpobalance;
  String? preparerName;
  String? preparerXdesignation;
  String? preparerXdeptname;

  PendingPmModel({
    this.xvoucher,
    this.xprime,
    this.xcusdesc,
    this.xdate,
    this.xarnature,
    this.xref,
    this.xcus,
    this.xorg,
    this.xdateref,
    this.xbank,
    this.xbankname,
    this.xcur,
    this.xaccdr,
    this.xaccdrdesc,
    this.xnote,
    this.xtypeobj,
    this.xwh,
    this.xexch,
    this.xbase,
    this.xpaymenttype,
    this.xsub,
    this.xsubdesc,
    this.xwhdesc,
    this.xvatamt,
    this.xaitamt,
    this.xdocnum,
    this.xpornum,
    this.xstatusmr,
    this.xstatusmrdesc,
    this.xstatusjv,
    this.xstatusjvdesc,
    this.xcusledbal,
    this.xtypetrn,
    this.xpobalance,
    this.preparerName,
    this.preparerXdesignation,
    this.preparerXdeptname,
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
    xsub: json["xsub"],
    xsubdesc: json["xsubdesc"],
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
    "xsub": xsub,
    "xsubdesc": xsubdesc,
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
