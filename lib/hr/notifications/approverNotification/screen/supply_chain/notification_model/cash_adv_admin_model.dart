// To parse this JSON data, do
//
//     final cashAdvNotificationModel = cashAdvNotificationModelFromJson(jsonString);

import 'dart:convert';

List<CashAdvNotificationModel> cashAdvNotificationModelFromJson(String str) =>
    List<CashAdvNotificationModel>.from(
        json.decode(str).map((x) => CashAdvNotificationModel.fromJson(x)));

String cashAdvNotificationModelToJson(List<CashAdvNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashAdvNotificationModel {
  String zid;
  String xporeqnum;
  String xdate;
  String xstatus;
  String statusName;
  String xstatusreq;
  String xstatusreqDesc;
  String xtypeobj;
  String xtype;
  String xtwh;
  String storeName;
  String xnote;
  String xnote1;
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

  CashAdvNotificationModel({
    required this.zid,
    required this.xporeqnum,
    required this.xdate,
    required this.xstatus,
    required this.statusName,
    required this.xstatusreq,
    required this.xstatusreqDesc,
    required this.xtypeobj,
    required this.xtype,
    required this.xtwh,
    required this.storeName,
    required this.xnote,
    required this.xnote1,
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

  factory CashAdvNotificationModel.fromJson(Map<String, dynamic> json) =>
      CashAdvNotificationModel(
        zid: json["zid"],
        xporeqnum: json["xporeqnum"],
        xdate: json["xdate"],
        xstatus: json["xstatus"],
        statusName: json["statusName"],
        xstatusreq: json["xstatusreq"],
        xstatusreqDesc: json["xstatusreqDesc"],
        xtypeobj: json["xtypeobj"],
        xtype: json["xtype"],
        xtwh: json["xtwh"],
        storeName: json["storeName"],
        xnote: json["xnote"],
        xnote1: json["xnote1"],
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
        "xdate": xdate,
        "xstatus": xstatus,
        "statusName": statusName,
        "xstatusreq": xstatusreq,
        "xstatusreqDesc": xstatusreqDesc,
        "xtypeobj": xtypeobj,
        "xtype": xtype,
        "xtwh": xtwh,
        "storeName": storeName,
        "xnote": xnote,
        "xnote1": xnote1,
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
