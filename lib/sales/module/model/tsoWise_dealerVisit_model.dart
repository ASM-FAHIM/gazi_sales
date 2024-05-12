// To parse this JSON data, do
//
//     final tsoWiseDealerVistListModel = tsoWiseDealerVistListModelFromJson(jsonString);

import 'dart:convert';

List<TsoWiseDealerVistListModel> tsoWiseDealerVistListModelFromJson(String str) => List<TsoWiseDealerVistListModel>.from(json.decode(str).map((x) => TsoWiseDealerVistListModel.fromJson(x)));

String tsoWiseDealerVistListModelToJson(List<TsoWiseDealerVistListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TsoWiseDealerVistListModel {
  TsoWiseDealerVistListModel({
    required this.xdate,
    required this.tsoid,
    required this.inTime,
    required this.dealer,
    required this.location,
  });

  String xdate;
  String tsoid;
  String inTime;
  String dealer;
  String location;

  factory TsoWiseDealerVistListModel.fromJson(Map<String, dynamic> json) => TsoWiseDealerVistListModel(
    xdate: json["xdate"],
    tsoid: json["TSOID"],
    inTime: json["InTime"],
    dealer: json["dealer"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "xdate": xdate,
    "TSOID": tsoid,
    "InTime": inTime,
    "dealer": dealer,
    "location": location,
  };
}
