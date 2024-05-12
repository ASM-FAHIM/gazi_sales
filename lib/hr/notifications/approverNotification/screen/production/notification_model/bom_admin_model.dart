// To parse this JSON data, do
//
//     final bomNotificationModel = bomNotificationModelFromJson(jsonString);

import 'dart:convert';

List<BomNotificationModel> bomNotificationModelFromJson(String str) => List<BomNotificationModel>.from(json.decode(str).map((x) => BomNotificationModel.fromJson(x)));

String bomNotificationModelToJson(List<BomNotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BomNotificationModel {
  String? zid;
  String? xbomkey;
  String? xdesc;
  String? xitem;
  String? xitemdesc;
  String? xdate;
  String? xpreferbatchqty;
  String? xstatustor;
  String? descxstatustor;
  String? xlong;
  String? xnote1;
  String? totalQty;
  String? preparerName;
  String? preparerXdesignation;
  String? preparerXdeptname;
  String? approverName1;
  String? approverDesignation1;
  String? approverXdeptname1;
  String? approverName2;
  String? approverDesignation2;
  String? approverXdeptname2;
  String? approverName3;
  String? approverDesignation3;
  String? approverXdeptname3;
  String? approverName4;
  String? approverDesignation4;
  String? approverXdeptname4;
  String? approverName5;
  String? approverDesignation5;
  String? approverXdeptname5;
  String? rejectName;
  String? rejectDesignation;
  String? rejectXdeptname;

  BomNotificationModel({
    this.zid,
    this.xbomkey,
    this.xdesc,
    this.xitem,
    this.xitemdesc,
    this.xdate,
    this.xpreferbatchqty,
    this.xstatustor,
    this.descxstatustor,
    this.xlong,
    this.xnote1,
    this.totalQty,
    this.preparerName,
    this.preparerXdesignation,
    this.preparerXdeptname,
    this.approverName1,
    this.approverDesignation1,
    this.approverXdeptname1,
    this.approverName2,
    this.approverDesignation2,
    this.approverXdeptname2,
    this.approverName3,
    this.approverDesignation3,
    this.approverXdeptname3,
    this.approverName4,
    this.approverDesignation4,
    this.approverXdeptname4,
    this.approverName5,
    this.approverDesignation5,
    this.approverXdeptname5,
    this.rejectName,
    this.rejectDesignation,
    this.rejectXdeptname,
  });

  factory BomNotificationModel.fromJson(Map<String, dynamic> json) => BomNotificationModel(
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
    totalQty: json["totalQty"],
    preparerName: json["preparer_name"],
    preparerXdesignation: json["preparer_xdesignation"],
    preparerXdeptname: json["preparer_xdeptname"],
    approverName1: json["Approver_name1"],
    approverDesignation1: json["Approver_designation1"],
    approverXdeptname1: json["Approver_xdeptname1"],
    approverName2: json["Approver_name2"],
    approverDesignation2: json["Approver_designation2"],
    approverXdeptname2: json["Approver_xdeptname2"],
    approverName3: json["Approver_name3"],
    approverDesignation3: json["Approver_designation3"],
    approverXdeptname3: json["Approver_xdeptname3"],
    approverName4: json["Approver_name4"],
    approverDesignation4: json["Approver_designation4"],
    approverXdeptname4: json["Approver_xdeptname4"],
    approverName5: json["Approver_name5"],
    approverDesignation5: json["Approver_designation5"],
    approverXdeptname5: json["Approver_xdeptname5"],
    rejectName: json["reject_name"],
    rejectDesignation: json["reject_designation"],
    rejectXdeptname: json["reject_xdeptname"],
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
    "totalQty": totalQty,
    "preparer_name": preparerName,
    "preparer_xdesignation": preparerXdesignation,
    "preparer_xdeptname": preparerXdeptname,
    "Approver_name1": approverName1,
    "Approver_designation1": approverDesignation1,
    "Approver_xdeptname1": approverXdeptname1,
    "Approver_name2": approverName2,
    "Approver_designation2": approverDesignation2,
    "Approver_xdeptname2": approverXdeptname2,
    "Approver_name3": approverName3,
    "Approver_designation3": approverDesignation3,
    "Approver_xdeptname3": approverXdeptname3,
    "Approver_name4": approverName4,
    "Approver_designation4": approverDesignation4,
    "Approver_xdeptname4": approverXdeptname4,
    "Approver_name5": approverName5,
    "Approver_designation5": approverDesignation5,
    "Approver_xdeptname5": approverXdeptname5,
    "reject_name": rejectName,
    "reject_designation": rejectDesignation,
    "reject_xdeptname": rejectXdeptname,
  };
}
