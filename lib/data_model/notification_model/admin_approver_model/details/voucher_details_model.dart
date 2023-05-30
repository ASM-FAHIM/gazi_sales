// To parse this JSON data, do
//
//     final voucherDetailsModel = voucherDetailsModelFromJson(jsonString);

import 'dart:convert';

List<VoucherDetailsModel> voucherDetailsModelFromJson(String str) =>
    List<VoucherDetailsModel>.from(
        json.decode(str).map((x) => VoucherDetailsModel.fromJson(x)));

String voucherDetailsModelToJson(List<VoucherDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VoucherDetailsModel {
  int xrow;
  String xacc;
  String xdesc;
  String xsub;
  String subdesc;
  String xdebit;
  String xcredit;

  VoucherDetailsModel({
    required this.xrow,
    required this.xacc,
    required this.xdesc,
    required this.xsub,
    required this.subdesc,
    required this.xdebit,
    required this.xcredit,
  });

  factory VoucherDetailsModel.fromJson(Map<String, dynamic> json) =>
      VoucherDetailsModel(
        xrow: json["xrow"],
        xacc: json["xacc"],
        xdesc: json["xdesc"],
        xsub: json["xsub"],
        subdesc: json["subdesc"],
        xdebit: json["xdebit"],
        xcredit: json["xcredit"],
      );

  Map<String, dynamic> toJson() => {
        "xrow": xrow,
        "xacc": xacc,
        "xdesc": xdesc,
        "xsub": xsub,
        "subdesc": subdesc,
        "xdebit": xdebit,
        "xcredit": xcredit,
      };
}
