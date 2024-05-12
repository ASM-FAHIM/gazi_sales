// To parse this JSON data, do
//
//     final voucherDetailsModel = voucherDetailsModelFromJson(jsonString);

import 'dart:convert';

List<VoucherDetailsModel> voucherDetailsModelFromJson(String str) => List<VoucherDetailsModel>.from(json.decode(str).map((x) => VoucherDetailsModel.fromJson(x)));

String voucherDetailsModelToJson(List<VoucherDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VoucherDetailsModel {
  String? xrow;
  String? xvoucher;
  String? xacc;
  String? xdesc;
  String? xsub;
  String? subdesc;
  String? xdebit;
  String? xcredit;
  String? xlocation;
  String? xfleet;

  VoucherDetailsModel({
    this.xrow,
    this.xvoucher,
    this.xacc,
    this.xdesc,
    this.xsub,
    this.subdesc,
    this.xdebit,
    this.xcredit,
    this.xlocation,
    this.xfleet,
  });

  factory VoucherDetailsModel.fromJson(Map<String, dynamic> json) => VoucherDetailsModel(
    xrow: json["xrow"],
    xvoucher: json["xvoucher"],
    xacc: json["xacc"],
    xdesc: json["xdesc"],
    xsub: json["xsub"],
    subdesc: json["subdesc"],
    xdebit: json["xdebit"],
    xcredit: json["xcredit"],
    xlocation: json["xlocation"],
    xfleet: json["xfleet"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xvoucher": xvoucher,
    "xacc": xacc,
    "xdesc": xdesc,
    "xsub": xsub,
    "subdesc": subdesc,
    "xdebit": xdebit,
    "xcredit": xcredit,
    "xlocation": xlocation,
    "xfleet": xfleet,
  };
}
