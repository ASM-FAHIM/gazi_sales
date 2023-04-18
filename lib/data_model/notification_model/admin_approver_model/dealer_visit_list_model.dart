// To parse this JSON data, do
//
//     final dealerVisitListModel = dealerVisitListModelFromJson(jsonString);

import 'dart:convert';

List<DealerVisitListModel> dealerVisitListModelFromJson(String str) => List<DealerVisitListModel>.from(json.decode(str).map((x) => DealerVisitListModel.fromJson(x)));

String dealerVisitListModelToJson(List<DealerVisitListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealerVisitListModel {
  DealerVisitListModel({
    required this.xdate,
    required this.tsoid,
    required this.inTime,
    required this.outTime,
    required this.dealer,
    required this.location,
    required this.image,
  });

  String xdate;
  String tsoid;
  String inTime;
  String outTime;
  String dealer;
  String location;
  String image;

  factory DealerVisitListModel.fromJson(Map<String, dynamic> json) => DealerVisitListModel(
    xdate: json["xdate"],
    tsoid: json["TSOID"],
    inTime: json["InTime"],
    outTime: json["OutTime"],
    dealer: json["dealer"],
    location: json["location"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "xdate": xdate,
    "TSOID": tsoid,
    "InTime": inTime,
    "OutTime": outTime,
    "dealer": dealer,
    "location": location,
    "image": image,
  };
}
