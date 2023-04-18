// To parse this JSON data, do
//
//     final mrpNotificationListModel = mrpNotificationListModelFromJson(jsonString);

import 'dart:convert';

List<MrpNotificationListModel> mrpNotificationListModelFromJson(String str) => List<MrpNotificationListModel>.from(json.decode(str).map((x) => MrpNotificationListModel.fromJson(x)));

String mrpNotificationListModelToJson(List<MrpNotificationListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MrpNotificationListModel {
  MrpNotificationListModel({
    required this.xdate,
    required this.xnamem,
    required this.xmobile,
    required this.xname,
    required this.xgtotal,
  });

  String xdate;
  String xnamem;
  String xmobile;
  String xname;
  String xgtotal;

  factory MrpNotificationListModel.fromJson(Map<String, dynamic> json) => MrpNotificationListModel(
    xdate: json["xdate"],
    xnamem: json["xnamem"],
    xmobile: json["xmobile"],
    xname: json["xname"],
    xgtotal: json["xgtotal"],
  );

  Map<String, dynamic> toJson() => {
    "xdate": xdate,
    "xnamem": xnamem,
    "xmobile": xmobile,
    "xname": xname,
    "xgtotal": xgtotal,
  };
}
