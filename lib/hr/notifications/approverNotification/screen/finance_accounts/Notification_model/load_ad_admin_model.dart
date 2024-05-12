// To parse this JSON data, do
//
//     final loanAdAdminModel = loanAdAdminModelFromJson(jsonString);

import 'dart:convert';

List<LoanAdAdminModel> loanAdAdminModelFromJson(String str) =>
    List<LoanAdAdminModel>.from(
        json.decode(str).map((x) => LoanAdAdminModel.fromJson(x)));

String loanAdAdminModelToJson(List<LoanAdAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanAdAdminModel {
  String xadjnum;
  String xvoucher;
  String xdate;
  String xtrn;
  String xloannum;
  String xtypeobj;
  String xprime;
  String xbank;
  String xbankdesc;
  String xacc;
  String xaccdesc;
  String xsub;
  String xsubdesc;
  String xstatus;
  String xstatusrdesc;
  String xstatusjv;
  String xstatusjvdesc;
  String xsign;
  String xnote;
  String xnote1;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  LoanAdAdminModel({
    required this.xadjnum,
    required this.xvoucher,
    required this.xdate,
    required this.xtrn,
    required this.xloannum,
    required this.xtypeobj,
    required this.xprime,
    required this.xbank,
    required this.xbankdesc,
    required this.xacc,
    required this.xaccdesc,
    required this.xsub,
    required this.xsubdesc,
    required this.xstatus,
    required this.xstatusrdesc,
    required this.xstatusjv,
    required this.xstatusjvdesc,
    required this.xsign,
    required this.xnote,
    required this.xnote1,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory LoanAdAdminModel.fromJson(Map<String, dynamic> json) =>
      LoanAdAdminModel(
        xadjnum: json["xadjnum"],
        xvoucher: json["xvoucher"],
        xdate: json["xdate"],
        xtrn: json["xtrn"],
        xloannum: json["xloannum"],
        xtypeobj: json["xtypeobj"],
        xprime: json["xprime"],
        xbank: json["xbank"],
        xbankdesc: json["xbankdesc"],
        xacc: json["xacc"],
        xaccdesc: json["xaccdesc"],
        xsub: json["xsub"],
        xsubdesc: json["xsubdesc"],
        xstatus: json["xstatus"],
        xstatusrdesc: json["xstatusrdesc"],
        xstatusjv: json["xstatusjv"],
        xstatusjvdesc: json["xstatusjvdesc"],
        xsign: json["xsign"],
        xnote: json["xnote"],
        xnote1: json["xnote1"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xadjnum": xadjnum,
        "xvoucher": xvoucher,
        "xdate": xdate,
        "xtrn": xtrn,
        "xloannum": xloannum,
        "xtypeobj": xtypeobj,
        "xprime": xprime,
        "xbank": xbank,
        "xbankdesc": xbankdesc,
        "xacc": xacc,
        "xaccdesc": xaccdesc,
        "xsub": xsub,
        "xsubdesc": xsubdesc,
        "xstatus": xstatus,
        "xstatusrdesc": xstatusrdesc,
        "xstatusjv": xstatusjv,
        "xstatusjvdesc": xstatusjvdesc,
        "xsign": xsign,
        "xnote": xnote,
        "xnote1": xnote1,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
