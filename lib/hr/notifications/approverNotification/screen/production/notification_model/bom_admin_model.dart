import 'dart:convert';

List<BomNotificationModel> bomNotificationModelFromJson(String str) =>
    List<BomNotificationModel>.from(
        json.decode(str).map((x) => BomNotificationModel.fromJson(x)));

String bomNotificationModelToJson(List<BomNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BomNotificationModel {
  BomNotificationModel({
    required this.zid,
    required this.xidsup,
    required this.xsuperior2,
    required this.xbomkey,
    required this.xdesc,
    required this.xitem,
    required this.xitemdesc,
    required this.xdate,
    required this.xpreferbatchqty,
    required this.xstatus,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.reviewerName,
    required this.reviewerDesignation,
    required this.reviewerXdeptname,
    required this.approverName,
    required this.approverDesignation,
    required this.approverXdeptname,
  });

  int zid;
  String xidsup;
  String xsuperior2;
  String xbomkey;
  String xdesc;
  String xitem;
  String xitemdesc;
  String xdate;
  String xpreferbatchqty;
  String xstatus;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewerName;
  String reviewerDesignation;
  String reviewerXdeptname;
  String approverName;
  String approverDesignation;
  String approverXdeptname;

  factory BomNotificationModel.fromJson(Map<String, dynamic> json) =>
      BomNotificationModel(
        zid: json["zid"] ?? ' ',
        xidsup: json["xidsup"] ?? ' ',
        xsuperior2: json["xsuperior2"] ?? ' ',
        xbomkey: json["xbomkey"] ?? ' ',
        xdesc: json["xdesc"] ?? ' ',
        xitem: json["xitem"] ?? ' ',
        xitemdesc: json["xitemdesc"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xpreferbatchqty: json["xpreferbatchqty"] ?? ' ',
        xstatus: json["xstatus"] ?? ' ',
        preparerName: json["preparer_name"] ?? ' ',
        preparerXdesignation: json["preparer_xdesignation"] ?? ' ',
        preparerXdeptname: json["preparer_xdeptname"] ?? ' ',
        reviewerName: json["reviewer_name"] ?? ' ',
        reviewerDesignation: json["reviewer_designation"] ?? ' ',
        reviewerXdeptname: json["reviewer_xdeptname"] ?? ' ',
        approverName: json["Approver_name"] ?? ' ',
        approverDesignation: json["Approver_designation"] ?? ' ',
        approverXdeptname: json["Approver_xdeptname"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xidsup": xidsup,
        "xsuperior2": xsuperior2,
        "xbomkey": xbomkey,
        "xdesc": xdesc,
        "xitem": xitem,
        "xitemdesc": xitemdesc,
        "xdate": xdate,
        "xpreferbatchqty": xpreferbatchqty,
        "xstatus": xstatus,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "reviewer_name": reviewerName,
        "reviewer_designation": reviewerDesignation,
        "reviewer_xdeptname": reviewerXdeptname,
        "Approver_name": approverName,
        "Approver_designation": approverDesignation,
        "Approver_xdeptname": approverXdeptname,
      };
}
