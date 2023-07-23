// To parse this JSON data, do
//
//     final materialStoreList = materialStoreListFromJson(jsonString);

import 'dart:convert';

List<MaterialStoreList> materialStoreListFromJson(String str) => List<MaterialStoreList>.from(json.decode(str).map((x) => MaterialStoreList.fromJson(x)));

String materialStoreListToJson(List<MaterialStoreList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialStoreList {
  String xwh;
  String xlong;

  MaterialStoreList({
    required this.xwh,
    required this.xlong,
  });

  factory MaterialStoreList.fromJson(Map<String, dynamic> json) => MaterialStoreList(
    xwh: json["xwh"],
    xlong: json["xlong"],
  );

  Map<String, dynamic> toJson() => {
    "xwh": xwh,
    "xlong": xlong,
  };
}
