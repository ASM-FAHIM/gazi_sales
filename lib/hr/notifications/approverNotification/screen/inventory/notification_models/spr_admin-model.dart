// To parse this JSON data, do
//
//     final adminSprModel = adminSprModelFromJson(jsonString);

import 'dart:convert';

List<AdminSprModel> adminSprModelFromJson(String str) =>
    List<AdminSprModel>.from(
        json.decode(str).map((x) => AdminSprModel.fromJson(x)));

String adminSprModelToJson(List<AdminSprModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminSprModel {
  AdminSprModel({
    required this.xtornum,
    required this.xdate,
    required this.xtitem,
    required this.xtypeobj,
    required this.twhdesc,
    required this.preparer,
    required this.xstatustor,
    required this.xfwh,
    required this.xdatereq,
    required this.xref,
    required this.xlong,
    required this.xreqtype,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer1Xdeptname,
  });

  String xtornum;
  String xdate;
  String xtitem;
  String xtypeobj;
  String twhdesc;
  String preparer;
  String xstatustor;
  String xfwh;
  String xdatereq;
  String xref;
  String xlong;
  String xreqtype;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;

  factory AdminSprModel.fromJson(Map<String, dynamic> json) => AdminSprModel(
        xtornum: json["xtornum"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xtitem: json["xtitem"] ?? ' ',
        xtypeobj: json["xtypeobj"] ?? ' ',
        twhdesc: json["twhdesc"] ?? ' ',
        preparer: json["preparer"] ?? ' ',
        xstatustor: json["xstatustor"] ?? ' ',
        xfwh: json["xfwh"] ?? ' ',
        xdatereq: json["xdatereq"] ?? ' ',
        xref: json["xref"] ?? ' ',
        xlong: json["xlong"] ?? ' ',
        xreqtype: json["xreqtype"] ?? ' ',
        reviewer1Name: json["reviewer1_name"] ?? ' ',
        reviewer1Designation: json["reviewer1_designation"] ?? ' ',
        reviewer1Xdeptname: json["reviewer1_xdeptname"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xdate": xdate,
        "xtitem": xtitem,
        "xtypeobj": xtypeobj,
        "twhdesc": twhdesc,
        "preparer": preparer,
        "xstatustor": xstatustor,
        "xfwh": xfwh,
        "xdatereq": xdatereq,
        "xref": xref,
        "xlong": xlong,
        "xreqtype": xreqtype,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer1_xdeptname": reviewer1Xdeptname,
      };
}
