// To parse this JSON data, do
//
//     final promoHeaderModel = promoHeaderModelFromJson(jsonString);

import 'dart:convert';

List<PromoHeaderModel> promoHeaderModelFromJson(String str) =>
    List<PromoHeaderModel>.from(
        json.decode(str).map((x) => PromoHeaderModel.fromJson(x)));

String promoHeaderModelToJson(List<PromoHeaderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromoHeaderModel {
  int? id;
  int zid;
  String xtrnnum;
  String xstype;
  String xfdate;
  String xtdate;
  String xref;

  PromoHeaderModel({
    this.id,
    required this.zid,
    required this.xtrnnum,
    required this.xstype,
    required this.xfdate,
    required this.xtdate,
    required this.xref,
  });

  factory PromoHeaderModel.fromJson(Map<String, dynamic> json) =>
      PromoHeaderModel(
        id: json["id"],
        zid: json["zid"],
        xtrnnum: json["xtrnnum"],
        xstype: json["xstype"],
        xfdate: json["xfdate"],
        xtdate: json["xtdate"],
        xref: json["xref"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xtrnnum": xtrnnum,
        "xstype": xstype,
        "xfdate": xfdate,
        "xtdate": xtdate,
        "xref": xref,
      };
}
