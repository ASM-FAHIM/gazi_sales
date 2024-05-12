// To parse this JSON data, do
//
//     final depositListModel = depositListModelFromJson(jsonString);

import 'dart:convert';

List<DepositListModel> depositListModelFromJson(String str) =>
    List<DepositListModel>.from(
        json.decode(str).map((x) => DepositListModel.fromJson(x)));

String depositListModelToJson(List<DepositListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepositListModel {
  String xdepositnum;
  String xcus;
  String xorg;
  String xamount;
  String xlineamt;
  String xbalance;

  DepositListModel({
    required this.xdepositnum,
    required this.xcus,
    required this.xorg,
    required this.xamount,
    required this.xlineamt,
    required this.xbalance,
  });

  factory DepositListModel.fromJson(Map<String, dynamic> json) =>
      DepositListModel(
        xdepositnum: json["xdepositnum"],
        xcus: json["xcus"],
        xorg: json["xorg"],
        xamount: json["xamount"],
        xlineamt: json["xlineamt"],
        xbalance: json["xbalance"],
      );

  Map<String, dynamic> toJson() => {
        "xdepositnum": xdepositnum,
        "xcus": xcus,
        "xorg": xorg,
        "xamount": xamount,
        "xlineamt": xlineamt,
        "xbalance": xbalance,
      };
}
