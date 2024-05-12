// To parse this JSON data, do
//
//     final listPromotionModel = listPromotionModelFromJson(jsonString);

import 'dart:convert';

List<ListPromotionModel> listPromotionModelFromJson(String str) =>
    List<ListPromotionModel>.from(
        json.decode(str).map((x) => ListPromotionModel.fromJson(x)));

String listPromotionModelToJson(List<ListPromotionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPromotionModel {
  int zid;
  String xtrnnum;
  String xfdate;
  String xtdate;
  String xstype;
  String xcolor;
  String xfslab;
  String xtslab;
  String xamount;

  ListPromotionModel({
    required this.zid,
    required this.xtrnnum,
    required this.xfdate,
    required this.xtdate,
    required this.xstype,
    required this.xcolor,
    required this.xfslab,
    required this.xtslab,
    required this.xamount,
  });

  factory ListPromotionModel.fromJson(Map<String, dynamic> json) =>
      ListPromotionModel(
        zid: json["zid"],
        xtrnnum: json["xtrnnum"],
        xfdate: json["xfdate"],
        xtdate: json["xtdate"],
        xstype: json["xstype"],
        xcolor: json["xcolor"],
        xfslab: json["xfslab"],
        xtslab: json["xtslab"],
        xamount: json["xamount"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xtrnnum": xtrnnum,
        "xfdate": xfdate,
        "xtdate": xtdate,
        "xstype": xstype,
        "xcolor": xcolor,
        "xfslab": xfslab,
        "xtslab": xtslab,
        "xamount": xamount,
      };
}
