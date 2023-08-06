// To parse this JSON data, do
//
//     final depositNotificationModel = depositNotificationModelFromJson(jsonString);

import 'dart:convert';

List<DepositNotificationModel> depositNotificationModelFromJson(String str) =>
    List<DepositNotificationModel>.from(
        json.decode(str).map((x) => DepositNotificationModel.fromJson(x)));

String depositNotificationModelToJson(List<DepositNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepositNotificationModel {
  String zid;
  String xdepositnum;
  String xdepositref;
  String xdate;
  String xcus;
  String cusname;
  String xstatus;
  String statusName;
  String xbank;
  String xbranch;
  String xamount;
  String xpreparer;
  String preparerName;

  DepositNotificationModel({
    required this.zid,
    required this.xdepositnum,
    required this.xdepositref,
    required this.xdate,
    required this.xcus,
    required this.cusname,
    required this.xstatus,
    required this.statusName,
    required this.xbank,
    required this.xbranch,
    required this.xamount,
    required this.xpreparer,
    required this.preparerName,
  });

  factory DepositNotificationModel.fromJson(Map<String, dynamic> json) =>
      DepositNotificationModel(
        zid: json["zid"],
        xdepositnum: json["xdepositnum"],
        xdepositref: json["xdepositref"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        cusname: json["cusname"],
        xstatus: json["xstatus"],
        statusName: json["statusName"],
        xbank: json["xbank"],
        xbranch: json["xbranch"],
        xamount: json["xamount"],
        xpreparer: json["xpreparer"],
        preparerName: json["preparer_name"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xdepositnum": xdepositnum,
        "xdepositref": xdepositref,
        "xdate": xdate,
        "xcus": xcus,
        "cusname": cusname,
        "xstatus": xstatus,
        "statusName": statusName,
        "xbank": xbank,
        "xbranch": xbranch,
        "xamount": xamount,
        "xpreparer": xpreparer,
        "preparer_name": preparerName,
      };
}
