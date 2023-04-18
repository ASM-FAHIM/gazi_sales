// To parse this JSON data, do
//
//     final offlineLoginModel = offlineLoginModelFromJson(jsonString);

import 'dart:convert';

List<OfflineLoginModel> offlineLoginModelFromJson(String str) => List<OfflineLoginModel>.from(json.decode(str).map((x) => OfflineLoginModel.fromJson(x)));

String offlineLoginModelToJson(List<OfflineLoginModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfflineLoginModel {
  OfflineLoginModel({
    required this.xname,
    required this.xstaff,
    required this.xdeptname,
    required this.xposition,
    required this.xempbank,
    required this.xacc,
    required this.xsex,
    required this.xempcategory,
    required this.xrole,
    required this.zemail,
    required this.xpassword,
    required this.xdesignation,
    required this.xsid,
    required this.supname,
  });

  String xname;
  String xstaff;
  String xdeptname;
  String xposition;
  String xempbank;
  String xacc;
  String xsex;
  String xempcategory;
  String xrole;
  String zemail;
  String xpassword;
  String xdesignation;
  String xsid;
  String supname;

  factory OfflineLoginModel.fromJson(Map<String, dynamic> json) => OfflineLoginModel(
    xname: json["xname"],
    xstaff: json["xstaff"],
    xdeptname: json["xdeptname"],
    xposition: json["xposition"],
    xempbank: json["xempbank"],
    xacc: json["xacc"],
    xsex: json["xsex"],
    xempcategory: json["xempcategory"],
    xrole: json["xrole"],
    zemail: json["zemail"],
    xpassword: json["xpassword"],
    xdesignation: json["xdesignation"],
    xsid: json["xsid"],
    supname: json["supname"],
  );

  Map<String, dynamic> toJson() => {
    "xname": xname,
    "xstaff": xstaff,
    "xdeptname": xdeptname,
    "xposition": xposition,
    "xempbank": xempbank,
    "xacc": xacc,
    "xsex": xsex,
    "xempcategory": xempcategory,
    "xrole": xrole,
    "zemail": zemail,
    "xpassword": xpassword,
    "xdesignation": xdesignation,
    "xsid": xsid,
    "supname": supname,
  };
}
