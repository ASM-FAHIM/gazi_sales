// To parse this JSON data, do
//
//     final pettyDetailsModel = pettyDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PettyDetailsModel> pettyDetailsModelFromJson(String str) =>
    List<PettyDetailsModel>.from(
        json.decode(str).map((x) => PettyDetailsModel.fromJson(x)));

String pettyDetailsModelToJson(List<PettyDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PettyDetailsModel {
  String zid;
  String xbillno;
  String xrow;
  String xstaff;
  String name;
  String xprime;
  String xpurpose;
  String xlong;

  PettyDetailsModel({
    required this.zid,
    required this.xbillno,
    required this.xrow,
    required this.xstaff,
    required this.name,
    required this.xprime,
    required this.xpurpose,
    required this.xlong,
  });

  factory PettyDetailsModel.fromJson(Map<String, dynamic> json) =>
      PettyDetailsModel(
        zid: json["zid"],
        xbillno: json["xbillno"],
        xrow: json["xrow"],
        xstaff: json["xstaff"],
        name: json["name"],
        xprime: json["xprime"],
        xpurpose: json["xpurpose"],
        xlong: json["xlong"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xbillno": xbillno,
        "xrow": xrow,
        "xstaff": xstaff,
        "name": name,
        "xprime": xprime,
        "xpurpose": xpurpose,
        "xlong": xlong,
      };
}
