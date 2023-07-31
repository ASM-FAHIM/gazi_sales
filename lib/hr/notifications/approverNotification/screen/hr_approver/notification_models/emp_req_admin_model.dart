// To parse this JSON data, do
//
//     final empReqAdminModel = empReqAdminModelFromJson(jsonString);

import 'dart:convert';

List<EmpReqAdminModel> empReqAdminModelFromJson(String str) =>
    List<EmpReqAdminModel>.from(
        json.decode(str).map((x) => EmpReqAdminModel.fromJson(x)));

String empReqAdminModelToJson(List<EmpReqAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpReqAdminModel {
  String xpdreqnum;
  String xwh;
  String xdate;
  String xdeptname;
  String xdeadcountb;
  String xpositiondesc;
  String xdeadcounta;
  String xpositiontype;
  String xsalbudget;
  String xstaff;
  String staffn;
  String xlocation;
  String xemptype;
  String xadvertise;
  String xstatusreq;
  String xstatusreqdesc;
  String xrequirement;
  String xpropdate;
  String xmotive;
  String xsalprop;
  String xtransfer;
  String xbenefit;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  EmpReqAdminModel({
    required this.xpdreqnum,
    required this.xwh,
    required this.xdate,
    required this.xdeptname,
    required this.xdeadcountb,
    required this.xpositiondesc,
    required this.xdeadcounta,
    required this.xpositiontype,
    required this.xsalbudget,
    required this.xstaff,
    required this.staffn,
    required this.xlocation,
    required this.xemptype,
    required this.xadvertise,
    required this.xstatusreq,
    required this.xstatusreqdesc,
    required this.xrequirement,
    required this.xpropdate,
    required this.xmotive,
    required this.xsalprop,
    required this.xtransfer,
    required this.xbenefit,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory EmpReqAdminModel.fromJson(Map<String, dynamic> json) =>
      EmpReqAdminModel(
        xpdreqnum: json["xpdreqnum"],
        xwh: json["xwh"],
        xdate: json["xdate"],
        xdeptname: json["xdeptname"],
        xdeadcountb: json["xdeadcountb"],
        xpositiondesc: json["xpositiondesc"],
        xdeadcounta: json["xdeadcounta"],
        xpositiontype: json["xpositiontype"],
        xsalbudget: json["xsalbudget"],
        xstaff: json["xstaff"],
        staffn: json["staffn"],
        xlocation: json["xlocation"],
        xemptype: json["xemptype"],
        xadvertise: json["xadvertise"],
        xstatusreq: json["xstatusreq"],
        xstatusreqdesc: json["xstatusreqdesc"],
        xrequirement: json["xrequirement"],
        xpropdate: json["xpropdate"],
        xmotive: json["xmotive"],
        xsalprop: json["xsalprop"],
        xtransfer: json["xtransfer"],
        xbenefit: json["xbenefit"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xpdreqnum": xpdreqnum,
        "xwh": xwh,
        "xdate": xdate,
        "xdeptname": xdeptname,
        "xdeadcountb": xdeadcountb,
        "xpositiondesc": xpositiondesc,
        "xdeadcounta": xdeadcounta,
        "xpositiontype": xpositiontype,
        "xsalbudget": xsalbudget,
        "xstaff": xstaff,
        "staffn": staffn,
        "xlocation": xlocation,
        "xemptype": xemptype,
        "xadvertise": xadvertise,
        "xstatusreq": xstatusreq,
        "xstatusreqdesc": xstatusreqdesc,
        "xrequirement": xrequirement,
        "xpropdate": xpropdate,
        "xmotive": xmotive,
        "xsalprop": xsalprop,
        "xtransfer": xtransfer,
        "xbenefit": xbenefit,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
