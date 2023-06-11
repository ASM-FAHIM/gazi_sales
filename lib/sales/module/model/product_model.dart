// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int? id;
  int zid;
  String xitem;
  String xdesc;
  String mainRate;
  String xrate;
  String xdealerp;
  String xmrp;
  String xcolor;
  String color;
  String xdisc;
  String xcapacity;
  String xunit;
  String xunitsel;
  String xcatitem;
  String xstype;
  String stype;
  String xpnature;
  String xdateeff;
  String xdateexp;

  ProductModel({
    this.id,
    required this.zid,
    required this.xitem,
    required this.xdesc,
    required this.mainRate,
    required this.xrate,
    required this.xdealerp,
    required this.xmrp,
    required this.xcolor,
    required this.color,
    required this.xdisc,
    required this.xcapacity,
    required this.xunit,
    required this.xunitsel,
    required this.xcatitem,
    required this.xstype,
    required this.stype,
    required this.xpnature,
    required this.xdateeff,
    required this.xdateexp,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        zid: json["zid"],
        xitem: json["xitem"],
        xdesc: json["xdesc"],
        mainRate: json["mainRate"],
        xrate: json["xrate"],
        xdealerp: json["xdealerp"],
        xmrp: json["xmrp"],
        xcolor: json["xcolor"],
        color: json["color"],
        xdisc: json["xdisc"],
        xcapacity: json["xcapacity"],
        xunit: json["xunit"],
        xunitsel: json["xunitsel"],
        xcatitem: json["xcatitem"],
        xstype: json["xstype"],
        stype: json["stype"],
        xpnature: json["xpnature"],
        xdateeff: json["xdateeff"],
        xdateexp: json["xdateexp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xitem": xitem,
        "xdesc": xdesc,
        "mainRate": mainRate,
        "xrate": xrate,
        "xdealerp": xdealerp,
        "xmrp": xmrp,
        "xcolor": xcolor,
        "color": color,
        "xdisc": xdisc,
        "xcapacity": xcapacity,
        "xunit": xunit,
        "xunitsel": xunitsel,
        "xcatitem": xcatitem,
        "xstype": xstype,
        "stype": stype,
        "xpnature": xpnature,
        "xdateeff": xdateeff,
        "xdateexp": xdateexp,
      };
}
