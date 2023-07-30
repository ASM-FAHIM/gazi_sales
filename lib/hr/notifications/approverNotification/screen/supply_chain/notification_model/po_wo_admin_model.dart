// To parse this JSON data, do
//
//     final poAdminModel = poAdminModelFromJson(jsonString);

import 'dart:convert';

List<PoAdminModel> poAdminModelFromJson(String str) => List<PoAdminModel>.from(
    json.decode(str).map((x) => PoAdminModel.fromJson(x)));

String poAdminModelToJson(List<PoAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoAdminModel {
  String xidsup;
  String xpornum;
  String xdate;
  String xempunit;
  String xstatus;
  String statusName;
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
  String xcur;
  String xvatamt;
  String xvatrate;
  String prepname;
  String xdesignation;
  String xdeptname;
  String pname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;

  PoAdminModel({
    required this.xidsup,
    required this.xpornum,
    required this.xdate,
    required this.xempunit,
    required this.xstatus,
    required this.statusName,
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
    required this.xcur,
    required this.xvatamt,
    required this.xvatrate,
    required this.prepname,
    required this.xdesignation,
    required this.xdeptname,
    required this.pname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer1Xdeptname,
  });

  factory PoAdminModel.fromJson(Map<String, dynamic> json) => PoAdminModel(
        xidsup: json["xidsup"],
        xpornum: json["xpornum"],
        xdate: json["xdate"],
        xempunit: json["xempunit"],
        xstatus: json["xstatus"],
        statusName: json["statusName"],
        cusdesc: json["cusdesc"],
        xcus: json["xcus"],
        xtype: json["xtype"],
        povalue: json["povalue"],
        xporeqnum: json["xporeqnum"],
        xstatuspor: json["xstatuspor"],
        xtotqty: json["xtotqty"],
        xtotval: json["xtotval"],
        xtypeobj: json["xtypeobj"],
        xrem: json["xrem"],
        xcur: json["xcur"],
        xvatamt: json["xvatamt"],
        xvatrate: json["xvatrate"],
        prepname: json["prepname"],
        xdesignation: json["xdesignation"],
        xdeptname: json["xdeptname"],
        pname: json["pname"],
        reviewer1Name: json["reviewer1_name"],
        reviewer1Designation: json["reviewer1_designation"],
        reviewer1Xdeptname: json["reviewer1_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xidsup": xidsup,
        "xpornum": xpornum,
        "xdate": xdate,
        "xempunit": xempunit,
        "xstatus": xstatus,
        "statusName": statusName,
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
        "xvatamt": xvatamt,
        "xvatrate": xvatrate,
        "prepname": prepname,
        "xdesignation": xdesignation,
        "xdeptname": xdeptname,
        "pname": pname,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer1_xdeptname": reviewer1Xdeptname,
      };
}
