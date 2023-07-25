// To parse this JSON data, do
//
//     final bomNotificationModel = bomNotificationModelFromJson(jsonString);

import 'dart:convert';

List<BomNotificationModel> bomNotificationModelFromJson(String str) =>
    List<BomNotificationModel>.from(
        json.decode(str).map((x) => BomNotificationModel.fromJson(x)));

String bomNotificationModelToJson(List<BomNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BomNotificationModel {
  String zid;
  String xbomkey;
  String xdesc;
  String xitem;
  String xitemdesc;
  String xdate;
  String xpreferbatchqty;
  String xstatustor;
  String descxstatustor;
  String xlong;
  String xnote1;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String approverName;
  String approverDesignation;
  String approverXdeptname;

  BomNotificationModel({
    required this.zid,
    required this.xbomkey,
    required this.xdesc,
    required this.xitem,
    required this.xitemdesc,
    required this.xdate,
    required this.xpreferbatchqty,
    required this.xstatustor,
    required this.descxstatustor,
    required this.xlong,
    required this.xnote1,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.approverName,
    required this.approverDesignation,
    required this.approverXdeptname,
  });

  factory BomNotificationModel.fromJson(Map<String, dynamic> json) =>
      BomNotificationModel(
        zid: json["zid"],
        xbomkey: json["xbomkey"],
        xdesc: json["xdesc"],
        xitem: json["xitem"],
        xitemdesc: json["xitemdesc"],
        xdate: json["xdate"],
        xpreferbatchqty: json["xpreferbatchqty"],
        xstatustor: json["xstatustor"],
        descxstatustor: json["descxstatustor"],
        xlong: json["xlong"],
        xnote1: json["xnote1"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
        approverName: json["Approver_name"],
        approverDesignation: json["Approver_designation"],
        approverXdeptname: json["Approver_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xbomkey": xbomkey,
        "xdesc": xdesc,
        "xitem": xitem,
        "xitemdesc": xitemdesc,
        "xdate": xdate,
        "xpreferbatchqty": xpreferbatchqty,
        "xstatustor": xstatustor,
        "descxstatustor": descxstatustor,
        "xlong": xlong,
        "xnote1": xnote1,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "Approver_name": approverName,
        "Approver_designation": approverDesignation,
        "Approver_xdeptname": approverXdeptname,
      };
}
