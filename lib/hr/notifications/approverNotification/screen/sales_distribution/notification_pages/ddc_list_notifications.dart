import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/sales_distribution/notification_pages/details/ddc_notification_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/SandD.dart';
import '../notification_models/ddc_list_admin_model.dart';

class DDCListNotification extends StatefulWidget {
  DDCListNotification(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  final String xposition;
  final String xstaff;
  final String zemail;
  final String zid;

  @override
  State<DDCListNotification> createState() => _DDCListNotificationState();
}

class _DDCListNotificationState extends State<DDCListNotification> {
  Future<List<DdcListModel>>? futurePost;
  dynamic rejectNote = " ";

  Future<List<DdcListModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/Notification/sales/DDC/DDC.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<DdcListModel>((json) => DdcListModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
    fetchPost().whenComplete(() => futurePost);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SalesDistribution(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          zid: widget.zid,
                          xstaff: widget.xstaff,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "DDC List Notification",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: const Color(0xff074974),
            ),
          ),
        ),
        actions: const [
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<DdcListModel>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 6.0),
                          child: ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data![index].xdocnum}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data![index].preparerName}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data![index].preparerXdeptname}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "DDC No: " +
                                    " ${snapshot.data![index].xdocnum}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "DDC Date: " +
                                    " ${snapshot.data![index].xdate}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "From Store: " +
                                    "${snapshot.data![index].xfwh}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "From Store Name: " +
                                    '${snapshot.data![index].xfwhdesc}',
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "To Store: " + "${snapshot.data![index].xtwh}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "To Store Name: " +
                                    '${snapshot.data![index].xtwhdesc}',
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Short Excess Receive Status: " +
                                    "${snapshot.data![index].statustordesc}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DDCDetailsNotifications(
                                                xdocnum: snapshot
                                                    .data![index].xdocnum
                                                    .toString(),
                                                zid: widget.zid,
                                                xposition: widget.xposition,
                                                zemail: widget.zemail,
                                                xstatus: snapshot
                                                    .data![index].xstatus
                                                    .toString(),
                                                xstaff: widget.xstaff,
                                              )));
                                  if (result.toString() == "approval") {
                                    debugPrint("pressed");
                                    setState(() {
                                      snapshot.data!.removeAt(index);
                                    });
                                  }
                                },
                                child: Center(
                                    child: Text(
                                  "Details",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     TextButton(
                              //       style: TextButton.styleFrom(
                              //         backgroundColor: Colors.green,
                              //       ),
                              //       onPressed: () async {
                              //         var response = await http.post(
                              //             Uri.parse(
                              //                 'http://${AppConstants.baseurl}/gazi/notification/sales/DDC/DDC_Approve.php'),
                              //             body: jsonEncode(<String, String>{
                              //               "zid": widget.zid,
                              //               "user": widget.zemail,
                              //               "xposition": widget.xposition,
                              //               "xdocnum": snapshot
                              //                   .data![index].xdocnum
                              //                   .toString(),
                              //               "xstatus": snapshot
                              //                   .data![index].xstatus
                              //                   .toString(),
                              //             }));
                              //
                              //         Get.snackbar('Message', 'Approved',
                              //             backgroundColor:
                              //                 const Color(0XFF8CA6DB),
                              //             colorText: Colors.white,
                              //             snackPosition: SnackPosition.BOTTOM);
                              //
                              //         setState(() {
                              //           snapshot.data!.removeAt(index);
                              //         });
                              //
                              //         print(response.statusCode);
                              //         print(response.body);
                              //       },
                              //       child: const Text(
                              //         "Approve",
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 50,
                              //     ),
                              //     TextButton(
                              //       style: TextButton.styleFrom(
                              //         backgroundColor: Colors.red,
                              //       ),
                              //       onPressed: () {
                              //         showDialog(
                              //             context: context,
                              //             builder: (BuildContext context) {
                              //               return AlertDialog(
                              //                 title: const Text("Reject Note"),
                              //                 content: Column(
                              //                   children: [
                              //                     TextFormField(
                              //                       style:
                              //                           GoogleFonts.bakbakOne(
                              //                         //fontWeight: FontWeight.bold,
                              //                         fontSize: 18,
                              //                         color: Colors.black,
                              //                       ),
                              //                       onChanged: (input) {
                              //                         rejectNote = input;
                              //                       },
                              //                       validator: (input) {
                              //                         if (input!.isEmpty) {
                              //                           return "Please Write Reject Note";
                              //                         }
                              //                       },
                              //                       scrollPadding:
                              //                           const EdgeInsets.all(
                              //                               20),
                              //                       decoration: InputDecoration(
                              //                         contentPadding:
                              //                             const EdgeInsets.only(
                              //                                 left: 20),
                              //                         // add padding to adjust text
                              //                         isDense: false,
                              //
                              //                         hintStyle:
                              //                             GoogleFonts.bakbakOne(
                              //                           //fontWeight: FontWeight.bold,
                              //                           fontSize: 18,
                              //                           color: Colors.black,
                              //                         ),
                              //                         labelText: "Reject Note",
                              //                         labelStyle:
                              //                             GoogleFonts.bakbakOne(
                              //                           fontSize: 18,
                              //                           color: Colors.black,
                              //                         ),
                              //                         border:
                              //                             const OutlineInputBorder(),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 actions: [
                              //                   TextButton(
                              //                     style: TextButton.styleFrom(
                              //                       backgroundColor:
                              //                           const Color(0xff064A76),
                              //                     ),
                              //                     onPressed: () async {
                              //                       if (rejectNote == " ") {
                              //                         Navigator.pop(context);
                              //                         Get.snackbar('Warning!',
                              //                             'Please enter reject note',
                              //                             backgroundColor:
                              //                                 Colors.redAccent,
                              //                             colorText:
                              //                                 Colors.white,
                              //                             snackPosition:
                              //                                 SnackPosition
                              //                                     .TOP);
                              //                       } else {
                              //                         var response = await http.post(
                              //                             Uri.parse(
                              //                                 'http://${AppConstants.baseurl}/gazi/notification/sales/DDC/DDC_Reject.php'),
                              //                             body:
                              //                                 jsonEncode(<String,
                              //                                     String>{
                              //                               "zid": widget.zid,
                              //                               "user":
                              //                                   widget.zemail,
                              //                               "xposition": widget
                              //                                   .xposition,
                              //                               "xdocnum": snapshot
                              //                                   .data![index]
                              //                                   .xdocnum
                              //                                   .toString(),
                              //                               "xnote": rejectNote
                              //                             }));
                              //                         print(
                              //                             'successful: ${response.statusCode}');
                              //                         Get.snackbar(
                              //                           'Message',
                              //                           'Rejected',
                              //                           backgroundColor:
                              //                               Color(0XFF8CA6DB),
                              //                           colorText: Colors.white,
                              //                           snackPosition:
                              //                               SnackPosition.TOP,
                              //                         );
                              //                         Navigator.pop(context);
                              //                       }
                              //                       setState(() {
                              //                         snapshot.data!
                              //                             .removeAt(index);
                              //                       });
                              //                     },
                              //                     child: Text(
                              //                       "Reject",
                              //                       style:
                              //                           GoogleFonts.bakbakOne(
                              //                         color: Colors.white,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ],
                              //                 scrollable: true,
                              //               );
                              //             });
                              //       },
                              //       child: const Text(
                              //         "Reject",
                              //         style: TextStyle(color: Colors.white),
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Image(image: AssetImage("assets/images/loading.gif")),
              );
            }
          },
        ),
      ),
    );
  }
}
