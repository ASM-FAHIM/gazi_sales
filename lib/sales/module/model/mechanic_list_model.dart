// To parse this JSON data, do
//
//     final mechanicModel = mechanicModelFromJson(jsonString);

import 'dart:convert';

List<MechanicModel> mechanicModelFromJson(String str) => List<MechanicModel>.from(json.decode(str).map((x) => MechanicModel.fromJson(x)));

String mechanicModelToJson(List<MechanicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MechanicModel {
  MechanicModel({
    required this.xid,
    required this.xnamem,
    required this.xcus,
    required this.xname,
    required this.xmobile,
    required this.xadd,
    required this.xsalesperson,
    required this.xresphone,
    required this.xtso,
    required this.xarea,
    required this.xterritory,
    required this.xlocation,
  });

  String xid;
  String xnamem;
  String xcus;
  String xname;
  String xmobile;
  String xadd;
  String xsalesperson;
  String xresphone;
  String xtso;
  String xarea;
  String xterritory;
  String xlocation;

  factory MechanicModel.fromJson(Map<String, dynamic> json) => MechanicModel(
    xid: json["xid"],
    xnamem: json["xnamem"],
    xcus: json["xcus"],
    xname: json["xname"],
    xmobile: json["xmobile"],
    xadd: json["xadd"],
    xsalesperson: json["xsalesperson"],
    xresphone: json["xresphone"],
    xtso: json["xtso"],
    xarea: json["xarea"],
    xterritory: json["xterritory"],
    xlocation: json["xlocation"],
  );

  Map<String, dynamic> toJson() => {
    "xid": xid,
    "xnamem": xnamem,
    "xcus": xcus,
    "xname": xname,
    "xmobile": xmobile,
    "xadd": xadd,
    "xsalesperson": xsalesperson,
    "xresphone": xresphone,
    "xtso": xtso,
    "xarea": xarea,
    "xterritory": xterritory,
    "xlocation": xlocation,
  };
}
