// To parse this JSON data, do
//
//     final soModel = soModelFromJson(jsonString);

import 'dart:convert';

List<SoModel> soModelFromJson(String str) =>
    List<SoModel>.from(json.decode(str).map((x) => SoModel.fromJson(x)));

String soModelToJson(List<SoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SoModel {
  String xsonumber;
  String xdate;
  String xcus;
  String cusname;
  String xstatus;
  String statusName;
  String xterritory;
  String tsoName;

  SoModel({
    required this.xsonumber,
    required this.xdate,
    required this.xcus,
    required this.cusname,
    required this.xstatus,
    required this.statusName,
    required this.xterritory,
    required this.tsoName,
  });

  factory SoModel.fromJson(Map<String, dynamic> json) => SoModel(
        xsonumber: json["xsonumber"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        cusname: json["cusname"],
        xstatus: json["xstatus"],
        statusName: json["statusName"],
        xterritory: json["xterritory"],
        tsoName: json["tsoName"],
      );

  Map<String, dynamic> toJson() => {
        "xsonumber": xsonumber,
        "xdate": xdate,
        "xcus": xcus,
        "cusname": cusname,
        "xstatus": xstatus,
        "statusName": statusName,
        "xterritory": xterritory,
        "tsoName": tsoName,
      };
}
