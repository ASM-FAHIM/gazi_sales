// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    required this.xitem,
    required this.xdesc,
    required this.xrate,
    required this.xdealerp,
    required this.xvatrate,
    required this.xvatamt,
    required this.xminrate,
    required this.totrate,
    required this.dealrate,
    required this.xgitem,
    required this.xpackqty,
    required this.xunitsel,
    required this.xdisc,
    required this.xdiscstatus,
    required this.xunitiss,
    required this.xpsize,
    required this.xtheircode,
    required this.xsubcat,
  });

  int? id;
  String xitem;
  String xdesc;
  String xrate;
  String xdealerp;
  String xvatrate;
  String xvatamt;
  String xminrate;
  int totrate;
  int dealrate;
  String xgitem;
  String xpackqty;
  String xunitsel;
  String xdisc;
  String xdiscstatus;
  String xunitiss;
  String xpsize;
  String xtheircode;
  String xsubcat;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    xitem: json["xitem"],
    xdesc: json["xdesc"],
    xrate: json["xrate"],
    xdealerp: json["xdealerp"],
    xvatrate: json["xvatrate"],
    xvatamt: json["xvatamt"],
    xminrate: json["xminrate"],
    totrate: json["totrate"],
    dealrate: json["dealrate"],
    xgitem: json["xgitem"],
    xpackqty: json["xpackqty"],
    xunitsel: json["xunitsel"],
    xdisc: json["xdisc"],
    xdiscstatus: json["xdiscstatus"],
    xunitiss: json["xunitiss"],
    xpsize: json["xpsize"],
    xtheircode: json["xtheircode"],
    xsubcat: json["xsubcat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "xitem": xitem,
    "xdesc": xdesc,
    "xrate": xrate,
    "xdealerp": xdealerp,
    "xvatrate": xvatrate,
    "xvatamt": xvatamt,
    "xminrate": xminrate,
    "totrate": totrate,
    "dealrate": dealrate,
    "xgitem": xgitem,
    "xpackqty": xpackqty,
    "xunitsel": xunitsel,
    "xdisc": xdisc,
    "xdiscstatus": xdiscstatus,
    "xunitiss": xunitiss,
    "xpsize": xpsize,
    "xtheircode": xtheircode,
    "xsubcat": xsubcat,
  };
}
