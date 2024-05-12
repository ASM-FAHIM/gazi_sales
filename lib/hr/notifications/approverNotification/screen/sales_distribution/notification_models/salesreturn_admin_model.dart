// To parse this JSON data, do
//
//     final salesReturnNoticationModel = salesReturnNoticationModelFromJson(jsonString);

import 'dart:convert';

List<SalesReturnNoticationModel> salesReturnNoticationModelFromJson(
        String str) =>
    List<SalesReturnNoticationModel>.from(
        json.decode(str).map((x) => SalesReturnNoticationModel.fromJson(x)));

String salesReturnNoticationModelToJson(
        List<SalesReturnNoticationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalesReturnNoticationModel {
  String xcrnnum;
  String xordernum;
  String xdate;
  String xref;
  String xcus;
  String xorg;
  String xtso;
  String executive;
  String zm;
  String dsm;
  String base;
  String zone;
  String division;
  String xwh;
  String xwhdesc;
  String xpnature;
  String xtotamt;
  String xstatus;
  String status;
  String xstatuscrn;
  String statuscrn;
  String xvoucher;
  String xnote1;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  SalesReturnNoticationModel({
    required this.xcrnnum,
    required this.xordernum,
    required this.xdate,
    required this.xref,
    required this.xcus,
    required this.xorg,
    required this.xtso,
    required this.executive,
    required this.zm,
    required this.dsm,
    required this.base,
    required this.zone,
    required this.division,
    required this.xwh,
    required this.xwhdesc,
    required this.xpnature,
    required this.xtotamt,
    required this.xstatus,
    required this.status,
    required this.xstatuscrn,
    required this.statuscrn,
    required this.xvoucher,
    required this.xnote1,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory SalesReturnNoticationModel.fromJson(Map<String, dynamic> json) =>
      SalesReturnNoticationModel(
        xcrnnum: json["xcrnnum"],
        xordernum: json["xordernum"],
        xdate: json["xdate"],
        xref: json["xref"],
        xcus: json["xcus"],
        xorg: json["xorg"],
        xtso: json["xtso"],
        executive: json["Executive"],
        zm: json["ZM"],
        dsm: json["DSM"],
        base: json["Base"],
        zone: json["Zone"],
        division: json["Division"],
        xwh: json["xwh"],
        xwhdesc: json["xwhdesc"],
        xpnature: json["xpnature"],
        xtotamt: json["xtotamt"],
        xstatus: json["xstatus"],
        status: json["status"],
        xstatuscrn: json["xstatuscrn"],
        statuscrn: json["statuscrn"],
        xvoucher: json["xvoucher"],
        xnote1: json["xnote1"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xcrnnum": xcrnnum,
        "xordernum": xordernum,
        "xdate": xdate,
        "xref": xref,
        "xcus": xcus,
        "xorg": xorg,
        "xtso": xtso,
        "Executive": executive,
        "ZM": zm,
        "DSM": dsm,
        "Base": base,
        "Zone": zone,
        "Division": division,
        "xwh": xwh,
        "xwhdesc": xwhdesc,
        "xpnature": xpnature,
        "xtotamt": xtotamt,
        "xstatus": xstatus,
        "status": status,
        "xstatuscrn": xstatuscrn,
        "statuscrn": statuscrn,
        "xvoucher": xvoucher,
        "xnote1": xnote1,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
