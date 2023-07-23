// To parse this JSON data, do
//
//     final srNotiModel = srNotiModelFromJson(jsonString);

import 'dart:convert';

List<SrNotiModel> srNotiModelFromJson(String str) => List<SrNotiModel>.from(json.decode(str).map((x) => SrNotiModel.fromJson(x)));

String srNotiModelToJson(List<SrNotiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SrNotiModel {
  SrNotiModel({
    required this.zid,
    required this.requisition,
    this.xporeqnum,
    required this.xdate,
    required this.twhdesc,
    required this.xstatustor,
  });

  int zid;
  dynamic requisition;
  dynamic xporeqnum;
  dynamic xdate;
  dynamic twhdesc;
  dynamic xstatustor;

  factory SrNotiModel.fromJson(Map<String, dynamic> json) => SrNotiModel(
    zid: json["zid"],
    requisition: json["requisition"],
    xporeqnum: json["xporeqnum"],
    xdate: json["xdate"],
    twhdesc: json["twhdesc"],
    xstatustor: json["xstatustor"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "requisition": requisition,
    "xporeqnum": xporeqnum,
    "xdate": xdate,
    "twhdesc": twhdesc,
    "xstatustor": xstatustor,
  };
}
