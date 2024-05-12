// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

// import 'dart:convert';
//
// VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));
//
// String versionModelToJson(VersionModel data) => json.encode(data.toJson());
//
// class VersionModel {
//   VersionModel({
//     required required this.versionapp,
//   });
//
//   String versionapp;
//
//   factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
//     versionapp: json["versionapp"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "versionapp": versionapp,
//   };
// }



// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
  VersionModel({
    required this.id,
    required this.version,
    required this.details,
    required this.createdAt,
  });

  String id;
  String version;
  String details;
  DateTime createdAt;

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
    id: json["id"],
    version: json["version"],
    details: json["details"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "version": version,
  "details": details,
  "created_at": createdAt.toIso8601String(),
  };
}