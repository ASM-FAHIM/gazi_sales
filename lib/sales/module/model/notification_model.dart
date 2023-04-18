// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.xsonumber,
    required this.xdate,
    required this.xcus,
    required this.cusname,
    required this.xstatusso,
    required this.xterritory,
  });

  String xsonumber;
  String xdate;
  String xcus;
  String cusname;
  String xstatusso;
  String xterritory;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    xsonumber: json["xsonumber"],
    xdate: json["xdate"],
    xcus: json["xcus"],
    cusname: json["cusname"],
    xstatusso: json["xstatusso"],
    xterritory: json["xterritory"],
  );

  Map<String, dynamic> toJson() => {
    "xsonumber": xsonumber,
    "xdate": xdate,
    "xcus": xcus,
    "cusname": cusname,
    "xstatusso": xstatusso,
    "xterritory": xterritory,
  };
}
