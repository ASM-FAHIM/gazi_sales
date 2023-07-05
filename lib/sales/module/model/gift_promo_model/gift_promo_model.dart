// To parse this JSON data, do
//
//     final giftModel = giftModelFromJson(jsonString);

import 'dart:convert';

List<GiftModel> giftModelFromJson(String str) =>
    List<GiftModel>.from(json.decode(str).map((x) => GiftModel.fromJson(x)));

String giftModelToJson(List<GiftModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GiftModel {
  GiftModel({
    required this.zid,
    required this.xrow,
    required this.xwh,
    required this.xitem,
    required this.xgiftitem,
    required this.xqty,
    required this.xqtybonus,
    required this.xdateeff,
    required this.xdateexp,
  });

  int zid;
  int xrow;
  String xwh;
  String xitem;
  String xgiftitem;
  String xqty;
  int xqtybonus;
  String xdateeff;
  String xdateexp;

  factory GiftModel.fromJson(Map<String, dynamic> json) => GiftModel(
        zid: json["zid"],
        xrow: json["xrow"],
        xwh: json["xwh"],
        xitem: json["xitem"],
        xgiftitem: json["xgiftitem"],
        xqty: json["xqty"],
        xqtybonus: json["xqtybonus"],
        xdateeff: json["xdateeff"],
        xdateexp: json["xdateexp"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xrow": xrow,
        "xwh": xwh,
        "xitem": xitem,
        "xgiftitem": xgiftitem,
        "xqty": xqty,
        "xqtybonus": xqtybonus,
        "xdateeff": xdateeff,
        "xdateexp": xdateexp,
      };
}
