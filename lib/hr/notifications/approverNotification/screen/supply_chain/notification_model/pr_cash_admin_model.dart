// To parse this JSON data, do
//
//     final cashNoticationModel = cashNoticationModelFromJson(jsonString);

import 'dart:convert';

List<CashNoticationModel> cashNoticationModelFromJson(String str) =>
    List<CashNoticationModel>.from(
        json.decode(str).map((x) => CashNoticationModel.fromJson(x)));

String cashNoticationModelToJson(List<CashNoticationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashNoticationModel {
  CashNoticationModel({
    required this.xporeqnum,
    required this.xdate,
    required this.xstatusreq,
    required this.xtypeobj,
    required this.xnote,
    required this.xnote1,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer2Xdeptname,
    required this.reviewer2Name,
    required this.reviewer2Designation,
    required this.signrejectName,
    required this.signrejectDesignation,
    required this.signrejectXdeptname,
  });

  String xporeqnum;
  String xdate;
  String xstatusreq;
  String xtypeobj;
  String xnote;
  String xnote1;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  dynamic reviewer1Name;
  dynamic reviewer1Designation;
  String reviewer2Xdeptname;
  dynamic reviewer2Name;
  dynamic reviewer2Designation;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  factory CashNoticationModel.fromJson(Map<String, dynamic> json) =>
      CashNoticationModel(
        xporeqnum: json["xporeqnum"] ?? " ",
        xdate: json["xdate"] ?? " ",
        xstatusreq: json["xstatusreq"] ?? " ",
        xtypeobj: json["xtypeobj"] ?? " ",
        xnote: json["xnote"] ?? " ",
        xnote1: json["xnote1"] ?? " ",
        preparerName: json["preparer_name"] ?? " ",
        preparerXdesignation: json["preparer_xdesignation"] ?? " ",
        preparerXdeptname: json["preparer_xdeptname"] ?? " ",
        reviewer1Name: json["reviewer1_name"] ?? " ",
        reviewer1Designation: json["reviewer1_designation"] ?? " ",
        reviewer2Xdeptname: json["reviewer2_xdeptname"] ?? " ",
        reviewer2Name: json["reviewer2_name"] ?? " ",
        reviewer2Designation: json["reviewer2_designation"] ?? " ",
        signrejectName: json["signreject_name"] ?? " ",
        signrejectDesignation: json["signreject_designation"] ?? " ",
        signrejectXdeptname: json["signreject_xdeptname"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "xporeqnum": xporeqnum,
        "xdate": xdate,
        "xstatusreq": xstatusreq,
        "xtypeobj": xtypeobj,
        "xnote": xnote,
        "xnote1": xnote1,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer2_xdeptname": reviewer2Xdeptname,
        "reviewer2_name": reviewer2Name,
        "reviewer2_designation": reviewer2Designation,
        "signreject_name": signrejectName,
        "signreject_designation": signrejectDesignation,
        "signreject_xdeptname": signrejectXdeptname,
      };
}
