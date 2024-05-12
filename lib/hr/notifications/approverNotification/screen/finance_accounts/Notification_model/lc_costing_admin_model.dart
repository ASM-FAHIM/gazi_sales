// To parse this JSON data, do
//
//     final lcCostingModel = lcCostingModelFromJson(jsonString);

import 'dart:convert';

List<LcCostingModel> lcCostingModelFromJson(String str) => List<LcCostingModel>.from(json.decode(str).map((x) => LcCostingModel.fromJson(x)));

String lcCostingModelToJson(List<LcCostingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LcCostingModel {
  String? xreqnum;
  String? xlcno;
  String? xdate;
  String? xlctype;
  String? xcus;
  String? xorg;
  String? xgrnnum;
  String? xtype;
  String? xcur;
  String? xexch;
  String? xstatus;
  String? statusdesc;
  String? xnote1;
  String? preparerName;
  String? preparerXdesignation;
  String? preparerXdeptname;

  LcCostingModel({
    this.xreqnum,
    this.xlcno,
    this.xdate,
    this.xlctype,
    this.xcus,
    this.xorg,
    this.xgrnnum,
    this.xtype,
    this.xcur,
    this.xexch,
    this.xstatus,
    this.statusdesc,
    this.xnote1,
    this.preparerName,
    this.preparerXdesignation,
    this.preparerXdeptname,
  });

  factory LcCostingModel.fromJson(Map<String, dynamic> json) => LcCostingModel(
    xreqnum: json["xreqnum"],
    xlcno: json["xlcno"],
    xdate: json["xdate"],
    xlctype: json["xlctype"],
    xcus: json["xcus"],
    xorg: json["xorg"],
    xgrnnum: json["xgrnnum"],
    xtype: json["xtype"],
    xcur: json["xcur"],
    xexch: json["xexch"],
    xstatus: json["xstatus"],
    statusdesc: json["statusdesc"],
    xnote1: json["xnote1"],
    preparerName: json["preparer_name"],
    preparerXdesignation: json["preparer_xdesignation"],
    preparerXdeptname: json["preparer_xdeptname"],
  );

  Map<String, dynamic> toJson() => {
    "xreqnum": xreqnum,
    "xlcno": xlcno,
    "xdate": xdate,
    "xlctype": xlctype,
    "xcus": xcus,
    "xorg": xorg,
    "xgrnnum": xgrnnum,
    "xtype": xtype,
    "xcur": xcur,
    "xexch": xexch,
    "xstatus": xstatus,
    "statusdesc": statusdesc,
    "xnote1": xnote1,
    "preparer_name": preparerName,
    "preparer_xdesignation": preparerXdesignation,
    "preparer_xdeptname": preparerXdeptname,
  };
}
