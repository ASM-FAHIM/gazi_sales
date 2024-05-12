// To parse this JSON data, do
//
//     final allDashboard = allDashboardFromJson(jsonString);

import 'dart:convert';

AllDashboard allDashboardFromJson(String str) => AllDashboard.fromJson(json.decode(str));

String allDashboardToJson(AllDashboard data) => json.encode(data.toJson());

class AllDashboard {
  String xdate6;
  String xOrder;
  String xDelivery;
  // String xDeposit;
  String xCollection;

  AllDashboard({
    required this.xdate6,
    required this.xOrder,
    required this.xDelivery,
    // required this.xDeposit,
    required this.xCollection,
  });

  factory AllDashboard.fromJson(Map<String, dynamic> json) => AllDashboard(
    xdate6: json["xdate6"],
    xOrder: json["XOrder"],
    xDelivery: json["XDelivery"],
    //xDeposit: json["XDeposit"],
    xCollection: json["XCollection"],
  );

  Map<String, dynamic> toJson() => {
    "xdate6": xdate6,
    "XOrder": xOrder,
    "XDelivery": xDelivery,
    //"XDeposit": xDeposit,
    "XCollection": xCollection,
  };
}
