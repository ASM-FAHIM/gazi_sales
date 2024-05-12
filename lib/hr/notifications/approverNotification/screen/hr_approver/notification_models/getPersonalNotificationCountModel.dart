// To parse this JSON data, do
//
//     final getPersonalNotificationCount = getPersonalNotificationCountFromJson(jsonString);

import 'dart:convert';

GetPersonalNotificationCount getPersonalNotificationCountFromJson(String str) => GetPersonalNotificationCount.fromJson(json.decode(str));

String getPersonalNotificationCountToJson(GetPersonalNotificationCount data) => json.encode(data.toJson());

class GetPersonalNotificationCount {
  int lateCount;
  int earlyCount;
  int absentCount;
  int leaveCount;

  GetPersonalNotificationCount({
    required this.lateCount,
    required this.earlyCount,
    required this.absentCount,
    required this.leaveCount,
  });

  factory GetPersonalNotificationCount.fromJson(Map<String, dynamic> json) => GetPersonalNotificationCount(
    lateCount: json["lateCount"],
    earlyCount: json["earlyCount"],
    absentCount: json["absentCount"],
    leaveCount: json["leaveCount"],
  );

  Map<String, dynamic> toJson() => {
    "lateCount": lateCount,
    "earlyCount": earlyCount,
    "absentCount": absentCount,
    "leaveCount": leaveCount,
  };
}
