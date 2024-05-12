// To parse this JSON data, do
//
//     final sqcModel = sqcModelFromJson(jsonString);

import 'dart:convert';

List<SqcModel> sqcModelFromJson(String str) => List<SqcModel>.from(json.decode(str).map((x) => SqcModel.fromJson(x)));

String sqcModelToJson(List<SqcModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SqcModel {
  String? xgrnnum;
  String? xdate;
  String? xcus;
  String? sup;
  String? xinvnum;
  String? xlcno;
  String? xref;
  String? xnote;
  String? xstatusgrn;
  String? statusgrndesc;
  String? xwh;
  String? xwhdesc;
  String? xpornum;
  String? xnote1;
  String? xstatusdoc;
  String? statusdocdesc;
  String? xgateentryno;
  String? preparer;
  String? designation;
  String? deptname;
  String? signrejectName;
  String? signrejectDesignation;
  String? signrejectXdeptname;

  SqcModel({
    this.xgrnnum,
    this.xdate,
    this.xcus,
    this.sup,
    this.xinvnum,
    this.xlcno,
    this.xref,
    this.xnote,
    this.xstatusgrn,
    this.statusgrndesc,
    this.xwh,
    this.xwhdesc,
    this.xpornum,
    this.xnote1,
    this.xstatusdoc,
    this.statusdocdesc,
    this.xgateentryno,
    this.preparer,
    this.designation,
    this.deptname,
    this.signrejectName,
    this.signrejectDesignation,
    this.signrejectXdeptname,
  });

  factory SqcModel.fromJson(Map<String, dynamic> json) => SqcModel(
    xgrnnum: json["xgrnnum"],
    xdate: json["xdate"],
    xcus: json["xcus"],
    sup: json["sup"],
    xinvnum: json["xinvnum"],
    xlcno: json["xlcno"],
    xref: json["xref"],
    xnote: json["xnote"],
    xstatusgrn: json["xstatusgrn"],
    statusgrndesc: json["statusgrndesc"],
    xwh: json["xwh"],
    xwhdesc: json["xwhdesc"],
    xpornum: json["xpornum"],
    xnote1: json["xnote1"],
    xstatusdoc: json["xstatusdoc"],
    statusdocdesc: json["statusdocdesc"],
    xgateentryno: json["xgateentryno"],
    preparer: json["preparer"],
    designation: json["designation"],
    deptname: json["deptname"],
    signrejectName: json["signreject_name"],
    signrejectDesignation: json["signreject_designation"],
    signrejectXdeptname: json["signreject_xdeptname"],
  );

  Map<String, dynamic> toJson() => {
    "xgrnnum": xgrnnum,
    "xdate": xdate,
    "xcus": xcus,
    "sup": sup,
    "xinvnum": xinvnum,
    "xlcno": xlcno,
    "xref": xref,
    "xnote": xnote,
    "xstatusgrn": xstatusgrn,
    "statusgrndesc": statusgrndesc,
    "xwh": xwh,
    "xwhdesc": xwhdesc,
    "xpornum": xpornum,
    "xnote1": xnote1,
    "xstatusdoc": xstatusdoc,
    "statusdocdesc": statusdocdesc,
    "xgateentryno": xgateentryno,
    "preparer": preparer,
    "designation": designation,
    "deptname": deptname,
    "signreject_name": signrejectName,
    "signreject_designation": signrejectDesignation,
    "signreject_xdeptname": signrejectXdeptname,
  };
}
