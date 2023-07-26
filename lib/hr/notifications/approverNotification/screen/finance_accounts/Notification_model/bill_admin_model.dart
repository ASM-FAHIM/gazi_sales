// To parse this JSON data, do
//
//     final billAdminModel = billAdminModelFromJson(jsonString);

import 'dart:convert';

List<BillAdminModel> billAdminModelFromJson(String str) =>
    List<BillAdminModel>.from(
        json.decode(str).map((x) => BillAdminModel.fromJson(x)));

String billAdminModelToJson(List<BillAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillAdminModel {
  String xbillno;
  String xdate;
  String xprime;
  String xstatus;
  String xstatusrdesc;
  String xtrn;
  String xamount;
  String xstaff;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String xwh;
  String xfbrname;
  String xaccdr;
  String xaccdrdesc;
  String xacccr;
  String xacccrdesc;
  String recdesc;
  String xlong;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;
  String reviewer2Xdeptname;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  BillAdminModel({
    required this.xbillno,
    required this.xdate,
    required this.xprime,
    required this.xstatus,
    required this.xstatusrdesc,
    required this.xtrn,
    required this.xamount,
    required this.xstaff,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.xwh,
    required this.xfbrname,
    required this.xaccdr,
    required this.xaccdrdesc,
    required this.xacccr,
    required this.xacccrdesc,
    required this.recdesc,
    required this.xlong,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer1Xdeptname,
    required this.reviewer2Name,
    required this.reviewer2Designation,
    required this.reviewer2Xdeptname,
    required this.signrejectName,
    required this.signrejectDesignation,
    required this.signrejectXdeptname,
  });

  factory BillAdminModel.fromJson(Map<String, dynamic> json) => BillAdminModel(
        xbillno: json["xbillno"],
        xdate: json["xdate"],
        xprime: json["xprime"],
        xstatus: json["xstatus"],
        xstatusrdesc: json["xstatusrdesc"],
        xtrn: json["xtrn"],
        xamount: json["xamount"],
        xstaff: json["xstaff"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
        xwh: json["xwh"],
        xfbrname: json["xfbrname"],
        xaccdr: json["xaccdr"],
        xaccdrdesc: json["xaccdrdesc"],
        xacccr: json["xacccr"],
        xacccrdesc: json["xacccrdesc"],
        recdesc: json["recdesc"],
        xlong: json["xlong"],
        reviewer1Name: json["reviewer1_name"],
        reviewer1Designation: json["reviewer1_designation"],
        reviewer1Xdeptname: json["reviewer1_xdeptname"],
        reviewer2Name: json["reviewer2_name"],
        reviewer2Designation: json["reviewer2_designation"],
        reviewer2Xdeptname: json["reviewer2_xdeptname"],
        signrejectName: json["signreject_name"],
        signrejectDesignation: json["signreject_designation"],
        signrejectXdeptname: json["signreject_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xbillno": xbillno,
        "xdate": xdate,
        "xprime": xprime,
        "xstatus": xstatus,
        "xstatusrdesc": xstatusrdesc,
        "xtrn": xtrn,
        "xamount": xamount,
        "xstaff": xstaff,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "xwh": xwh,
        "xfbrname": xfbrname,
        "xaccdr": xaccdr,
        "xaccdrdesc": xaccdrdesc,
        "xacccr": xacccr,
        "xacccrdesc": xacccrdesc,
        "recdesc": recdesc,
        "xlong": xlong,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer1_xdeptname": reviewer1Xdeptname,
        "reviewer2_name": reviewer2Name,
        "reviewer2_designation": reviewer2Designation,
        "reviewer2_xdeptname": reviewer2Xdeptname,
        "signreject_name": signrejectName,
        "signreject_designation": signrejectDesignation,
        "signreject_xdeptname": signrejectXdeptname,
      };
}
