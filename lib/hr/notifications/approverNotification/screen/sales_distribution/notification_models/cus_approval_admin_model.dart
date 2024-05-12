// To parse this JSON data, do
//
//     final cusApprovalModel = cusApprovalModelFromJson(jsonString);

import 'dart:convert';

List<CusApprovalModel> cusApprovalModelFromJson(String str) => List<CusApprovalModel>.from(json.decode(str).map((x) => CusApprovalModel.fromJson(x)));

String cusApprovalModelToJson(List<CusApprovalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CusApprovalModel {
  String? zid;
  String? xcus;
  String? xorg;
  String? xmadd;
  String? xcontact;
  String? xdesignation;
  String? xphone;
  String? xemail;
  String? xgcus;
  String? xtso;
  String? xterritory;
  String? xtsoname;
  String? zm;
  String? dsm;
  String? xzone;
  String? division;
  String? zone;
  String? xdistrict;
  String? xthana;
  String? xstatus;
  String? xstatusdesc;

  CusApprovalModel({
    this.zid,
    this.xcus,
    this.xorg,
    this.xmadd,
    this.xcontact,
    this.xdesignation,
    this.xphone,
    this.xemail,
    this.xgcus,
    this.xtso,
    this.xterritory,
    this.xtsoname,
    this.zm,
    this.dsm,
    this.xzone,
    this.division,
    this.zone,
    this.xdistrict,
    this.xthana,
    this.xstatus,
    this.xstatusdesc,
  });

  factory CusApprovalModel.fromJson(Map<String, dynamic> json) => CusApprovalModel(
    zid: json["zid"],
    xcus: json["xcus"],
    xorg: json["xorg"],
    xmadd: json["xmadd"],
    xcontact: json["xcontact"],
    xdesignation: json["xdesignation"],
    xphone: json["xphone"],
    xemail: json["xemail"],
    xgcus: json["xgcus"],
    xtso: json["xtso"],
    xterritory: json["xterritory"],
    xtsoname: json["xtsoname"],
    zm: json["ZM"],
    dsm: json["DSM"],
    xzone: json["xzone"],
    division: json["Division"],
    zone: json["Zone"],
    xdistrict: json["xdistrict"],
    xthana: json["xthana"],
    xstatus: json["xstatus"],
    xstatusdesc: json["xstatusdesc"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xcus": xcus,
    "xorg": xorg,
    "xmadd": xmadd,
    "xcontact": xcontact,
    "xdesignation": xdesignation,
    "xphone": xphone,
    "xemail": xemail,
    "xgcus": xgcus,
    "xtso": xtso,
    "xterritory": xterritory,
    "xtsoname": xtsoname,
    "ZM": zm,
    "DSM": dsm,
    "xzone": xzone,
    "Division": division,
    "Zone": zone,
    "xdistrict": xdistrict,
    "xthana": xthana,
    "xstatus": xstatus,
    "xstatusdesc": xstatusdesc,
  };
}
