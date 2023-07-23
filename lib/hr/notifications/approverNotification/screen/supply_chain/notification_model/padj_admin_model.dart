// To parse this JSON data, do
//
//     final padjNoticationModel = padjNoticationModelFromJson(jsonString);

import 'dart:convert';

List<PadjNoticationModel> padjNoticationModelFromJson(String str) =>
    List<PadjNoticationModel>.from(
        json.decode(str).map((x) => PadjNoticationModel.fromJson(x)));

String padjNoticationModelToJson(List<PadjNoticationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PadjNoticationModel {
  PadjNoticationModel({
    required this.xporeqnum,
    required this.xdate,
    required this.xtype,
    required this.xtwh,
    required this.xdesc,
    required this.xfwh,
    required this.store,
    required this.xstatusreq,
    required this.xadvnum,
    required this.xstaff,
    required this.sname,
    required this.xtornum,
    required this.xprime,
    required this.xnote,
    required this.prename,
    required this.predesi,
    required this.predept,
    required this.reviewName,
    required this.reviewDesi,
    required this.reviewDept,
  });

  String xporeqnum;
  String xdate;
  String xtype;
  String xtwh;
  String xdesc;
  String xfwh;
  String store;
  String xstatusreq;
  String xadvnum;
  String xstaff;
  String sname;
  String xtornum;
  String xprime;
  String xnote;
  String prename;
  String predesi;
  String predept;
  String reviewName;
  String reviewDesi;
  String reviewDept;

  factory PadjNoticationModel.fromJson(Map<String, dynamic> json) =>
      PadjNoticationModel(
        xporeqnum: json["xporeqnum"] ?? " ",
        xdate: json["xdate"] ?? " ",
        xtype: json["xtype"] ?? " ",
        xtwh: json["xtwh"] ?? " ",
        xdesc: json["xdesc"] ?? " ",
        xfwh: json["xfwh"] ?? " ",
        store: json["store"] ?? " ",
        xstatusreq: json["xstatusreq"] ?? " ",
        xadvnum: json["xadvnum"] ?? " ",
        xstaff: json["xstaff"] ?? " ",
        sname: json["sname"] ?? " ",
        xtornum: json["xtornum"] ?? " ",
        xprime: json["xprime"] ?? " ",
        xnote: json["xnote"] ?? " ",
        prename: json["prename"] ?? " ",
        predesi: json["predesi"] ?? " ",
        predept: json["predept"] ?? " ",
        reviewName: json["review_name"] ?? " ",
        reviewDesi: json["review_desi"] ?? " ",
        reviewDept: json["review_dept"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "xporeqnum": xporeqnum,
        "xdate": xdate,
        "xtype": xtype,
        "xtwh": xtwh,
        "xdesc": xdesc,
        "xfwh": xfwh,
        "store": store,
        "xstatusreq": xstatusreq,
        "xadvnum": xadvnum,
        "xstaff": xstaff,
        "sname": sname,
        "xtornum": xtornum,
        "xprime": xprime,
        "xnote": xnote,
        "prename": prename,
        "predesi": predesi,
        "predept": predept,
        "review_name": reviewName,
        "review_desi": reviewDesi,
        "review_dept": reviewDept,
      };
}
