// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hrandsells/hr/notifications/approverNotification/screen/inventory/notification_pages/details_page/asti_details.dart';
// import 'package:hrandsells/hr/notifications/approverNotification/screen/inventory/notification_pages/details_page/rr_details.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// import '../../../../../../api.dart';
// import '../../purchase/notification_model/pr_cs_admin_model.dart';
// import '../notification_models/asti_admin_model.dart';
// import '../notification_models/grn_admin_model.dart';
// import '../notification_models/rr_admin_model.dart';
// import 'details_page/grn_details.dart';
//
// class ASTI_Notification extends StatefulWidget {
//   //const CS_notification({Key? key}) : super(key: key);
//   ASTI_Notification(
//       {required this.xposition,
//       required this.xstaff,
//       required this.zemail,
//       required this.zid});
//
//   String xposition;
//   String xstaff;
//   String zemail;
//   String zid;
//
//   @override
//   State<ASTI_Notification> createState() => _ASTI_NotificationState();
// }
//
// class _ASTI_NotificationState extends State<ASTI_Notification> {
//   Future<List<AstiNotificationModel>>? futurePost;
//   String rejectNote = " ";
//   String api = API_Names().api;
//
//   Future<List<AstiNotificationModel>> fetchPost() async {
//     var response =
//         await http.post(Uri.parse('http://$api/ughcm/UG/ASTI_notification.php'),
//             body: jsonEncode(<String, String>{
//               "zid": widget.zid,
//               "xposition": widget.xposition,
//             }));
//
//     // print(response.body);
//
//     if (response.statusCode == 200) {
//       final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//
//       return parsed
//           .map<AstiNotificationModel>(
//               (json) => AstiNotificationModel.fromJson(json))
//           .toList();
//     } else {
//       throw Exception('Failed to load album');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // submitData();
//     futurePost = fetchPost();
//
//     fetchPost().whenComplete(() => futurePost);
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           color: Color(0xff064A76),
//           onPressed: () {
//             Navigator.pop(context);
//                 Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                 builder: (context) =>
//                 AdminNotificationList(
//                 xposition: widget.xposition,
//                 zemail: widget.zemail,
//                 zid: widget.zid,
//                 xstaff: widget.xstaff,
//                 )));
//           },
//         ),
//         title: Center(
//           child: Text(
//             "ASTI Notification",
//             style: GoogleFonts.bakbakOne(
//               fontSize: 20,
//               color: Color(0xff074974),
//             ),
//           ),
//         ),
//         actions: [
//           SizedBox(
//             width: 20,
//           )
//         ],
//         backgroundColor: Colors.white,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: FutureBuilder<List<AstiNotificationModel>>(
//           future: futurePost,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (_, index) => Container(
//                   child: Column(
//                     children: [
//                       Card(
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 10, bottom: 6.0),
//                           child: ExpansionTile(
//                             expandedCrossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             title: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width /
//                                           1.6,
//                                       child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "${snapshot.data![index].xtornum}",
//                                             style: GoogleFonts.bakbakOne(
//                                               fontSize: 18,
//                                               //color: Color(0xff074974),
//                                             ),
//                                           ),
//                                           Text(
//                                             "${snapshot.data![index].preparerName}",
//                                             style: GoogleFonts.bakbakOne(
//                                               fontSize: 18,
//                                               //color: Color(0xff074974),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             children: <Widget>[
//                               Text(
//                                 "Asset Issue No : " +
//                                     " ${snapshot.data![index].xtornum}",
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               Text(
//                                 "Requisition Date : " +
//                                     " ${snapshot.data![index].xdate}",
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               Text(
//                                 "Requisition By Date : " +
//                                     " ${snapshot.data![index].xdatereq}",
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               Text(
//                                 "From Store Name : " +
//                                     "${snapshot.data![index].xfbrname}",
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               /*Text(
//                                 "Project : " +
//                                     "${snapshot.data![index].xproject}",
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               Text(
//                                 "Project Description : " +
//                                     "${snapshot.data![index].xprojectdesc}",
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),*/
//                               Text(
//                                 "Department Name :" +
//                                     "${snapshot.data![index].xregi}",
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               /*Text(
//                                 "Shift Name :" +
//                                     "${snapshot.data![index].xshift}",
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),*/
//                               Text(
//                                 "Justification:" +
//                                     "${snapshot.data![index].xlong}",
//                                 style: GoogleFonts.bakbakOne(
//                                   fontSize: 18,
//                                   //color: Color(0xff074974),
//                                 ),
//                               ),
//                               TextButton(
//                                 style: TextButton.styleFrom(
//                                     backgroundColor:  Colors.lightBlueAccent
//                                 ),
//                                 onPressed: () async {
//                                   final result = await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               ASTI_details_notification(
//                                                 xtornum: snapshot
//                                                     .data![index].xtornum,
//                                                 zid: widget.zid,
//                                                 xposition: widget.xposition,
//                                                 zemail: widget.zemail,
//                                                 xstatustor: snapshot
//                                                     .data![index].xstatustor,
//                                                 xstaff: widget.xstaff,
//                                               )));
//                                   debugPrint(result.toString());
//                                   print(result);
//                                   if (result.toString() == "approval") {
//                                     debugPrint("pressed");
//                                     setState(() {
//                                       snapshot.data!.removeAt(index);
//                                     });
//                                   }
//                                 },
//                                 child: Center(child: Text("Details")),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return Center(
//                 child: Image(image: AssetImage("images/loading.gif")),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
