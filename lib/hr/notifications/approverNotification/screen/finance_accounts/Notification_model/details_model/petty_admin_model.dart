// To parse this JSON data, do
//
//     final pendingPettyModel = pendingPettyModelFromJson(jsonString);

import 'dart:convert';

List<PendingPettyModel> pendingPettyModelFromJson(String str) =>
    List<PendingPettyModel>.from(
        json.decode(str).map((x) => PendingPettyModel.fromJson(x)));

String pendingPettyModelToJson(List<PendingPettyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingPettyModel {
  String zid;
  String xbillno;
  String xprime;
  String xdate;
  String xstatus;
  String xstatusdesc;
  String xwh;
  String xwhdesc;
  String xamount;
  String xacc;
  String xaccdesc;
  String xlong;
  String xnote;
  String xnote1;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String approverName;
  String approverDesignation;
  String approverXdeptname;

  PendingPettyModel({
    required this.zid,
    required this.xbillno,
    required this.xprime,
    required this.xdate,
    required this.xstatus,
    required this.xstatusdesc,
    required this.xwh,
    required this.xwhdesc,
    required this.xamount,
    required this.xacc,
    required this.xaccdesc,
    required this.xlong,
    required this.xnote,
    required this.xnote1,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.approverName,
    required this.approverDesignation,
    required this.approverXdeptname,
  });

  factory PendingPettyModel.fromJson(Map<String, dynamic> json) =>
      PendingPettyModel(
        zid: json["zid"],
        xbillno: json["xbillno"],
        xprime: json["xprime"],
        xdate: json["xdate"],
        xstatus: json["xstatus"],
        xstatusdesc: json["xstatusdesc"],
        xwh: json["xwh"],
        xwhdesc: json["xwhdesc"],
        xamount: json["xamount"],
        xacc: json["xacc"],
        xaccdesc: json["xaccdesc"],
        xlong: json["xlong"],
        xnote: json["xnote"],
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
        "xbillno": xbillno,
        "xprime": xprime,
        "xdate": xdate,
        "xstatus": xstatus,
        "xstatusdesc": xstatusdesc,
        "xwh": xwh,
        "xwhdesc": xwhdesc,
        "xamount": xamount,
        "xacc": xacc,
        "xaccdesc": xaccdesc,
        "xlong": xlong,
        "xnote": xnote,
        "xnote1": xnote1,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "Approver_name": approverName,
        "Approver_designation": approverDesignation,
        "Approver_xdeptname": approverXdeptname,
      };
}
