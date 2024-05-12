// To parse this JSON data, do
//
//     final tsoInfoListModel = tsoInfoListModelFromJson(jsonString);

import 'dart:convert';

List<TsoInfoListModel> tsoInfoListModelFromJson(String str) =>
    List<TsoInfoListModel>.from(
        json.decode(str).map((x) => TsoInfoListModel.fromJson(x)));

String tsoInfoListModelToJson(List<TsoInfoListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TsoInfoListModel {
  String zid;
  String achievement;
  String target;
  String totalSo;
  String totalDPnum;

  TsoInfoListModel({
    required this.zid,
    required this.achievement,
    required this.target,
    required this.totalSo,
    required this.totalDPnum,
  });

  factory TsoInfoListModel.fromJson(Map<String, dynamic> json) =>
      TsoInfoListModel(
        zid: json["zid"],
        achievement: json["achievement"],
        target: json["target"],
        totalSo: json["totalSO"],
        totalDPnum: json["totalDPnum"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "achievement": achievement,
        "target": target,
        "totalSO": totalSo,
        "totalDPnum": totalDPnum,
      };
}
