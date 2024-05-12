// // To parse this JSON data, do
// //
// //     final clearanceAdminModel = clearanceAdminModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<ClearanceAdminModel> clearanceAdminModelFromJson(String str) =>
//     List<ClearanceAdminModel>.from(
//         json.decode(str).map((x) => ClearanceAdminModel.fromJson(x)));
//
// String clearanceAdminModelToJson(List<ClearanceAdminModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ClearanceAdminModel {
//   String zid;
//   String xcase;
//   String xrow;
//   String xtype;
//   String xstatus;
//   String xsignatory1;
//   DateTime xsigndate1;
//   String xnote;
//   String xptype;
//   String xapprover;
//   String appxname;
//   String appdesignationname;
//   String appdepartmentname;
//   String xstaff;
//   String xname;
//   String xdesignation;
//   String xdeptname;
//   String xempcategory;
//   String xemptype;
//   String xgross;
//   String xdatejoin;
//   String xenddate;
//   String xreason;
//   String xadvamtexp;
//   String xadvamtsal;
//   String xothers;
//   String xdeduction;
//   String preparerName;
//   String preparerDesignationname;
//   String preparerDepartmentname;
//
//   ClearanceAdminModel({
//     required this.zid,
//     required this.xcase,
//     required this.xrow,
//     required this.xtype,
//     required this.xstatus,
//     required this.xsignatory1,
//     required this.xsigndate1,
//     required this.xnote,
//     required this.xptype,
//     required this.xapprover,
//     required this.appxname,
//     required this.appdesignationname,
//     required this.appdepartmentname,
//     required this.xstaff,
//     required this.xname,
//     required this.xdesignation,
//     required this.xdeptname,
//     required this.xempcategory,
//     required this.xemptype,
//     required this.xgross,
//     required this.xdatejoin,
//     required this.xenddate,
//     required this.xreason,
//     required this.xadvamtexp,
//     required this.xadvamtsal,
//     required this.xothers,
//     required this.xdeduction,
//     required this.preparerName,
//     required this.preparerDesignationname,
//     required this.preparerDepartmentname,
//   });
//
//   factory ClearanceAdminModel.fromJson(Map<String, dynamic> json) =>
//       ClearanceAdminModel(
//         zid: json["zid"],
//         xcase: json["xcase"],
//         xrow: json["xrow"],
//         xtype: json["xtype"],
//         xstatus: json["xstatus"],
//         xsignatory1: json["xsignatory1"],
//         xsigndate1: DateTime.parse(json["xsigndate1"]),
//         xnote: json["xnote"],
//         xptype: json["xptype"],
//         xapprover: json["xapprover"],
//         appxname: json["Appxname"],
//         appdesignationname: json["Appdesignationname"],
//         appdepartmentname: json["Appdepartmentname"],
//         xstaff: json["xstaff"],
//         xname: json["xname"],
//         xdesignation: json["xdesignation"],
//         xdeptname: json["xdeptname"],
//         xempcategory: json["xempcategory"],
//         xemptype: json["xemptype"],
//         xgross: json["xgross"],
//         xdatejoin: json["xdatejoin"],
//         xenddate: json["xenddate"],
//         xreason: json["xreason"],
//         xadvamtexp: json["xadvamtexp"],
//         xadvamtsal: json["xadvamtsal"],
//         xothers: json["xothers"],
//         xdeduction: json["xdeduction"],
//         preparerName: json["preparer_name"],
//         preparerDesignationname: json["preparer_designationname"],
//         preparerDepartmentname: json["preparer_departmentname"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "zid": zid,
//         "xcase": xcase,
//         "xrow": xrow,
//         "xtype": xtype,
//         "xstatus": xstatus,
//         "xsignatory1": xsignatory1,
//         "xsigndate1": xsigndate1.toIso8601String(),
//         "xnote": xnote,
//         "xptype": xptype,
//         "xapprover": xapprover,
//         "Appxname": appxname,
//         "Appdesignationname": appdesignationname,
//         "Appdepartmentname": appdepartmentname,
//         "xstaff": xstaff,
//         "xname": xname,
//         "xdesignation": xdesignation,
//         "xdeptname": xdeptname,
//         "xempcategory": xempcategory,
//         "xemptype": xemptype,
//         "xgross": xgross,
//         "xdatejoin": xdatejoin,
//         "xenddate": xenddate,
//         "xreason": xreason,
//         "xadvamtexp": xadvamtexp,
//         "xadvamtsal": xadvamtsal,
//         "xothers": xothers,
//         "xdeduction": xdeduction,
//         "preparer_name": preparerName,
//         "preparer_designationname": preparerDesignationname,
//         "preparer_departmentname": preparerDepartmentname,
//       };
// }


