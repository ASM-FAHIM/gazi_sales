import 'dart:convert';

List<AttendenceReportModel> attendenceReportModelFromJson(String str) =>
    List<AttendenceReportModel>.from(
        json.decode(str).map((x) => AttendenceReportModel.fromJson(x)));

String attendenceReportModelToJson(List<AttendenceReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendenceReportModel {
  AttendenceReportModel({
    required this.zid,
    required this.zorg,
    required this.xmadd,
    required this.xdate,
    required this.xstaff,
    required this.xposition,
    required this.xname,
    required this.xintime,
    required this.xouttime,
    required this.xstatus,
    required this.xnote,
    required this.xdepartment,
    required this.xdesignation,
    required this.xconcern,
    required this.xdayname,
    required this.xemplate,
    required this.xstatuslate,
    required this.xempel,
    required this.xstatusel,
    required this.xworktime,
    required this.xsid,
    required this.xsname,
    required this.xshift,
    required this.xsec,
  });

  int zid;
  String zorg;
  String xmadd;
  Xdate xdate;
  String xstaff;
  String xposition;
  String xname;
  Xdate? xintime;
  Xdate? xouttime;
  String xstatus;
  dynamic xnote;
  String xdepartment;
  String xdesignation;
  String xconcern;
  String xdayname;
  dynamic xemplate;
  dynamic xstatuslate;
  dynamic xempel;
  dynamic xstatusel;
  Xdate? xworktime;
  String xsid;
  String xsname;
  String xshift;
  int xsec;

  factory AttendenceReportModel.fromJson(Map<String, dynamic> json) =>
      AttendenceReportModel(
        zid: json["zid"],
        zorg: json["zorg"],
        xmadd: json["xmadd"],
        xdate: Xdate.fromJson(json["xdate"]),
        xstaff: json["xstaff"],
        xposition: json["xposition"],
        xname: json["xname"],
        xintime: json["xintime"] == null ? null : Xdate.fromJson(json["xintime"]),
        xouttime: json["xouttime"] == null ? null : Xdate.fromJson(json["xouttime"]),
        xstatus: json["xstatus"],
        xnote: json["xnote"]?? " ",
        xdepartment: json["xdepartment"] ?? " ",
        xdesignation: json["xdesignation"]?? " ",
        xconcern: json["xconcern"]?? " ",
        xdayname: json["xdayname"]?? " ",
        xemplate: json["xemplate"]?? " ",
        xstatuslate: json["xstatuslate"]?? " ",
        xempel: json["xempel"]?? " ",
        xstatusel: json["xstatusel"]?? " ",
        xworktime: json["xouttime"] == null ? null : Xdate.fromJson(json["xouttime"]),
        xsid: json["xsid"]?? " ",
        xsname: json["xsname"]?? " ",
        xshift: json["xshift"]?? " ",
        xsec: json["xsec"]?? 0,
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "zorg": zorg,
        "xmadd": xmadd,
        "xdate": xdate.toJson(),
        "xstaff": xstaff,
        "xposition": xposition,
        "xname": xname,
        "xintime": xintime == null ? null : xintime,
        "xouttime": xouttime == null ? null : xouttime,
        "xstatus": xstatus,
        "xnote": xnote,
        "xdepartment": xdepartment,
        "xdesignation": xdesignation,
        "xconcern": xconcern,
        "xdayname": xdayname,
        "xemplate": xemplate,
        "xstatuslate": xstatuslate,
        "xempel": xempel,
        "xstatusel": xstatusel,
        "xworktime": xworktime == null ? null : xworktime,
        "xsid": xsid,
        "xsname": xsname,
        "xshift": xshift,
        "xsec": xsec,
      };
}

class Xdate {
  Xdate({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  DateTime date;
  int timezoneType;
  String timezone;

  factory Xdate.fromJson(Map<String, dynamic> json) => Xdate(
        date: DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}
//
// import 'dart:convert';
//
// List<AttendenceReportModel> attendenceReportModelFromJson(String str) =>
//     List<AttendenceReportModel>.from(
//         json.decode(str).map((x) => AttendenceReportModel.fromJson(x)));
//
// String attendenceReportModelToJson(List<AttendenceReportModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class AttendenceReportModel {
//   AttendenceReportModel({
//     required this.zid,
//     required this.zorg,
//     required this.xmadd,
//     required this.xdate,
//     required this.xstaff,
//     required this.xposition,
//     required this.xname,
//     required this.xintime,
//     required this.xouttime,
//     required this.xstatus,
//     required this.xnote,
//     required this.xdepartment,
//     required this.xdesignation,
//     required this.xconcern,
//     required this.xdayname,
//     required this.xemplate,
//     required this.xstatuslate,
//     required this.xempel,
//     required this.xstatusel,
//     required this.xworktime,
//     required this.xsid,
//     required this.xsname,
//     required this.xshift,
//   });
//
//   int zid;
//   String zorg;
//   String xmadd;
//   Xdate xdate;
//   String xstaff;
//   String xposition;
//   String xname;
//   Xdate? xintime;
//   Xdate? xouttime;
//   String xstatus;
//   dynamic xnote;
//   String xdepartment;
//   String xdesignation;
//   String xconcern;
//   String xdayname;
//   dynamic xemplate;
//   dynamic xstatuslate;
//   dynamic xempel;
//   dynamic xstatusel;
//   Xdate? xworktime;
//   String xsid;
//   String xsname;
//   String xshift;
//
//   factory AttendenceReportModel.fromJson(Map<String, dynamic> json) {
//     return AttendenceReportModel(
//       zid: json["zid"],
//       zorg: json["zorg"],
//       xmadd: json["xmadd"],
//       xdate: Xdate.fromJson(json["xdate"]),
//       xstaff: json["xstaff"],
//       xposition: json["xposition"],
//       xname: json["xname"],
//       xintime: json["xintime"] != null ? Xdate.fromJson(json["xintime"]) : null,
//       xouttime: json["xouttime"] != null ? Xdate.fromJson(json["xouttime"]) : null,
//       xstatus: json["xstatus"],
//       xnote: json["xnote"],
//       xdepartment: json["xdepartment"] ?? " ",
//       xdesignation: json["xdesignation"] ?? " ",
//       xconcern: json["xconcern"],
//       xdayname: json["xdayname"],
//       xemplate: json["xemplate"],
//       xstatuslate: json["xstatuslate"],
//       xempel: json["xempel"],
//       xstatusel: json["xstatusel"],
//       xworktime: json["xworktime"] != null ? Xdate.fromJson(json["xworktime"]) : null,
//       xsid: json["xsid"],
//       xsname: json["xsname"],
//       xshift: json["xshift"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "zid": zid,
//     "zorg": zorg,
//     "xmadd": xmadd,
//     "xdate": xdate.toJson(),
//     "xstaff": xstaff,
//     "xposition": xposition,
//     "xname": xname,
//     "xintime": xintime?.toJson(),
//     "xouttime": xouttime?.toJson(),
//     "xstatus": xstatus,
//     "xnote": xnote,
//     "xdepartment": xdepartment,
//     "xdesignation": xdesignation,
//     "xconcern": xconcern,
//     "xdayname": xdayname,
//     "xemplate": xemplate,
//     "xstatuslate": xstatuslate,
//     "xempel": xempel,
//     "xstatusel": xstatusel,
//     "xworktime": xworktime?.toJson(),
//     "xsid": xsid,
//     "xsname": xsname,
//     "xshift": xshift,
//   };
// }
//
// class Xdate {
//   Xdate({
//     required this.date,
//     required this.timezoneType,
//     required this.timezone,
//   });
//
//   DateTime date;
//   int timezoneType;
//   String timezone;
//
//   factory Xdate.fromJson(Map<String, dynamic> json) => Xdate(
//     date: DateTime.parse(json["date"]),
//     timezoneType: json["timezone_type"],
//     timezone: json["timezone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "date": date.toIso8601String(),
//     "timezone_type": timezoneType,
//     "timezone": timezone,
//   };
// }


