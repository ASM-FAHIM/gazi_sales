// To parse this JSON data, do
//
//     final pafNoticationModel = pafNoticationModelFromJson(jsonString);

import 'dart:convert';

List<PafNoticationModel> pafNoticationModelFromJson(String str) => List<PafNoticationModel>.from(json.decode(str).map((x) => PafNoticationModel.fromJson(x)));

String pafNoticationModelToJson(List<PafNoticationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PafNoticationModel {
  PafNoticationModel({
    required this.zid,
    required this.xsuperiorsp,
    required this.xsuperior2,
    required this.xpafnum,
    required this.xdate,
    required this.xpornum,
    required this.xsubmitdate,
    required this.xcus,
    required this.cusname,
    required this.xrem,
    required this.xstatusreq,
    required this.xnamegl,
    required this.xstatusvc,
    required this.xcostcentre,
    required this.xstatusdc,
    required this.xprime,
    required this.xstatusapn,
    required this.xfreightcost,
    required this.xvatamt,
    required this.xstatusgrn,
    required this.xtaxamt,
    required this.xstatuscap,
    required this.xprimetotamt,
    required this.xstatuswht,
    required this.xprimeadv,
    required this.xstatusvat,
    required this.xpaynow,
    required this.xstatusait,
    required this.totvattax,
    required this.totpayable,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer2Xdeptname,
    required this.reviewer2Name,
    required this.reviewer2Designation,
  });

  int zid;
  String xsuperiorsp;
  String xsuperior2;
  String xpafnum;
  String xdate;
  String xpornum;
  String xsubmitdate;
  String xcus;
  String cusname;
  String xrem;
  String xstatusreq;
  String xnamegl;
  String xstatusvc;
  String xcostcentre;
  String xstatusdc;
  String xprime;
  String xstatusapn;
  String xfreightcost;
  String xvatamt;
  String xstatusgrn;
  String xtaxamt;
  String xstatuscap;
  String xprimetotamt;
  String xstatuswht;
  String xprimeadv;
  String xstatusvat;
  String xpaynow;
  String xstatusait;
  String totvattax;
  String totpayable;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer2Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;

  factory PafNoticationModel.fromJson(Map<String, dynamic> json) => PafNoticationModel(
    zid: json["zid"] ?? " ",
    xsuperiorsp: json["xsuperiorsp"] ?? " ",
    xsuperior2: json["xsuperior2"] ?? " ",
    xpafnum: json["xpafnum"] ?? " ",
    xdate: json["xdate"] ?? " ",
    xpornum: json["xpornum"] ?? " ",
    xsubmitdate: json["xsubmitdate"] ?? " ",
    xcus: json["xcus"] ?? " ",
    cusname: json["cusname"] ?? " ",
    xrem: json["xrem"] ?? " ",
    xstatusreq: json["xstatusreq"] ?? " ",
    xnamegl: json["xnamegl"] ?? " ",
    xstatusvc: json["xstatusvc"] ?? " ",
    xcostcentre: json["xcostcentre"] ?? " ",
    xstatusdc: json["xstatusdc"] ?? " ",
    xprime: json["xprime"] ?? " ",
    xstatusapn: json["xstatusapn"] ?? " ",
    xfreightcost: json["xfreightcost"] ?? " ",
    xvatamt: json["xvatamt"] ?? " ",
    xstatusgrn: json["xstatusgrn"] ?? " ",
    xtaxamt: json["xtaxamt"] ?? " ",
    xstatuscap: json["xstatuscap"] ?? " ",
    xprimetotamt: json["xprimetotamt"] ?? " ",
    xstatuswht: json["xstatuswht"] ?? " ",
    xprimeadv: json["xprimeadv"] ?? " ",
    xstatusvat: json["xstatusvat"] ?? " ",
    xpaynow: json["xpaynow"] ?? " ",
    xstatusait: json["xstatusait"] ?? " ",
    totvattax: json["totvattax"] ?? " ",
    totpayable: json["totpayable"] ?? " ",
    preparerName: json["preparer_name"] ?? " ",
    preparerXdesignation: json["preparer_xdesignation"] ?? " ",
    preparerXdeptname: json["preparer_xdeptname"] ?? " ",
    reviewer1Name: json["reviewer1_name"] ?? " ",
    reviewer1Designation: json["reviewer1_designation"] ?? " ",
    reviewer2Xdeptname: json["reviewer2_xdeptname"] ?? " ",
    reviewer2Name: json["reviewer2_name"] ?? " ",
    reviewer2Designation: json["reviewer2_designation"] ?? " ",
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xsuperiorsp": xsuperiorsp,
    "xsuperior2": xsuperior2,
    "xpafnum": xpafnum,
    "xdate": xdate,
    "xpornum": xpornum,
    "xsubmitdate": xsubmitdate,
    "xcus": xcus,
    "cusname": cusname,
    "xrem": xrem,
    "xstatusreq": xstatusreq,
    "xnamegl": xnamegl,
    "xstatusvc": xstatusvc,
    "xcostcentre": xcostcentre,
    "xstatusdc": xstatusdc,
    "xprime": xprime,
    "xstatusapn": xstatusapn,
    "xfreightcost": xfreightcost,
    "xvatamt": xvatamt,
    "xstatusgrn": xstatusgrn,
    "xtaxamt": xtaxamt,
    "xstatuscap": xstatuscap,
    "xprimetotamt": xprimetotamt,
    "xstatuswht": xstatuswht,
    "xprimeadv": xprimeadv,
    "xstatusvat": xstatusvat,
    "xpaynow": xpaynow,
    "xstatusait": xstatusait,
    "totvattax": totvattax,
    "totpayable": totpayable,
    "preparer_name": preparerName,
    "preparer_xdesignation": preparerXdesignation,
    "preparer_xdeptname": preparerXdeptname,
    "reviewer1_name": reviewer1Name,
    "reviewer1_designation": reviewer1Designation,
    "reviewer2_xdeptname": reviewer2Xdeptname,
    "reviewer2_name": reviewer2Name,
    "reviewer2_designation": reviewer2Designation,
  };
}
