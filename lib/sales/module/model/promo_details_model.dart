// To parse this JSON data, do
//
//     final promoDetailsrModel = promoDetailsrModelFromJson(jsonString);

import 'dart:convert';

List<PromoDetailsrModel> promoDetailsrModelFromJson(String str) =>
    List<PromoDetailsrModel>.from(
        json.decode(str).map((x) => PromoDetailsrModel.fromJson(x)));

String promoDetailsrModelToJson(List<PromoDetailsrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromoDetailsrModel {
  int? id;
  int zid;
  int xrow;
  String xtrnnum;
  String xstype;
  String xcolor;
  String xtype;
  String xfslab;
  String xtslab;
  String xamount;

  PromoDetailsrModel({
    this.id,
    required this.zid,
    required this.xrow,
    required this.xtrnnum,
    required this.xstype,
    required this.xcolor,
    required this.xtype,
    required this.xfslab,
    required this.xtslab,
    required this.xamount,
  });

  factory PromoDetailsrModel.fromJson(Map<String, dynamic> json) =>
      PromoDetailsrModel(
        id: json["id"],
        zid: json["zid"],
        xrow: json["xrow"],
        xtrnnum: json["xtrnnum"],
        xstype: json["xstype"],
        xcolor: json["xcolor"],
        xtype: json["xtype"],
        xfslab: json["xfslab"],
        xtslab: json["xtslab"],
        xamount: json["xamount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xrow": xrow,
        "xtrnnum": xtrnnum,
        "xstype": xstype,
        "xcolor": xcolor,
        "xtype": xtype,
        "xfslab": xfslab,
        "xtslab": xtslab,
        "xamount": xamount,
      };
}
