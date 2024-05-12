// To parse this JSON data, do
//
//     final batAdminModel = batAdminModelFromJson(jsonString);

import 'dart:convert';

List<BatAdminModel> batAdminModelFromJson(String str) => List<BatAdminModel>.from(json.decode(str).map((x) => BatAdminModel.fromJson(x)));

String batAdminModelToJson(List<BatAdminModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatAdminModel {
  String? zid;
  String? xbatch;
  String? xdate;
  String? xbomkey;
  String? xbomdesc;
  String? xitem;
  String? xitemdesc;
  String? xwhcompdesc;
  String? xqtyprd;
  String? xwhdesc;
  String? xmoprcsdesc;
  String? xmachinenodesc;
  String? xarmno;
  String? xrefstaff;
  String? xrefstaffdesc;
  String? xshiftdesc;
  String? xnoworker;
  String? xshiftengr;
  String? xshiftengrdesc;
  String? xwastqty;
  String? xwhwastdesc;
  String? xwastitem;
  String? xwastitemdesc;
  String? xstatusmor;
  String? descxstatusmor;
  String? xlong;
  String? xstatus;
  String? descxstatus;
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

  BatAdminModel({
    this.zid,
    this.xbatch,
    this.xdate,
    this.xbomkey,
    this.xbomdesc,
    this.xitem,
    this.xitemdesc,
    this.xwhcompdesc,
    this.xqtyprd,
    this.xwhdesc,
    this.xmoprcsdesc,
    this.xmachinenodesc,
    this.xarmno,
    this.xrefstaff,
    this.xrefstaffdesc,
    this.xshiftdesc,
    this.xnoworker,
    this.xshiftengr,
    this.xshiftengrdesc,
    this.xwastqty,
    this.xwhwastdesc,
    this.xwastitem,
    this.xwastitemdesc,
    this.xstatusmor,
    this.descxstatusmor,
    this.xlong,
    this.xstatus,
    this.descxstatus,
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

  factory BatAdminModel.fromJson(Map<String, dynamic> json) => BatAdminModel(
    zid: json["zid"],
    xbatch: json["xbatch"],
    xdate: json["xdate"],
    xbomkey: json["xbomkey"],
    xbomdesc: json["xbomdesc"],
    xitem: json["xitem"],
    xitemdesc: json["xitemdesc"],
    xwhcompdesc: json["xwhcompdesc"],
    xqtyprd: json["xqtyprd"],
    xwhdesc: json["xwhdesc"],
    xmoprcsdesc: json["xmoprcsdesc"],
    xmachinenodesc: json["xmachinenodesc"],
    xarmno: json["xarmno"],
    xrefstaff: json["xrefstaff"],
    xrefstaffdesc: json["xrefstaffdesc"],
    xshiftdesc: json["xshiftdesc"],
    xnoworker: json["xnoworker"],
    xshiftengr: json["xshiftengr"],
    xshiftengrdesc: json["xshiftengrdesc"],
    xwastqty: json["xwastqty"],
    xwhwastdesc: json["xwhwastdesc"],
    xwastitem: json["xwastitem"],
    xwastitemdesc: json["xwastitemdesc"],
    xstatusmor: json["xstatusmor"],
    descxstatusmor: json["descxstatusmor"],
    xlong: json["xlong"],
    xstatus: json["xstatus"],
    descxstatus: json["descxstatus"],
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
    "xbatch": xbatch,
    "xdate": xdate,
    "xbomkey": xbomkey,
    "xbomdesc": xbomdesc,
    "xitem": xitem,
    "xitemdesc": xitemdesc,
    "xwhcompdesc": xwhcompdesc,
    "xqtyprd": xqtyprd,
    "xwhdesc": xwhdesc,
    "xmoprcsdesc": xmoprcsdesc,
    "xmachinenodesc": xmachinenodesc,
    "xarmno": xarmno,
    "xrefstaff": xrefstaff,
    "xrefstaffdesc": xrefstaffdesc,
    "xshiftdesc": xshiftdesc,
    "xnoworker": xnoworker,
    "xshiftengr": xshiftengr,
    "xshiftengrdesc": xshiftengrdesc,
    "xwastqty": xwastqty,
    "xwhwastdesc": xwhwastdesc,
    "xwastitem": xwastitem,
    "xwastitemdesc": xwastitemdesc,
    "xstatusmor": xstatusmor,
    "descxstatusmor": descxstatusmor,
    "xlong": xlong,
    "xstatus": xstatus,
    "descxstatus": descxstatus,
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
