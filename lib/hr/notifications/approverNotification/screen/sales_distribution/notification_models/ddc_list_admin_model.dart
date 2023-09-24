// To parse this JSON data, do
//
//     final ddcListModel = ddcListModelFromJson(jsonString);

import 'dart:convert';

List<DdcListModel> ddcListModelFromJson(String str) => List<DdcListModel>.from(
    json.decode(str).map((x) => DdcListModel.fromJson(x)));

String ddcListModelToJson(List<DdcListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DdcListModel {
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
  String? statustordesc;
  String? preparerName;
  String? preparerXdesignation;
  String? preparerXdeptname;

  DdcListModel({
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
    this.statustordesc,
    this.preparerName,
    this.preparerXdesignation,
    this.preparerXdeptname,
  });

  factory DdcListModel.fromJson(Map<String, dynamic> json) => DdcListModel(
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
        statustordesc: json["statustordesc"],
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
        "statustordesc": statustordesc,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
