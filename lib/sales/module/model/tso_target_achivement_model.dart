// To parse this JSON data, do
//
//     final tsoTargetachivement = tsoTargetachivementFromJson(jsonString);

import 'dart:convert';

TsoTargetachivement tsoTargetachivementFromJson(String str) => TsoTargetachivement.fromJson(json.decode(str));

String tsoTargetachivementToJson(TsoTargetachivement data) => json.encode(data.toJson());

class TsoTargetachivement {
  String zid;
  String achievement;
  String target;
  int totalSo;
  int totalDPnum;

  TsoTargetachivement({
    required this.zid,
    required this.achievement,
    required this.target,
    required this.totalSo,
    required this.totalDPnum,
  });

  factory TsoTargetachivement.fromJson(Map<String, dynamic> json) => TsoTargetachivement(
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
