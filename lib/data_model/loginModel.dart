// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
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
    required this.zactiveopapp
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
  String zactiveopapp;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        xname: json["xname"] ?? '',
        xstaff: json["xstaff"] ?? '',
        xdeptname: json["xdeptname"] ?? '',
        xposition: json["xposition"] ?? '',
        xempbank: json["xempbank"] ?? '',
        xacc: json["xacc"] ?? '',
        xsex: json["xsex"] ?? '',
        xempcategory: json["xempcategory"] ?? '',
        xrole: json["xrole"] ?? '',
        zemail: json["zemail"] ?? '',
        xpassword: json["xpassword"] ?? '',
        xdesignation: json["xdesignation"] ?? '',
        xsid: json["xsid"] ?? '',
        supname: json["supname"] ?? '',
        zactiveopapp: json["zactiveopapp"] ?? '',
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
        "zactiveopapp": zactiveopapp,
      };
}
