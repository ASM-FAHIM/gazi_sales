// To parse this JSON data, do
//
//     final tsoInfoListModel = tsoInfoListModelFromJson(jsonString);

import 'dart:convert';

List<TsoInfoListModel> tsoInfoListModelFromJson(String str) => List<TsoInfoListModel>.from(json.decode(str).map((x) => TsoInfoListModel.fromJson(x)));

String tsoInfoListModelToJson(List<TsoInfoListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TsoInfoListModel {
  TsoInfoListModel({
    required this.zid,
    required this.xwh,
    required this.xsp,
    required this.xstaff,
    required this.xsm,
    required this.xrsm,
    required this.xname,
    required this.xphone,
    required this.xterritory,
    required this.mtarget,
    required this.dtarget,
    required this.mshopvisit,
    required this.qtyTarget,
    required this.qtyAch,
  });

  int zid;
  String xwh;
  String xsp;
  String xstaff;
  String xsm;
  String xrsm;
  String xname;
  String xphone;
  String xterritory;
  int mtarget;
  int dtarget;
  int mshopvisit;
  String qtyTarget;
  String qtyAch;

  factory TsoInfoListModel.fromJson(Map<String, dynamic> json) => TsoInfoListModel(
    zid: json["zid"],
    xwh: json["xwh"],
    xsp: json["xsp"],
    xstaff: json["xstaff"],
    xsm: json["xsm"],
    xrsm: json["xrsm"],
    xname: json["xname"],
    xphone: json["xphone"],
    xterritory: json["xterritory"],
    mtarget: json["mtarget"],
    dtarget: json["dtarget"],
    mshopvisit: json["mshopvisit"],
    qtyTarget: json["qtyTarget"],
    qtyAch: json["qtyAch"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xwh": xwh,
    "xsp": xsp,
    "xstaff": xstaff,
    "xsm": xsm,
    "xrsm": xrsm,
    "xname": xname,
    "xphone": xphone,
    "xterritory": xterritory,
    "mtarget": mtarget,
    "dtarget": dtarget,
    "mshopvisit": mshopvisit,
    "qtyTarget": qtyTarget,
    "qtyAch": qtyAch,
  };
}
