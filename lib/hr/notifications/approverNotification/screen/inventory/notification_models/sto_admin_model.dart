// To parse this JSON data, do
//
//     final stoAdminModel = stoAdminModelFromJson(jsonString);

import 'dart:convert';

List<StoAdminModel> stoAdminModelFromJson(String str) =>
    List<StoAdminModel>.from(
        json.decode(str).map((x) => StoAdminModel.fromJson(x)));

String stoAdminModelToJson(List<StoAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoAdminModel {
  String zid;
  String xtornum;
  String xporeqnum;
  String xdate;
  String xdatereq;
  String xfwh;
  String xfbrname;
  String xtwh;
  String xtbrname;
  String xpriority;
  String regidesc;
  String xprodnaturedesc;
  String xlong;
  String twhdesc;
  String xstatustor;
  String xstatusrdesc;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  StoAdminModel({
    required this.zid,
    required this.xtornum,
    required this.xporeqnum,
    required this.xdate,
    required this.xdatereq,
    required this.xfwh,
    required this.xfbrname,
    required this.xtwh,
    required this.xtbrname,
    required this.xpriority,
    required this.regidesc,
    required this.xprodnaturedesc,
    required this.xlong,
    required this.twhdesc,
    required this.xstatustor,
    required this.xstatusrdesc,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory StoAdminModel.fromJson(Map<String, dynamic> json) => StoAdminModel(
        zid: json["zid"],
        xtornum: json["xtornum"],
        xporeqnum: json["xporeqnum"],
        xdate: json["xdate"],
        xdatereq: json["xdatereq"],
        xfwh: json["xfwh"],
        xfbrname: json["xfbrname"],
        xtwh: json["xtwh"],
        xtbrname: json["xtbrname"],
        xpriority: json["xpriority"],
        regidesc: json["regidesc"],
        xprodnaturedesc: json["xprodnaturedesc"],
        xlong: json["xlong"],
        twhdesc: json["twhdesc"],
        xstatustor: json["xstatustor"],
        xstatusrdesc: json["xstatusrdesc"],
        xnote: json["xnote"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xtornum": xtornum,
        "xporeqnum": xporeqnum,
        "xdate": xdate,
        "xdatereq": xdatereq,
        "xfwh": xfwh,
        "xfbrname": xfbrname,
        "xtwh": xtwh,
        "xtbrname": xtbrname,
        "xpriority": xpriority,
        "regidesc": regidesc,
        "xprodnaturedesc": xprodnaturedesc,
        "xlong": xlong,
        "twhdesc": twhdesc,
        "xstatustor": xstatustor,
        "xstatusrdesc": xstatusrdesc,
        "xnote": xnote,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
