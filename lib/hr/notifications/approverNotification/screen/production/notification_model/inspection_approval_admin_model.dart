// To parse this JSON data, do
//
//     final inspectionNotificationModel = inspectionNotificationModelFromJson(jsonString);

import 'dart:convert';

List<InspectionNotificationModel> inspectionNotificationModelFromJson(String str) => List<InspectionNotificationModel>.from(json.decode(str).map((x) => InspectionNotificationModel.fromJson(x)));

String inspectionNotificationModelToJson(List<InspectionNotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InspectionNotificationModel {
  String? zid;
  String? xtornum;
  String? xdate;
  String? xfwh;
  String? xfwhdesc;
  String? xqtyfin;
  String? xparentitem;
  String? xparentitemdesc;
  String? xwh;
  String? xwhdesc;
  String? xunit;
  String? xwastitem;
  String? xwastitemdesc;
  String? xtwh;
  String? xtwhdesc;
  String? xwastqty;
  String? xstatustor;
  String? xstatustordesc;
  String? xlong;
  String? xnote;
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

  InspectionNotificationModel({
    this.zid,
    this.xtornum,
    this.xdate,
    this.xfwh,
    this.xfwhdesc,
    this.xqtyfin,
    this.xparentitem,
    this.xparentitemdesc,
    this.xwh,
    this.xwhdesc,
    this.xunit,
    this.xwastitem,
    this.xwastitemdesc,
    this.xtwh,
    this.xtwhdesc,
    this.xwastqty,
    this.xstatustor,
    this.xstatustordesc,
    this.xlong,
    this.xnote,
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

  factory InspectionNotificationModel.fromJson(Map<String, dynamic> json) => InspectionNotificationModel(
    zid: json["zid"],
    xtornum: json["xtornum"],
    xdate: json["xdate"],
    xfwh: json["xfwh"],
    xfwhdesc: json["xfwhdesc"],
    xqtyfin: json["xqtyfin"],
    xparentitem: json["xparentitem"],
    xparentitemdesc: json["xparentitemdesc"],
    xwh: json["xwh"],
    xwhdesc: json["xwhdesc"],
    xunit: json["xunit"],
    xwastitem: json["xwastitem"],
    xwastitemdesc: json["xwastitemdesc"],
    xtwh: json["xtwh"],
    xtwhdesc: json["xtwhdesc"],
    xwastqty: json["xwastqty"],
    xstatustor: json["xstatustor"],
    xstatustordesc: json["xstatustordesc"],
    xlong: json["xlong"],
    xnote: json["xnote"],
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
    "xtornum": xtornum,
    "xdate": xdate,
    "xfwh": xfwh,
    "xfwhdesc": xfwhdesc,
    "xqtyfin": xqtyfin,
    "xparentitem": xparentitem,
    "xparentitemdesc": xparentitemdesc,
    "xwh": xwh,
    "xwhdesc": xwhdesc,
    "xunit": xunit,
    "xwastitem": xwastitem,
    "xwastitemdesc": xwastitemdesc,
    "xtwh": xtwh,
    "xtwhdesc": xtwhdesc,
    "xwastqty": xwastqty,
    "xstatustor": xstatustor,
    "xstatustordesc": xstatustordesc,
    "xlong": xlong,
    "xnote": xnote,
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
