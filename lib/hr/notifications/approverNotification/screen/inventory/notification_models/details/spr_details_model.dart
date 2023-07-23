// To parse this JSON data, do
//
//     final adminSprDetailsModel = adminSprDetailsModelFromJson(jsonString);

import 'dart:convert';

List<AdminSprDetailsModel> adminSprDetailsModelFromJson(String str) =>
    List<AdminSprDetailsModel>.from(
        json.decode(str).map((x) => AdminSprDetailsModel.fromJson(x)));

String adminSprDetailsModelToJson(List<AdminSprDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminSprDetailsModel {
  AdminSprDetailsModel({
    required this.xdesc,
    required this.partno,
    required this.ztime,
    required this.zutime,
    required this.zauserid,
    required this.zuuserid,
    required this.zid,
    required this.xtornum,
    required this.xrow,
    required this.xitem,
    required this.xqtyord,
    required this.xunit,
    required this.xrate,
    required this.xlineamt,
    required this.xvatrate,
    required this.xbatch,
    required this.xqtyreq,
    required this.xqtycom,
    required this.xstype,
    required this.xnote,
    required this.xdocrow,
    required this.xorderrow,
    required this.xgitem,
    required this.xprepqty,
    required this.xdphqty,
    required this.xqtypor,
    required this.xqtyalc,
    required this.xbrand,
    required this.xserial,
    required this.xqtycrn,
    required this.xsrnum,
    required this.xdate,
    required this.xbinref,
    required this.xqtylead,
  });

  String xdesc;
  String partno;
  Ztime ztime;
  dynamic zutime;
  String zauserid;
  dynamic zuuserid;
  int zid;
  String xtornum;
  int xrow;
  String xitem;
  String xqtyord;
  String xunit;
  String xrate;
  String xlineamt;
  dynamic xvatrate;
  dynamic xbatch;
  String xqtyreq;
  String xqtycom;
  dynamic xstype;
  String xnote;
  dynamic xdocrow;
  dynamic xorderrow;
  dynamic xgitem;
  String xprepqty;
  String xdphqty;
  String xqtypor;
  String xqtyalc;
  String xbrand;
  dynamic xserial;
  dynamic xqtycrn;
  dynamic xsrnum;
  dynamic xdate;
  dynamic xbinref;
  dynamic xqtylead;

  factory AdminSprDetailsModel.fromJson(Map<String, dynamic> json) =>
      AdminSprDetailsModel(
        xdesc: json["xdesc"] ?? " ",
        partno: json["partno"] ?? " ",
        ztime: Ztime.fromJson(json["ztime"]),
        zutime: json["zutime"] ?? " ",
        zauserid: json["zauserid"] ?? " ",
        zuuserid: json["zuuserid"] ?? " ",
        zid: json["zid"] ?? " ",
        xtornum: json["xtornum"] ?? " ",
        xrow: json["xrow"] ?? " ",
        xitem: json["xitem"] ?? " ",
        xqtyord: json["xqtyord"] ?? " ",
        xunit: json["xunit"] ?? " ",
        xrate: json["xrate"] ?? " ",
        xlineamt: json["xlineamt"] ?? " ",
        xvatrate: json["xvatrate"] ?? " ",
        xbatch: json["xbatch"] ?? " ",
        xqtyreq: json["xqtyreq"] ?? " ",
        xqtycom: json["xqtycom"] ?? " ",
        xstype: json["xstype"] ?? " ",
        xnote: json["xnote"] ?? " ",
        xdocrow: json["xdocrow"] ?? " ",
        xorderrow: json["xorderrow"] ?? " ",
        xgitem: json["xgitem"] ?? " ",
        xprepqty: json["xprepqty"] ?? " ",
        xdphqty: json["xdphqty"] ?? " ",
        xqtypor: json["xqtypor"] ?? " ",
        xqtyalc: json["xqtyalc"] ?? " ",
        xbrand: json["xbrand"] ?? " ",
        xserial: json["xserial"] ?? " ",
        xqtycrn: json["xqtycrn"] ?? " ",
        xsrnum: json["xsrnum"] ?? " ",
        xdate: json["xdate"] ?? " ",
        xbinref: json["xbinref"] ?? " ",
        xqtylead: json["xqtylead"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "xdesc": xdesc,
        "partno": partno,
        "ztime": ztime.toJson(),
        "zutime": zutime,
        "zauserid": zauserid,
        "zuuserid": zuuserid,
        "zid": zid,
        "xtornum": xtornum,
        "xrow": xrow,
        "xitem": xitem,
        "xqtyord": xqtyord,
        "xunit": xunit,
        "xrate": xrate,
        "xlineamt": xlineamt,
        "xvatrate": xvatrate,
        "xbatch": xbatch,
        "xqtyreq": xqtyreq,
        "xqtycom": xqtycom,
        "xstype": xstype,
        "xnote": xnote,
        "xdocrow": xdocrow,
        "xorderrow": xorderrow,
        "xgitem": xgitem,
        "xprepqty": xprepqty,
        "xdphqty": xdphqty,
        "xqtypor": xqtypor,
        "xqtyalc": xqtyalc,
        "xbrand": xbrand,
        "xserial": xserial,
        "xqtycrn": xqtycrn,
        "xsrnum": xsrnum,
        "xdate": xdate,
        "xbinref": xbinref,
        "xqtylead": xqtylead,
      };
}

class Ztime {
  Ztime({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  DateTime date;
  int timezoneType;
  String timezone;

  factory Ztime.fromJson(Map<String, dynamic> json) => Ztime(
        date: DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"] ?? " ",
        timezone: json["timezone"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}
