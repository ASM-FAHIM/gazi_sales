// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    required this.zid,
    required this.xitem,
    required this.xdesc,
    required this.xrate,
    required this.xdealerp,
    required this.xmrp,
    required this.color,
    required this.xcapacity,
    required this.xunit,
    required this.xunitsel,
    required this.xcatitem,
    required this.xstype,
    required this.xpnature,
  });

  int? id;
  int zid;
  String xitem;
  String xdesc;
  String xrate;
  String xdealerp;
  String xmrp;
  String color;
  String xcapacity;
  String xunit;
  String xunitsel;
  String xcatitem;
  String xstype;
  String xpnature;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    zid: json["zid"],
    xitem: json["xitem"],
    xdesc: json["xdesc"],
    xrate: json["xrate"],
    xdealerp: json["xdealerp"],
    xmrp: json["xmrp"],
    color: json["color"],
    xcapacity: json["xcapacity"],
    xunit: json["xunit"],
    xunitsel: json["xunitsel"],
    xcatitem: json["xcatitem"],
    xstype: json["xstype"],
    xpnature: json["xpnature"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "zid": zid,
    "xitem": xitem,
    "xdesc": xdesc,
    "xrate": xrate,
    "xdealerp": xdealerp,
    "xmrp": xmrp,
    "color": color,
    "xcapacity": xcapacity,
    "xunit": xunit,
    "xunitsel": xunitsel,
    "xcatitem": xcatitem,
    "xstype": xstype,
    "xpnature": xpnature,
  };
}
