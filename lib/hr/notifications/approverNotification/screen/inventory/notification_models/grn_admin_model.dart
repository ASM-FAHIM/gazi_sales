// To parse this JSON data, do
//
//     final grnNotificationModel = grnNotificationModelFromJson(jsonString);

import 'dart:convert';

List<GrnNotificationModel> grnNotificationModelFromJson(String str) =>
    List<GrnNotificationModel>.from(
        json.decode(str).map((x) => GrnNotificationModel.fromJson(x)));

String grnNotificationModelToJson(List<GrnNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrnNotificationModel {
  String xgrnnum;
  String xdate;
  String xcus;
  String sup;
  String xref;
  String xnote;
  String xstatusgrn;
  String xwh;
  String xwhdesc;
  String xpornum;
  String xnote1;
  String xstatusdoc;
  String statusdocdesc;
  String xgateentryno;
  String preparer;
  String designation;
  String deptname;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  GrnNotificationModel({
    required this.xgrnnum,
    required this.xdate,
    required this.xcus,
    required this.sup,
    required this.xref,
    required this.xnote,
    required this.xstatusgrn,
    required this.xwh,
    required this.xwhdesc,
    required this.xpornum,
    required this.xnote1,
    required this.xstatusdoc,
    required this.statusdocdesc,
    required this.xgateentryno,
    required this.preparer,
    required this.designation,
    required this.deptname,
    required this.signrejectName,
    required this.signrejectDesignation,
    required this.signrejectXdeptname,
  });

  factory GrnNotificationModel.fromJson(Map<String, dynamic> json) =>
      GrnNotificationModel(
        xgrnnum: json["xgrnnum"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        sup: json["sup"],
        xref: json["xref"],
        xnote: json["xnote"],
        xstatusgrn: json["xstatusgrn"],
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
        "xref": xref,
        "xnote": xnote,
        "xstatusgrn": xstatusgrn,
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