// To parse this JSON data, do
//
//     final clearanceAdminModel = clearanceAdminModelFromJson(jsonString);

import 'dart:convert';

List<ClearanceAdminModel> clearanceAdminModelFromJson(String str) => List<ClearanceAdminModel>.from(json.decode(str).map((x) => ClearanceAdminModel.fromJson(x)));

String clearanceAdminModelToJson(List<ClearanceAdminModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClearanceAdminModel {
  String zid;
  String xcase;
  String xrow;
  String xtype;
  String xstatus;
  String xsignatory1;
  String xsigndate1;
  String xnote;
  String xptype;
  String xapprover;
  String appxname;
  String appdesignationname;
  String appdepartmentname;
  String xstaff;
  String xname;
  String xdesignation;
  String xdeptname;
  String xempcategory;
  String xemptype;
  String xgross;
  String xdatejoin;
  String xenddate;
  String xreason;
  String xadvamtexp;
  String xadvamtsal;
  String xothers;
  String xdeduction;
  String preparerName;
  String preparerDesignationname;
  String preparerDepartmentname;

  ClearanceAdminModel({
    required this.zid,
    required this.xcase,
    required this.xrow,
    required this.xtype,
    required this.xstatus,
    required this.xsignatory1,
    required this.xsigndate1,
    required this.xnote,
    required this.xptype,
    required this.xapprover,
    required this.appxname,
    required this.appdesignationname,
    required this.appdepartmentname,
    required this.xstaff,
    required this.xname,
    required this.xdesignation,
    required this.xdeptname,
    required this.xempcategory,
    required this.xemptype,
    required this.xgross,
    required this.xdatejoin,
    required this.xenddate,
    required this.xreason,
    required this.xadvamtexp,
    required this.xadvamtsal,
    required this.xothers,
    required this.xdeduction,
    required this.preparerName,
    required this.preparerDesignationname,
    required this.preparerDepartmentname,
  });

  factory ClearanceAdminModel.fromJson(Map<String, dynamic> json) => ClearanceAdminModel(
    zid: json["zid"],
    xcase: json["xcase"],
    xrow: json["xrow"],
    xtype: json["xtype"],
    xstatus: json["xstatus"],
    xsignatory1: json["xsignatory1"],
    xsigndate1: json["xsigndate1"],
    xnote: json["xnote"],
    xptype: json["xptype"],
    xapprover: json["xapprover"],
    appxname: json["Appxname"],
    appdesignationname: json["Appdesignationname"],
    appdepartmentname: json["Appdepartmentname"],
    xstaff: json["xstaff"],
    xname: json["xname"],
    xdesignation: json["xdesignation"],
    xdeptname: json["xdeptname"],
    xempcategory: json["xempcategory"],
    xemptype: json["xemptype"],
    xgross: json["xgross"],
    xdatejoin: json["xdatejoin"],
    xenddate: json["xenddate"],
    xreason: json["xreason"],
    xadvamtexp: json["xadvamtexp"],
    xadvamtsal: json["xadvamtsal"],
    xothers: json["xothers"],
    xdeduction: json["xdeduction"],
    preparerName: json["preparer_name"],
    preparerDesignationname: json["preparer_designationname"],
    preparerDepartmentname: json["preparer_departmentname"],
  );

  Map<String, dynamic> toJson() => {
    "zid": zid,
    "xcase": xcase,
    "xrow": xrow,
    "xtype": xtype,
    "xstatus": xstatus,
    "xsignatory1": xsignatory1,
    "xsigndate1": xsigndate1,
    "xnote": xnote,
    "xptype": xptype,
    "xapprover": xapprover,
    "Appxname": appxname,
    "Appdesignationname": appdesignationname,
    "Appdepartmentname": appdepartmentname,
    "xstaff": xstaff,
    "xname": xname,
    "xdesignation": xdesignation,
    "xdeptname": xdeptname,
    "xempcategory": xempcategory,
    "xemptype": xemptype,
    "xgross": xgross,
    "xdatejoin": xdatejoin,
    "xenddate": xenddate,
    "xreason": xreason,
    "xadvamtexp": xadvamtexp,
    "xadvamtsal": xadvamtsal,
    "xothers": xothers,
    "xdeduction": xdeduction,
    "preparer_name": preparerName,
    "preparer_designationname": preparerDesignationname,
    "preparer_departmentname": preparerDepartmentname,
  };
}
