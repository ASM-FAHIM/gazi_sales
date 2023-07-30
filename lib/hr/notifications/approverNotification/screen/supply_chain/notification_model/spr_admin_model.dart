// To parse this JSON data, do
//
//     final sprModel = sprModelFromJson(jsonString);

import 'dart:convert';

List<SprModel> sprModelFromJson(String str) => List<SprModel>.from(json.decode(str).map((x) => SprModel.fromJson(x)));

String sprModelToJson(List<SprModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SprModel {
  String xtornum;
  String xdate;
  String xtitem;
  String xtypeobj;
  String twhdesc;
  String preparer;
  String xstatustor;
  String statusName;
  String xfwh;
  String xdatereq;
  String xref;
  String xlong;
  String xreqtype;
  String xpriority;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;

  SprModel({
    required this.xtornum,
    required this.xdate,
    required this.xtitem,
    required this.xtypeobj,
    required this.twhdesc,
    required this.preparer,
    required this.xstatustor,
    required this.statusName,
    required this.xfwh,
    required this.xdatereq,
    required this.xref,
    required this.xlong,
    required this.xreqtype,
    required this.xpriority,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer1Xdeptname,
  });

  factory SprModel.fromJson(Map<String, dynamic> json) => SprModel(
    xtornum: json["xtornum"],
    xdate: json["xdate"],
    xtitem: json["xtitem"],
    xtypeobj: json["xtypeobj"],
    twhdesc: json["twhdesc"],
    preparer: json["preparer"],
    xstatustor: json["xstatustor"],
    statusName: json["statusName"],
    xfwh: json["xfwh"],
    xdatereq: json["xdatereq"],
    xref: json["xref"],
    xlong: json["xlong"],
    xreqtype: json["xreqtype"],
    xpriority: json["xpriority"],
    reviewer1Name: json["reviewer1_name"],
    reviewer1Designation: json["reviewer1_designation"],
    reviewer1Xdeptname: json["reviewer1_xdeptname"],
  );

  Map<String, dynamic> toJson() => {
    "xtornum": xtornum,
    "xdate": xdate,
    "xtitem": xtitem,
    "xtypeobj": xtypeobj,
    "twhdesc": twhdesc,
    "preparer": preparer,
    "xstatustor": xstatustor,
    "statusName": statusName,
    "xfwh": xfwh,
    "xdatereq": xdatereq,
    "xref": xref,
    "xlong": xlong,
    "xreqtype": xreqtype,
    "xpriority": xpriority,
    "reviewer1_name": reviewer1Name,
    "reviewer1_designation": reviewer1Designation,
    "reviewer1_xdeptname": reviewer1Xdeptname,
  };
}
