// To parse this JSON data, do
//
//     final poAdminModel = poAdminModelFromJson(jsonString);

import 'dart:convert';

List<PoAdminModel> poAdminModelFromJson(String str) => List<PoAdminModel>.from(json.decode(str).map((x) => PoAdminModel.fromJson(x)));

String poAdminModelToJson(List<PoAdminModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoAdminModel {
  PoAdminModel({
    required this.xpornum,
    required this.xdate,
    required this.xempunit,
    required this.xstatus,
    required this.cusdesc,
    required this.xcus,
    required this.xtype,
    required this.povalue,
    required this.xporeqnum,
    required this.xstatuspor,
    required this.xtotqty,
    required this.xtotval,
    required this.xtypeobj,
    this.xrem,
    required this.xcur,
    required this.prepname,
    this.xdesignation,
    required this.xdeptname,
    this.pname,
    this.reviewer1Name,
    this.reviewer1Designation,
    this.reviewer1Xdeptname,
  });

  String xpornum;
  String xdate;
  String xempunit;
  String xstatus;
  String cusdesc;
  String xcus;
  String xtype;
  String povalue;
  String xporeqnum;
  String xstatuspor;
  String xtotqty;
  String xtotval;
  String xtypeobj;
  dynamic xrem;
  String xcur;
  String prepname;
  dynamic xdesignation;
  String xdeptname;
  dynamic pname;
  dynamic reviewer1Name;
  dynamic reviewer1Designation;
  dynamic reviewer1Xdeptname;

  factory PoAdminModel.fromJson(Map<String, dynamic> json) => PoAdminModel(
    xpornum: json["xpornum"],
    xdate: json["xdate"],
    xempunit: json["xempunit"] ?? ' ',
    xstatus: json["xstatus"],
    cusdesc: json["cusdesc"],
    xcus: json["xcus"],
    xtype: json["xtype"],
    povalue: json["povalue"],
    xporeqnum: json["xporeqnum"],
    xstatuspor: json["xstatuspor"],
    xtotqty: json["xtotqty"],
    xtotval: json["xtotval"],
    xtypeobj: json["xtypeobj"] ?? ' ',
    xrem: json["xrem"] ?? ' ',
    xcur: json["xcur"],
    prepname: json["prepname"],
    xdesignation: json["xdesignation"] ?? ' ',
    xdeptname: json["xdeptname"],
    pname: json["pname"] ?? ' ',
    reviewer1Name: json["reviewer1_name"] ?? ' ',
    reviewer1Designation: json["reviewer1_designation"] ?? ' ',
    reviewer1Xdeptname: json["reviewer1_xdeptname"] ?? ' ',
  );

  Map<String, dynamic> toJson() => {
    "xpornum": xpornum,
    "xdate": xdate,
    "xempunit": xempunit,
    "xstatus": xstatus,
    "cusdesc": cusdesc,
    "xcus": xcus,
    "xtype": xtype,
    "povalue": povalue,
    "xporeqnum": xporeqnum,
    "xstatuspor": xstatuspor,
    "xtotqty": xtotqty,
    "xtotval": xtotval,
    "xtypeobj": xtypeobj,
    "xrem": xrem,
    "xcur": xcur,
    "prepname": prepname,
    "xdesignation": xdesignation,
    "xdeptname": xdeptname,
    "pname": pname,
    "reviewer1_name": reviewer1Name,
    "reviewer1_designation": reviewer1Designation,
    "reviewer1_xdeptname": reviewer1Xdeptname,
  };
}
