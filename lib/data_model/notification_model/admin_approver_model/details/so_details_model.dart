// To parse this JSON data, do
//
//     final soDetailsModel = soDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SoDetailsModel> soDetailsModelFromJson(String str) => List<SoDetailsModel>.from(json.decode(str).map((x) => SoDetailsModel.fromJson(x)));

String soDetailsModelToJson(List<SoDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoDetailsModel {
  SoDetailsModel({
    required this.descr,
    required this.ztime,
    this.zutime,
    required this.zauserid,
    this.zuuserid,
    required this.zid,
    required this.xsonumber,
    required this.xrow,
    this.xdate,
    required this.xitem,
    required this.xqtyord,
    required this.xunit,
    this.xrate,
    this.xlineamt,
    this.xvatrate,
    this.xbatch,
    required this.xqtyreq,
    this.xqtycom,
    this.xnote,
    this.xdocrow,
    this.xgitem,
    this.xprepqty,
    required this.xdphqty,
    this.xqtypor,
    required this.xqtyalc,
    this.xqtycrn,
    this.xfwh,
    this.xtwh,
  });

  String descr;
  Ztime ztime;
  dynamic zutime;
  String zauserid;
  dynamic zuuserid;
  int zid;
  String xsonumber;
  int xrow;
  dynamic xdate;
  String xitem;
  String xqtyord;
  String xunit;
  dynamic xrate;
  dynamic xlineamt;
  dynamic xvatrate;
  dynamic xbatch;
  String xqtyreq;
  dynamic xqtycom;
  dynamic xnote;
  dynamic xdocrow;
  dynamic xgitem;
  dynamic xprepqty;
  String xdphqty;
  dynamic xqtypor;
  String xqtyalc;
  dynamic xqtycrn;
  dynamic xfwh;
  dynamic xtwh;

  factory SoDetailsModel.fromJson(Map<String, dynamic> json) => SoDetailsModel(
    descr: json["descr"],
    ztime: Ztime.fromJson(json["ztime"]),
    zutime: json["zutime"],
    zauserid: json["zauserid"],
    zuuserid: json["zuuserid"],
    zid: json["zid"],
    xsonumber: json["xsonumber"],
    xrow: json["xrow"],
    xdate: json["xdate"],
    xitem: json["xitem"],
    xqtyord: json["xqtyord"],
    xunit: json["xunit"],
    xrate: json["xrate"],
    xlineamt: json["xlineamt"],
    xvatrate: json["xvatrate"],
    xbatch: json["xbatch"],
    xqtyreq: json["xqtyreq"],
    xqtycom: json["xqtycom"],
    xnote: json["xnote"],
    xdocrow: json["xdocrow"],
    xgitem: json["xgitem"],
    xprepqty: json["xprepqty"],
    xdphqty: json["xdphqty"],
    xqtypor: json["xqtypor"],
    xqtyalc: json["xqtyalc"],
    xqtycrn: json["xqtycrn"],
    xfwh: json["xfwh"],
    xtwh: json["xtwh"],
  );

  Map<String, dynamic> toJson() => {
    "descr": descr,
    "ztime": ztime.toJson(),
    "zutime": zutime,
    "zauserid": zauserid,
    "zuuserid": zuuserid,
    "zid": zid,
    "xsonumber": xsonumber,
    "xrow": xrow,
    "xdate": xdate,
    "xitem": xitem,
    "xqtyord": xqtyord,
    "xunit": xunit,
    "xrate": xrate,
    "xlineamt": xlineamt,
    "xvatrate": xvatrate,
    "xbatch": xbatch,
    "xqtyreq": xqtyreq,
    "xqtycom": xqtycom,
    "xnote": xnote,
    "xdocrow": xdocrow,
    "xgitem": xgitem,
    "xprepqty": xprepqty,
    "xdphqty": xdphqty,
    "xqtypor": xqtypor,
    "xqtyalc": xqtyalc,
    "xqtycrn": xqtycrn,
    "xfwh": xfwh,
    "xtwh": xtwh,
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
    timezoneType: json["timezone_type"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "timezone_type": timezoneType,
    "timezone": timezone,
  };
}
