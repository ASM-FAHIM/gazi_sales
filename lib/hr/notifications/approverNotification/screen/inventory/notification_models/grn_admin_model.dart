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
  GrnNotificationModel({
    required this.xstatusdoc,
    required this.xinvnum,
    required this.xcus,
    required this.xnote,
    required this.xstatusgrn,
    required this.xorg,
    required this.xref,
    required this.xtypeobj,
    required this.xstatusreq,
    required this.xgrnnum,
    required this.xpornum,
    required this.xdate,
    required this.xregi,
    required this.xlcno,
    required this.sup,
    required this.xwhdesc,
    required this.xwh,
    required this.preparer,
    required this.designation,
    required this.deptname,
    required this.signname,
    required this.signdesignation,
    required this.signdeptname,
  });

  String xstatusdoc;
  String xinvnum;
  String xcus;
  String xnote;
  String xstatusgrn;
  String xorg;
  String xref;
  String xtypeobj;
  String xstatusreq;
  String xgrnnum;
  String xpornum;
  String xdate;
  String xregi;
  String xlcno;
  String sup;
  String xwhdesc;
  String xwh;
  String preparer;
  String designation;
  String deptname;
  String signname;
  String signdesignation;
  String signdeptname;

  factory GrnNotificationModel.fromJson(Map<String, dynamic> json) =>
      GrnNotificationModel(
        xstatusdoc: json["xstatusdoc"],
        xinvnum: json["xinvnum"],
        xcus: json["xcus"],
        xnote: json["xnote"],
        xstatusgrn: json["xstatusgrn"],
        xorg: json["xorg"],
        xref: json["xref"],
        xtypeobj: json["xtypeobj"],
        xstatusreq: json["xstatusreq"],
        xgrnnum: json["xgrnnum"],
        xpornum: json["xpornum"],
        xdate: json["xdate"],
        xregi: json["xregi"],
        xlcno: json["xlcno"],
        sup: json["sup"],
        xwhdesc: json["xwhdesc"],
        xwh: json["xwh"],
        preparer: json["preparer"],
        designation: json["designation"],
        deptname: json["deptname"],
        signname: json["signname"],
        signdesignation: json["signdesignation"],
        signdeptname: json["signdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xstatusdoc": xstatusdoc,
        "xinvnum": xinvnum,
        "xcus": xcus,
        "xnote": xnote,
        "xstatusgrn": xstatusgrn,
        "xorg": xorg,
        "xref": xref,
        "xtypeobj": xtypeobj,
        "xstatusreq": xstatusreq,
        "xgrnnum": xgrnnum,
        "xpornum": xpornum,
        "xdate": xdate,
        "xregi": xregi,
        "xlcno": xlcno,
        "sup": sup,
        "xwhdesc": xwhdesc,
        "xwh": xwh,
        "preparer": preparer,
        "designation": designation,
        "deptname": deptname,
        "signname": signname,
        "signdesignation": signdesignation,
        "signdeptname": signdeptname,
      };
}
