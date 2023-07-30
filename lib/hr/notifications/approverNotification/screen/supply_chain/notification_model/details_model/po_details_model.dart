// To parse this JSON data, do
//
//     final pOdetailsModel = pOdetailsModelFromJson(jsonString);

import 'dart:convert';

List<POdetailsModel> pOdetailsModelFromJson(String str) =>
    List<POdetailsModel>.from(
        json.decode(str).map((x) => POdetailsModel.fromJson(x)));

String pOdetailsModelToJson(List<POdetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class POdetailsModel {
  String xrow;
  String xitem;
  String xdesc;
  String xspecification;
  String xqtypur;
  String xunitpur;
  String xrate;
  String xlineamt;
  String povalue;
  String xrategrn;

  POdetailsModel({
    required this.xrow,
    required this.xitem,
    required this.xdesc,
    required this.xspecification,
    required this.xqtypur,
    required this.xunitpur,
    required this.xrate,
    required this.xlineamt,
    required this.povalue,
    required this.xrategrn,
  });

  factory POdetailsModel.fromJson(Map<String, dynamic> json) => POdetailsModel(
        xrow: json["xrow"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        xspecification: json["xspecification"],
        xqtypur: json["xqtypur"],
        xunitpur: json["xunitpur"],
        xrate: json["xrate"],
        xlineamt: json["xlineamt"],
        povalue: json["povalue"],
        xrategrn: json["xrategrn"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xitem": xitem,
        "xdesc": xdesc,
        "xspecification": xspecification,
        "xqtypur": xqtypur,
        "xunitpur": xunitpur,
        "xrate": xrate,
        "xlineamt": xlineamt,
        "povalue": povalue,
        "xrategrn": xrategrn,
      };
}
