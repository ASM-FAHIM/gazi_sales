// To parse this JSON data, do
//
//     final giftModel = giftModelFromJson(jsonString);

import 'dart:convert';

List<GiftModel> giftModelFromJson(String str) => List<GiftModel>.from(json.decode(str).map((x) => GiftModel.fromJson(x)));

String giftModelToJson(List<GiftModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GiftModel {
  GiftModel({
    required this.type,
    required this.xitem,
    required this.itemName,
    required this.xwh,
    required this.xgiftitem,
    required this.giftName,
    required this.xqty,
    required this.xqtybonus,
  });

  String type;
  String xitem;
  String itemName;
  String xwh;
  String xgiftitem;
  String giftName;
  String xqty;
  String xqtybonus;

  factory GiftModel.fromJson(Map<String, dynamic> json) => GiftModel(
    type: json["type"],
    xitem: json["xitem"],
    itemName: json["itemName"],
    xwh: json["xwh"],
    xgiftitem: json["xgiftitem"],
    giftName: json["giftName"],
    xqty: json["xqty"],
    xqtybonus: json["xqtybonus"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "xitem": xitem,
    "itemName": itemName,
    "xwh": xwh,
    "xgiftitem": xgiftitem,
    "giftName": giftName,
    "xqty": xqty,
    "xqtybonus": xqtybonus,
  };
}

List<PromoModel> promoModelFromJson(String str) => List<PromoModel>.from(json.decode(str).map((x) => PromoModel.fromJson(x)));

String promoModelToJson(List<PromoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromoModel {
  PromoModel({
    required this.type,
    required this.xitem,
    required this.itemName,
    required this.xwh,
    required this.xgiftitem,
    this.giftName,
    required this.xqty,
    required this.xqtybonus,
    required this.xqty1,
    required this.xqtybonus1,
    required this.xqty2,
    required this.xqtybonus2,
    required this.xqty3,
    required this.xqtybonus3,
    required this.xqty4,
    required this.xqtybonus4,
  });

  String type;
  String xitem;
  String itemName;
  String xwh;
  String xgiftitem;
  dynamic giftName;
  int xqty;
  int xqtybonus;
  int xqty1;
  int xqtybonus1;
  int xqty2;
  int xqtybonus2;
  int xqty3;
  int xqtybonus3;
  int xqty4;
  int xqtybonus4;

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
    type: json["type"],
    xitem: json["xitem"],
    itemName: json["itemName"],
    xwh: json["xwh"],
    xgiftitem: json["xgiftitem"],
    giftName: json["giftName"],
    xqty: json["xqty"],
    xqtybonus: json["xqtybonus"],
    xqty1: json["xqty1"],
    xqtybonus1: json["xqtybonus1"],
    xqty2: json["xqty2"],
    xqtybonus2: json["xqtybonus2"],
    xqty3: json["xqty3"],
    xqtybonus3: json["xqtybonus3"],
    xqty4: json["xqty4"],
    xqtybonus4: json["xqtybonus4"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "xitem": xitem,
    "itemName": itemName,
    "xwh": xwh,
    "xgiftitem": xgiftitem,
    "giftName": giftName,
    "xqty": xqty,
    "xqtybonus": xqtybonus,
    "xqty1": xqty1,
    "xqtybonus1": xqtybonus1,
    "xqty2": xqty2,
    "xqtybonus2": xqtybonus2,
    "xqty3": xqty3,
    "xqtybonus3": xqtybonus3,
    "xqty4": xqty4,
    "xqtybonus4": xqtybonus4,
  };
}

