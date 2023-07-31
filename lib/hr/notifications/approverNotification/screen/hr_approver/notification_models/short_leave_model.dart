// To parse this JSON data, do
//
//     final shortLeaveAdminModel = shortLeaveAdminModelFromJson(jsonString);

import 'dart:convert';

List<ShortLeaveAdminModel> shortLeaveAdminModelFromJson(String str) =>
    List<ShortLeaveAdminModel>.from(
        json.decode(str).map((x) => ShortLeaveAdminModel.fromJson(x)));

String shortLeaveAdminModelToJson(List<ShortLeaveAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShortLeaveAdminModel {
  String xrow;
  String xyearperdate;
  String xstaff;
  String xname;
  String designation;
  DateTime xdate;
  String xtypeleave;
  String xshiftimout;
  String xshiftimin;
  String xstatus;

  ShortLeaveAdminModel({
    required this.xrow,
    required this.xyearperdate,
    required this.xstaff,
    required this.xname,
    required this.designation,
    required this.xdate,
    required this.xtypeleave,
    required this.xshiftimout,
    required this.xshiftimin,
    required this.xstatus,
  });

  factory ShortLeaveAdminModel.fromJson(Map<String, dynamic> json) =>
      ShortLeaveAdminModel(
        xrow: json["xrow"],
        xyearperdate: json["xyearperdate"],
        xstaff: json["xstaff"],
        xname: json["xname"],
        designation: json["designation"],
        xdate: DateTime.parse(json["xdate"]),
        xtypeleave: json["xtypeleave"],
        xshiftimout: json["xshiftimout"],
        xshiftimin: json["xshiftimin"],
        xstatus: json["xstatus"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xyearperdate": xyearperdate,
        "xstaff": xstaff,
        "xname": xname,
        "designation": designation,
        "xdate":
            "${xdate.year.toString().padLeft(4, '0')}-${xdate.month.toString().padLeft(2, '0')}-${xdate.day.toString().padLeft(2, '0')}",
        "xtypeleave": xtypeleave,
        "xshiftimout": xshiftimout,
        "xshiftimin": xshiftimin,
        "xstatus": xstatus,
      };
}
