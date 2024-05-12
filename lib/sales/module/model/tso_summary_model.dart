// To parse this JSON data, do
//
//     final tsoSummaryModel = tsoSummaryModelFromJson(jsonString);

import 'dart:convert';

TsoSummaryModel tsoSummaryModelFromJson(String str) => TsoSummaryModel.fromJson(json.decode(str));

String tsoSummaryModelToJson(TsoSummaryModel data) => json.encode(data.toJson());

class TsoSummaryModel {
  TsoSummaryModel({
    required this.mtarget,
    required this.dtarget,
    required this.mshopvisit,
    required this.mqty,
    required this.qtyAch
  });

  int mtarget;
  int dtarget;
  int mshopvisit;
  String mqty;
  String qtyAch;

  factory TsoSummaryModel.fromJson(Map<String, dynamic> json) => TsoSummaryModel(
    mtarget: json["mtarget"],
    dtarget: json["dtarget"],
    mshopvisit: json["mshopvisit"],
    mqty: json["mqty"],
    qtyAch: json["qtyAch"],
  );

  Map<String, dynamic> toJson() => {
    "mtarget": mtarget,
    "dtarget": dtarget,
    "mshopvisit": mshopvisit,
    "mqty": mqty,
    "qtyAch": qtyAch,
  };
}
