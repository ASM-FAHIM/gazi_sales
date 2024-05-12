// To parse this JSON data, do
//
//     final depoDcModel = depoDcModelFromJson(jsonString);

import 'dart:convert';

List<DepoDcModel> depoDcModelFromJson(String str) => List<DepoDcModel>.from(
    json.decode(str).map((x) => DepoDcModel.fromJson(x)));

String depoDcModelToJson(List<DepoDcModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepoDcModel {
  String? xdocnum;
  String? xdate;
  String? xfwh;
  String? xfwhdesc;
  String? xtwh;
  String? xtwhdesc;
  String? xtornum;
  String? xvehicle;
  String? xdrivername;
  String? xphone;
  String? xstatus;
  String? status;
  String? xstatusdoc;
  String? statusdoc;
  String? preparerName;
  String? preparerXdesignation;
  String? preparerXdeptname;

  DepoDcModel({
    this.xdocnum,
    this.xdate,
    this.xfwh,
    this.xfwhdesc,
    this.xtwh,
    this.xtwhdesc,
    this.xtornum,
    this.xvehicle,
    this.xdrivername,
    this.xphone,
    this.xstatus,
    this.status,
    this.xstatusdoc,
    this.statusdoc,
    this.preparerName,
    this.preparerXdesignation,
    this.preparerXdeptname,
  });

  factory DepoDcModel.fromJson(Map<String, dynamic> json) => DepoDcModel(
        xdocnum: json["xdocnum"],
        xdate: json["xdate"],
        xfwh: json["xfwh"],
        xfwhdesc: json["xfwhdesc"],
        xtwh: json["xtwh"],
        xtwhdesc: json["xtwhdesc"],
        xtornum: json["xtornum"],
        xvehicle: json["xvehicle"],
        xdrivername: json["xdrivername"],
        xphone: json["xphone"],
        xstatus: json["xstatus"],
        status: json["status"],
        xstatusdoc: json["xstatusdoc"],
        statusdoc: json["statusdoc"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xdocnum": xdocnum,
        "xdate": xdate,
        "xfwh": xfwh,
        "xfwhdesc": xfwhdesc,
        "xtwh": xtwh,
        "xtwhdesc": xtwhdesc,
        "xtornum": xtornum,
        "xvehicle": xvehicle,
        "xdrivername": xdrivername,
        "xphone": xphone,
        "xstatus": xstatus,
        "status": status,
        "xstatusdoc": xstatusdoc,
        "statusdoc": statusdoc,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
