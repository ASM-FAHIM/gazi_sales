// To parse this JSON data, do
//
//     final csModel = csModelFromJson(jsonString);

import 'dart:convert';

List<CsModel> csModelFromJson(String str) =>
    List<CsModel>.from(json.decode(str).map((x) => CsModel.fromJson(x)));

String csModelToJson(List<CsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CsModel {
  String zid;
  String requisition;
  String xdate;
  String xregi;
  String xtwh;
  String name;
  String xstatusreq;
  String xstatusreqDesc;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer2Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  CsModel({
    required this.zid,
    required this.requisition,
    required this.xdate,
    required this.xregi,
    required this.xtwh,
    required this.name,
    required this.xstatusreq,
    required this.xstatusreqDesc,
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

  factory CsModel.fromJson(Map<String, dynamic> json) => CsModel(
        zid: json["zid"],
        requisition: json["requisition"],
        xdate: json["xdate"],
        xregi: json["xregi"],
        xtwh: json["xtwh"],
        name: json["name"],
        xstatusreq: json["xstatusreq"],
        xstatusreqDesc: json["xstatusreqDesc"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
        reviewer1Name: json["reviewer1_name"],
        reviewer1Designation: json["reviewer1_designation"],
        reviewer2Xdeptname: json["reviewer2_xdeptname"],
        reviewer2Name: json["reviewer2_name"],
        reviewer2Designation: json["reviewer2_designation"],
        signrejectName: json["signreject_name"],
        signrejectDesignation: json["signreject_designation"],
        signrejectXdeptname: json["signreject_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "requisition": requisition,
        "xdate": xdate,
        "xregi": xregi,
        "xtwh": xtwh,
        "name": name,
        "xstatusreq": xstatusreq,
        "xstatusreqDesc": xstatusreqDesc,
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
