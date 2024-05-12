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
  String xdepositnum;
  String xdate;
  String xcus;
  String cusname;
  String xstatus;
  String xbank;
  String bankName;
  String xbranch;
  String xdepositref;
  String xamount;
  String xidsup;
  String sup_name;
  String xarnature;
  String reject_note;


  DepositNotificationModel({
    required this.xdepositnum,
    required this.xdate,
    required this.xcus,
    required this.cusname,
    required this.xstatus,
    required this.xbank,
    required this.bankName,
    required this.xbranch,
    required this.xdepositref,
    required this.xamount,
    required this.xidsup,
    required this.sup_name,
    required this.xarnature,
    required this.reject_note,
  });

  factory DepositNotificationModel.fromJson(Map<String, dynamic> json) =>
      DepositNotificationModel(
        xdepositnum: json["xdepositnum"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        cusname: json["cusname"],
        xstatus: json["xstatus"],
        xbank: json["xbank"],
        bankName: json["bankName"],
        xbranch: json["xbranch"],
        xdepositref: json["xdepositref"],
        xamount: json["xamount"],
        xidsup: json["xidsup"],
        sup_name: json["sup_name"],
        xarnature: json["xarnature"],
        reject_note: json["reject_note"]
      );

  Map<String, dynamic> toJson() => {
        "xdepositnum": xdepositnum,
        "xdate": xdate,
        "xcus": xcus,
        "cusname": cusname,
        "xstatus": xstatus,
        "xbank": xbank,
        "bankName": bankName,
        "xbranch": xbranch,
        "xdepositref": xdepositref,
        "xamount": xamount,
        "xidsup": xidsup,
        "sup_name": sup_name,
        "xarnature": xarnature,
        "reject_note": reject_note,

      };
}
