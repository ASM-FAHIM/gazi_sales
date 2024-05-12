// To parse this JSON data, do
//
//     final pendingIouModel = pendingIouModelFromJson(jsonString);

import 'dart:convert';

List<PendingIouModel> pendingIouModelFromJson(String str) =>
    List<PendingIouModel>.from(
        json.decode(str).map((x) => PendingIouModel.fromJson(x)));

String pendingIouModelToJson(List<PendingIouModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingIouModel {
  String xbillno;
  String xsuperiorgl;
  String xprime;
  String xdate;
  String xstatus;
  String xstatusdesc;
  String xwh;
  String regidesc;
  String xamount;
  String xacc;
  String xaccdesc;
  String xpurpose;
  String xstaff;
  String xstaffdesc;
  String xlong;
  String xnote;
  String xnote1;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  PendingIouModel({
    required this.xbillno,
    required this.xsuperiorgl,
    required this.xprime,
    required this.xdate,
    required this.xstatus,
    required this.xstatusdesc,
    required this.xwh,
    required this.regidesc,
    required this.xamount,
    required this.xacc,
    required this.xaccdesc,
    required this.xpurpose,
    required this.xstaff,
    required this.xstaffdesc,
    required this.xlong,
    required this.xnote,
    required this.xnote1,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory PendingIouModel.fromJson(Map<String, dynamic> json) =>
      PendingIouModel(
        xbillno: json["xbillno"],
        xsuperiorgl: json["xsuperiorgl"],
        xprime: json["xprime"],
        xdate: json["xdate"],
        xstatus: json["xstatus"],
        xstatusdesc: json["xstatusdesc"],
        xwh: json["xwh"],
        regidesc: json["regidesc"],
        xamount: json["xamount"],
        xacc: json["xacc"],
        xaccdesc: json["xaccdesc"],
        xpurpose: json["xpurpose"],
        xstaff: json["xstaff"],
        xstaffdesc: json["xstaffdesc"],
        xlong: json["xlong"],
        xnote: json["xnote"],
        xnote1: json["xnote1"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xbillno": xbillno,
        "xsuperiorgl": xsuperiorgl,
        "xprime": xprime,
        "xdate": xdate,
        "xstatus": xstatus,
        "xstatusdesc": xstatusdesc,
        "xwh": xwh,
        "regidesc": regidesc,
        "xamount": xamount,
        "xacc": xacc,
        "xaccdesc": xaccdesc,
        "xpurpose": xpurpose,
        "xstaff": xstaff,
        "xstaffdesc": xstaffdesc,
        "xlong": xlong,
        "xnote": xnote,
        "xnote1": xnote1,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
