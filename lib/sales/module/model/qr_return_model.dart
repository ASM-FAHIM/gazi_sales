// To parse this JSON data, do
//
//     final qrReturnModel = qrReturnModelFromJson(jsonString);

import 'dart:convert';

QrReturnModel qrReturnModelFromJson(String str) => QrReturnModel.fromJson(json.decode(str));

String qrReturnModelToJson(QrReturnModel data) => json.encode(data.toJson());

class QrReturnModel {
  QrReturnModel({
    required this.zid,
    required this.xid,
    required this.xbatch,
    required this.xdate,
    required this.xbase,
    required this.xdisc,
  });

  int zid;
  String xid;
  String xbatch;
  String xdate;
  String xbase;
  String xdisc;

  factory QrReturnModel.fromJson(Map<String, dynamic> json) => QrReturnModel(
    zid: json["zid"],
    xid: json["xid"],
    xbatch: json["xbatch"],
    xdate: json["xdate"],
    xbase: json["xbase"],
    xdisc: json["xdisc"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xid": xid,
    "xbatch": xbatch,
    "xdate": xdate,
    "xbase": xbase,
    "xdisc": xdisc,
  };
}
