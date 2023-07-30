// To parse this JSON data, do
//
//     final srNotiModel = srNotiModelFromJson(jsonString);

import 'dart:convert';

List<SrNotiModel> srNotiModelFromJson(String str) => List<SrNotiModel>.from(
    json.decode(str).map((x) => SrNotiModel.fromJson(x)));

String srNotiModelToJson(List<SrNotiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SrNotiModel {
  String zid;
  String xtornum;
  String xporeqnum;
  String xdate;
  String xdatereq;
  String xfwh;
  String xfbrname;
  String xpriority;
  String regidesc;
  String xprodnaturedesc;
  String xlong;
  String twhdesc;
  String xstatustor;
  String descxstatustor;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  SrNotiModel({
    required this.zid,
    required this.xtornum,
    required this.xporeqnum,
    required this.xdate,
    required this.xdatereq,
    required this.xfwh,
    required this.xfbrname,
    required this.xpriority,
    required this.regidesc,
    required this.xprodnaturedesc,
    required this.xlong,
    required this.twhdesc,
    required this.xstatustor,
    required this.descxstatustor,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory SrNotiModel.fromJson(Map<String, dynamic> json) => SrNotiModel(
        zid: json["zid"],
        xtornum: json["xtornum"],
        xporeqnum: json["xporeqnum"],
        xdate: json["xdate"],
        xdatereq: json["xdatereq"],
        xfwh: json["xfwh"],
        xfbrname: json["xfbrname"],
        xpriority: json["xpriority"],
        regidesc: json["regidesc"],
        xprodnaturedesc: json["xprodnaturedesc"],
        xlong: json["xlong"],
        twhdesc: json["twhdesc"],
        xstatustor: json["xstatustor"],
        descxstatustor: json["descxstatustor"],
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
        "xpriority": xpriority,
        "regidesc": regidesc,
        "xprodnaturedesc": xprodnaturedesc,
        "xlong": xlong,
        "twhdesc": twhdesc,
        "xstatustor": xstatustor,
        "descxstatustor": descxstatustor,
        "xnote": xnote,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
