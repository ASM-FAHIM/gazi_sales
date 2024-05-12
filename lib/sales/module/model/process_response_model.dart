// To parse this JSON data, do
//
//     final processResponseModel = processResponseModelFromJson(jsonString);

import 'dart:convert';

List<ProcessResponseModel> processResponseModelFromJson(String str) => List<ProcessResponseModel>.from(json.decode(str).map((x) => ProcessResponseModel.fromJson(x)));

String processResponseModelToJson(List<ProcessResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProcessResponseModel {
  int xrow;
  String xitem;
  String xqtyreq;
  String itemName;
  String xdisc;
  String xdiscamt;
  String xdiscad;
  String xdiscadamt;
  String xrate;
  String xlineamt;
  String xpartno;
  String xmasteritem;
  String masterItemName;

  ProcessResponseModel({
    required this.xrow,
    required this.xitem,
    required this.xqtyreq,
    required this.itemName,
    required this.xdisc,
    required this.xdiscamt,
    required this.xdiscad,
    required this.xdiscadamt,
    required this.xrate,
    required this.xlineamt,
    required this.xpartno,
    required this.xmasteritem,
    required this.masterItemName,
  });

  factory ProcessResponseModel.fromJson(Map<String, dynamic> json) => ProcessResponseModel(
    xrow: json["xrow"],
    xitem: json["xitem"],
    xqtyreq: json["xqtyreq"],
    itemName: json["itemName"],
    xdisc: json["xdisc"],
    xdiscamt: json["xdiscamt"],
    xdiscad: json["xdiscad"],
    xdiscadamt: json["xdiscadamt"],
    xrate: json["xrate"],
    xlineamt: json["xlineamt"],
    xpartno: json["xpartno"],
    xmasteritem: json["xmasteritem"],
    masterItemName: json["masterItemName"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xitem": xitem,
    "xqtyreq": xqtyreq,
    "itemName": itemName,
    "xdisc": xdisc,
    "xdiscamt": xdiscamt,
    "xdiscad": xdiscad,
    "xdiscadamt": xdiscadamt,
    "xrate": xrate,
    "xlineamt": xlineamt,
    "xpartno": xpartno,
    "xmasteritem": xmasteritem,
    "masterItemName": masterItemName,
  };
}
