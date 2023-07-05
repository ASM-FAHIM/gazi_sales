// To parse this JSON data, do
//
//     final dealerWiseDepoModel = dealerWiseDepoModelFromJson(jsonString);

import 'dart:convert';

List<DealerWiseDepoModel> dealerWiseDepoModelFromJson(String str) =>
    List<DealerWiseDepoModel>.from(
        json.decode(str).map((x) => DealerWiseDepoModel.fromJson(x)));

String dealerWiseDepoModelToJson(List<DealerWiseDepoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealerWiseDepoModel {
  String xdepositnum;
  String xdate;
  String xcus;
  String cusname;
  String xstatus;
  String xbank;
  String bankName;
  String xbranch;
  String xdepositref;
  String xarnature;
  String xpaymenttype;
  String xamount;

  DealerWiseDepoModel({
    required this.xdepositnum,
    required this.xdate,
    required this.xcus,
    required this.cusname,
    required this.xstatus,
    required this.xbank,
    required this.bankName,
    required this.xbranch,
    required this.xdepositref,
    required this.xarnature,
    required this.xpaymenttype,
    required this.xamount,
  });

  factory DealerWiseDepoModel.fromJson(Map<String, dynamic> json) =>
      DealerWiseDepoModel(
        xdepositnum: json["xdepositnum"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        cusname: json["cusname"],
        xstatus: json["xstatus"],
        xbank: json["xbank"],
        bankName: json["bankName"],
        xbranch: json["xbranch"],
        xdepositref: json["xdepositref"],
        xarnature: json["xarnature"] ?? '',
        xpaymenttype: json["xpaymenttype"] ?? '',
        xamount: json["xamount"] ?? '',
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
        "xarnature": xarnature,
        "xpaymenttype": xpaymenttype,
        "xamount": xamount,
      };
}
