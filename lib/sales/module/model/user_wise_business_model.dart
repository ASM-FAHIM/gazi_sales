// To parse this JSON data, do
//
//     final userWiseBusinessModel = userWiseBusinessModelFromJson(jsonString);

import 'dart:convert';

List<UserWiseBusinessModel> userWiseBusinessModelFromJson(String str) => List<UserWiseBusinessModel>.from(json.decode(str).map((x) => UserWiseBusinessModel.fromJson(x)));

String userWiseBusinessModelToJson(List<UserWiseBusinessModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserWiseBusinessModel {
  UserWiseBusinessModel({
    required this.zid,
    required this.zorg,
  });

  String zid;
  String zorg;

  factory UserWiseBusinessModel.fromJson(Map<String, dynamic> json) => UserWiseBusinessModel(
    zid: json["zid"],
    zorg: json["zorg"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "zorg": zorg,
  };
}
