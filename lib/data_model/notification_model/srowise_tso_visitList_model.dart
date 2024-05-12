// To parse this JSON data, do
//
//     final sroWiseTsoVisitList = sroWiseTsoVisitListFromJson(jsonString);

import 'dart:convert';

List<SroWiseTsoVisitList> sroWiseTsoVisitListFromJson(String str) => List<SroWiseTsoVisitList>.from(json.decode(str).map((x) => SroWiseTsoVisitList.fromJson(x)));

String sroWiseTsoVisitListToJson(List<SroWiseTsoVisitList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SroWiseTsoVisitList {
  SroWiseTsoVisitList({
    required this.tsoid,
    required this.name,
  });

  String tsoid;
  String name;

  factory SroWiseTsoVisitList.fromJson(Map<String, dynamic> json) => SroWiseTsoVisitList(
    tsoid: json["TSOID"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "TSOID": tsoid,
    "name": name,
  };
}
