// To parse this JSON data, do
//
//     final padjNoticationModel = padjNoticationModelFromJson(jsonString);

import 'dart:convert';

List<PadjNoticationModel> padjNoticationModelFromJson(String str) =>
    List<PadjNoticationModel>.from(
        json.decode(str).map((x) => PadjNoticationModel.fromJson(x)));

String padjNoticationModelToJson(List<PadjNoticationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PadjNoticationModel {
  String zid;
  String xporeqnum;
  String xadvnum;
  String xdate;
  String xstatus;
  String statusName;
  String xstatusreq;
  String statusreqdesc;
  String xtypeobj;
  String xtype;
  String xfwh;
  String storeName;
  String xnote;
  String xstaff;
  String tornum;
  String xprime;
  String xnote1;
  String sname;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer2Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  PadjNoticationModel({
    required this.zid,
    required this.xporeqnum,
    required this.xadvnum,
    required this.xdate,
    required this.xstatus,
    required this.statusName,
    required this.xstatusreq,
    required this.statusreqdesc,
    required this.xtypeobj,
    required this.xtype,
    required this.xfwh,
    required this.storeName,
    required this.xnote,
    required this.xstaff,
    required this.tornum,
    required this.xprime,
    required this.xnote1,
    required this.sname,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer2Xdeptname,
    required this.reviewer2Name,
    required this.reviewer2Designation,
    required this.signrejectName,
    required this.signrejectDesignation,
    required this.signrejectXdeptname,
  });

  factory PadjNoticationModel.fromJson(Map<String, dynamic> json) =>
      PadjNoticationModel(
        zid: json["zid"],
        xporeqnum: json["xporeqnum"],
        xadvnum: json["xadvnum"],
        xdate: json["xdate"],
        xstatus: json["xstatus"],
        statusName: json["statusName"],
        xstatusreq: json["xstatusreq"],
        statusreqdesc: json["statusreqdesc"],
        xtypeobj: json["xtypeobj"],
        xtype: json["xtype"],
        xfwh: json["xfwh"],
        storeName: json["storeName"],
        xnote: json["xnote"],
        xstaff: json["xstaff"],
        tornum: json["tornum"],
        xprime: json["xprime"],
        xnote1: json["xnote1"],
        sname: json["sname"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
        reviewer1Name: json["reviewer1_name"],
        reviewer1Designation: json["reviewer1_designation"],
        reviewer2Xdeptname: json["reviewer2_xdeptname"],
        reviewer2Name: json["reviewer2_name"],
        reviewer2Designation: json["reviewer2_designation"],
        signrejectName: json["signreject_name"],
        signrejectDesignation: json["signreject_designation"],
        signrejectXdeptname: json["signreject_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xporeqnum": xporeqnum,
        "xadvnum": xadvnum,
        "xdate": xdate,
        "xstatus": xstatus,
        "statusName": statusName,
        "xstatusreq": xstatusreq,
        "statusreqdesc": statusreqdesc,
        "xtypeobj": xtypeobj,
        "xtype": xtype,
        "xfwh": xfwh,
        "storeName": storeName,
        "xnote": xnote,
        "xstaff": xstaff,
        "tornum": tornum,
        "xprime": xprime,
        "xnote1": xnote1,
        "sname": sname,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer2_xdeptname": reviewer2Xdeptname,
        "reviewer2_name": reviewer2Name,
        "reviewer2_designation": reviewer2Designation,
        "signreject_name": signrejectName,
        "signreject_designation": signrejectDesignation,
        "signreject_xdeptname": signrejectXdeptname,
      };
}
