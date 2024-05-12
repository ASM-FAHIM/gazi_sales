// To parse this JSON data, do
//
//     final dcAdminModel = dcAdminModelFromJson(jsonString);

import 'dart:convert';

List<DcAdminModel> dcAdminModelFromJson(String str) => List<DcAdminModel>.from(
    json.decode(str).map((x) => DcAdminModel.fromJson(x)));

String dcAdminModelToJson(List<DcAdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DcAdminModel {
  String xdornum;
  String xdate;
  String xcus;
  String xorg;
  String xwh;
  String xwhdesc;
  String xpaymenttype;
  String xopincapply;
  String xsonumber;
  String xref;
  String xtso;
  String executive;
  String zm;
  String dsm;
  String base;
  String zone;
  String division;
  String xexpamt;
  String xdisctype;
  String xvoucher;
  String xnote1;
  String xstatus;
  String status;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  DcAdminModel({
    required this.xdornum,
    required this.xdate,
    required this.xcus,
    required this.xorg,
    required this.xwh,
    required this.xwhdesc,
    required this.xpaymenttype,
    required this.xopincapply,
    required this.xsonumber,
    required this.xref,
    required this.xtso,
    required this.executive,
    required this.zm,
    required this.dsm,
    required this.base,
    required this.zone,
    required this.division,
    required this.xexpamt,
    required this.xdisctype,
    required this.xvoucher,
    required this.xnote1,
    required this.xstatus,
    required this.status,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory DcAdminModel.fromJson(Map<String, dynamic> json) => DcAdminModel(
        xdornum: json["xdornum"],
        xdate: json["xdate"],
        xcus: json["xcus"],
        xorg: json["xorg"],
        xwh: json["xwh"],
        xwhdesc: json["xwhdesc"],
        xpaymenttype: json["xpaymenttype"],
        xopincapply: json["xopincapply"],
        xsonumber: json["xsonumber"],
        xref: json["xref"],
        xtso: json["xtso"],
        executive: json["Executive"],
        zm: json["ZM"],
        dsm: json["DSM"],
        base: json["Base"],
        zone: json["Zone"],
        division: json["Division"],
        xexpamt: json["xexpamt"],
        xdisctype: json["xdisctype"],
        xvoucher: json["xvoucher"],
        xnote1: json["xnote1"],
        xstatus: json["xstatus"],
        status: json["status"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xdornum": xdornum,
        "xdate": xdate,
        "xcus": xcus,
        "xorg": xorg,
        "xwh": xwh,
        "xwhdesc": xwhdesc,
        "xpaymenttype": xpaymenttype,
        "xopincapply": xopincapply,
        "xsonumber": xsonumber,
        "xref": xref,
        "xtso": xtso,
        "Executive": executive,
        "ZM": zm,
        "DSM": dsm,
        "Base": base,
        "Zone": zone,
        "Division": division,
        "xexpamt": xexpamt,
        "xdisctype": xdisctype,
        "xvoucher": xvoucher,
        "xnote1": xnote1,
        "xstatus": xstatus,
        "status": status,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
