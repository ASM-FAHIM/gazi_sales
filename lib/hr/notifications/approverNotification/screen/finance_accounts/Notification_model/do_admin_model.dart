// To parse this JSON data, do
//
//     final doModel = doModelFromJson(jsonString);

import 'dart:convert';

List<DoModel> doModelFromJson(String str) => List<DoModel>.from(json.decode(str).map((x) => DoModel.fromJson(x)));

String doModelToJson(List<DoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoModel {
  String xlong;
  String xgrninvno;
  String xpornum;
  String xvoucher;
  String xinvnum;
  String xsup;
  String xsupname;
  String xdate;
  String xwh;
  String xwhdec;
  String xinvamt;
  String xgrnamt;
  String xadvamt;
  String xapvamt;
  String xstatus;
  String xstatusrdesc;
  String xstatusjv;
  String xxstatusjvdesc;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;
  String reviewer2Xdeptname;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  DoModel({
    required this.xlong,
    required this.xgrninvno,
    required this.xpornum,
    required this.xvoucher,
    required this.xinvnum,
    required this.xsup,
    required this.xsupname,
    required this.xdate,
    required this.xwh,
    required this.xwhdec,
    required this.xinvamt,
    required this.xgrnamt,
    required this.xadvamt,
    required this.xapvamt,
    required this.xstatus,
    required this.xstatusrdesc,
    required this.xstatusjv,
    required this.xxstatusjvdesc,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
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

  factory DoModel.fromJson(Map<String, dynamic> json) => DoModel(
    xlong: json["xlong"],
    xgrninvno: json["xgrninvno"],
    xpornum: json["xpornum"],
    xvoucher: json["xvoucher"],
    xinvnum: json["xinvnum"],
    xsup: json["xsup"],
    xsupname: json["xsupname"],
    xdate: json["xdate"],
    xwh: json["xwh"],
    xwhdec: json["xwhdec"],
    xinvamt: json["xinvamt"],
    xgrnamt: json["xgrnamt"],
    xadvamt: json["xadvamt"],
    xapvamt: json["xapvamt"],
    xstatus: json["xstatus"],
    xstatusrdesc: json["xstatusrdesc"],
    xstatusjv: json["xstatusjv"],
    xxstatusjvdesc: json["xxstatusjvdesc"],
    xnote: json["xnote"],
    preparerName: json["preparer_name"],
    preparerXdesignation: json["preparer_xdesignation"],
    preparerXdeptname: json["preparer_xdeptname"],
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
    "xlong": xlong,
    "xgrninvno": xgrninvno,
    "xpornum": xpornum,
    "xvoucher": xvoucher,
    "xinvnum": xinvnum,
    "xsup": xsup,
    "xsupname": xsupname,
    "xdate": xdate,
    "xwh": xwh,
    "xwhdec": xwhdec,
    "xinvamt": xinvamt,
    "xgrnamt": xgrnamt,
    "xadvamt": xadvamt,
    "xapvamt": xapvamt,
    "xstatus": xstatus,
    "xstatusrdesc": xstatusrdesc,
    "xstatusjv": xstatusjv,
    "xxstatusjvdesc": xxstatusjvdesc,
    "xnote": xnote,
    "preparer_name": preparerName,
    "preparer_xdesignation": preparerXdesignation,
    "preparer_xdeptname": preparerXdeptname,
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
/*
class DoModel {
  String xlong;
  String xgrninvno;
  String xpornum;
  String xvoucher;
  String xinvnum;
  String xsup;
  String xsupname;
  String xdate;
  String xwh;
  String xwhdec;
  String xinvamt;
  String xgrnamt;
  String xadvamt;
  String xapvamt;
  String xstatus;
  String xstatusrdesc;
  String xstatusjv;
  String xxstatusjvdesc;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer1Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;
  String reviewer2Xdeptname;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  DoModel({
    required this.xlong,
    required this.xgrninvno,
    required this.xpornum,
    required this.xvoucher,
    required this.xinvnum,
    required this.xsup,
    required this.xsupname,
    required this.xdate,
    required this.xwh,
    required this.xwhdec,
    required this.xinvamt,
    required this.xgrnamt,
    required this.xadvamt,
    required this.xapvamt,
    required this.xstatus,
    required this.xstatusrdesc,
    required this.xstatusjv,
    required this.xxstatusjvdesc,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
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

}*/
