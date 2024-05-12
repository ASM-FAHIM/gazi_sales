// To parse this JSON data, do
//
//     final sqcNotificationModel = sqcNotificationModelFromJson(jsonString);

import 'dart:convert';

List<SqcNotificationModel> sqcNotificationModelFromJson(String str) =>
    List<SqcNotificationModel>.from(
        json.decode(str).map((x) => SqcNotificationModel.fromJson(x)));

String sqcNotificationModelToJson(List<SqcNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SqcNotificationModel {
  SqcNotificationModel({
    required this.xgrnnum,
    required this.xdate,
    required this.xinvnum,
    required this.xlcno,
    required this.xwh,
    required this.xcus,
    required this.sup,
    required this.xref,
    required this.xstatusgrn,
    required this.xwhdesc,
    required this.xpornum,
    required this.xnote,
    required this.xstatusdoc,
    required this.preparer,
    required this.designation,
  });

  String xgrnnum;
  String xdate;
  String xinvnum;
  String xlcno;
  String xwh;
  String xcus;
  String sup;
  String xref;
  String xstatusgrn;
  String xwhdesc;
  String xpornum;
  String xnote;
  String xstatusdoc;
  String preparer;
  String designation;

  factory SqcNotificationModel.fromJson(Map<String, dynamic> json) =>
      SqcNotificationModel(
        xgrnnum: json["xgrnnum"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xinvnum: json["xinvnum"] ?? ' ',
        xlcno: json["xlcno"] ?? ' ',
        xwh: json["xwh"] ?? ' ',
        xcus: json["xcus"] ?? ' ',
        sup: json["sup"] ?? ' ',
        xref: json["xref"] ?? ' ',
        xstatusgrn: json["xstatusgrn"] ?? ' ',
        xwhdesc: json["xwhdesc"] ?? ' ',
        xpornum: json["xpornum"] ?? ' ',
        xnote: json["xnote"] ?? ' ',
        xstatusdoc: json["xstatusdoc"] ?? ' ',
        preparer: json["preparer"] ?? ' ',
        designation: json["designation"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xgrnnum": xgrnnum,
        "xdate": xdate,
        "xinvnum": xinvnum,
        "xlcno": xlcno,
        "xwh": xwh,
        "xcus": xcus,
        "sup": sup,
        "xref": xref,
        "xstatusgrn": xstatusgrn,
        "xwhdesc": xwhdesc,
        "xpornum": xpornum,
        "xnote": xnote,
        "xstatusdoc": xstatusdoc,
        "preparer": preparer,
        "designation": designation,
      };
}
