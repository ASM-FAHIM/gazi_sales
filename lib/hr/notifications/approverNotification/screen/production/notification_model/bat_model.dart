// To parse this JSON data, do
//
//     final batAdminModel = batAdminModelFromJson(jsonString);

import 'dart:convert';

List<BatAdminModel> batAdminModelFromJson(String str) =>
    List<BatAdminModel>.from(
        json.decode(str).map((x) => BatAdminModel.fromJson(x)));

String batAdminModelToJson(List<BatAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatAdminModel {
  String zid;
  String xbatch;
  String xdate;
  String xbomkey;
  String xbomdesc;
  String xitem;
  String xitemdesc;
  String xwhcompdesc;
  String xqtyprd;
  String xwhdesc;
  String xmoprcsdesc;
  String xmachinenodesc;
  String xarmno;
  String xrefstaff;
  String xrefstaffdesc;
  String xshiftdesc;
  String xnoworker;
  String xshiftengr;
  String xshiftengrdesc;
  String xwastqty;
  String xwhwastdesc;
  String xwastitem;
  String xwastitemdesc;
  String xstatusmor;
  String descxstatusmor;
  String xlong;
  String xstatus;
  String descxstatus;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  BatAdminModel({
    required this.zid,
    required this.xbatch,
    required this.xdate,
    required this.xbomkey,
    required this.xbomdesc,
    required this.xitem,
    required this.xitemdesc,
    required this.xwhcompdesc,
    required this.xqtyprd,
    required this.xwhdesc,
    required this.xmoprcsdesc,
    required this.xmachinenodesc,
    required this.xarmno,
    required this.xrefstaff,
    required this.xrefstaffdesc,
    required this.xshiftdesc,
    required this.xnoworker,
    required this.xshiftengr,
    required this.xshiftengrdesc,
    required this.xwastqty,
    required this.xwhwastdesc,
    required this.xwastitem,
    required this.xwastitemdesc,
    required this.xstatusmor,
    required this.descxstatusmor,
    required this.xlong,
    required this.xstatus,
    required this.descxstatus,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
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
      };
}
