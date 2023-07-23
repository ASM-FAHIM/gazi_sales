// To parse this JSON data, do
//
//     final poNotificationModel = poNotificationModelFromJson(jsonString);

import 'dart:convert';

PoNotificationModel poNotificationModelFromJson(String str) =>
    PoNotificationModel.fromJson(json.decode(str));

String poNotificationModelToJson(PoNotificationModel data) =>
    json.encode(data.toJson());

class PoNotificationModel {
  PoNotificationModel({
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
    required this.xrem,
    required this.prepname,
    required this.xdesignation,
    required this.xdeptname,
    required this.pname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer1Xdeptname,
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
  String xrem;
  String prepname;
  String xdesignation;
  String xdeptname;
  String pname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;

  factory PoNotificationModel.fromJson(Map<String, dynamic> json) =>
      PoNotificationModel(
        xpornum: json["xpornum"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xempunit: json["xempunit"] ?? ' ',
        xstatus: json["xstatus"] ?? ' ',
        cusdesc: json["cusdesc"] ?? ' ',
        xcus: json["xcus"] ?? ' ',
        xtype: json["xtype"] ?? ' ',
        povalue: json["povalue"] ?? ' ',
        xporeqnum: json["xporeqnum"] ?? ' ',
        xstatuspor: json["xstatuspor"] ?? ' ',
        xtotqty: json["xtotqty"] ?? ' ',
        xtotval: json["xtotval"] ?? ' ',
        xtypeobj: json["xtypeobj"] ?? ' ',
        xrem: json["xrem"] ?? ' ',
        prepname: json["prepname"] ?? ' ',
        xdesignation: json["xdesignation"] ?? ' ',
        xdeptname: json["xdeptname"] ?? ' ',
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
        "prepname": prepname,
        "xdesignation": xdesignation,
        "xdeptname": xdeptname,
        "pname": pname,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer1_xdeptname": reviewer1Xdeptname,
      };
}
