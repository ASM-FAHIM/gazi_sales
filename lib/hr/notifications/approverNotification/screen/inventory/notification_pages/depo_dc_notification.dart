import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/inventory/notification_pages/details_page/depo_dc_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../sales/constant/app_constants.dart';
import '../../approver_notification.dart';
import '../notification_models/depo_dc_admin_model.dart';

class DepoDCNotification extends StatefulWidget {
  const DepoDCNotification({
    super.key,
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
  });

  final String xposition;
  final String xstaff;
  final String zemail;
  final String zid;

  @override
  State<DepoDCNotification> createState() => _DepoDCNotificationState();
}

class _DepoDCNotificationState extends State<DepoDCNotification> {
  Future<List<DepoDcModel>>? futurePost;
  String rejectNote = " ";

  Future<List<DepoDcModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/inventory/Depo_DC/DepoDC.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<DepoDcModel>((json) => DepoDcModel.fromJson(json))
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
                    builder: (context) => AdminNotificationList(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          zid: widget.zid,
                          xstaff: widget.xstaff,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Depo DC Notification",
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
        child: FutureBuilder<List<DepoDcModel>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 6.0),
                        child: ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
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
                              "Depo DC Number : " +
                                  " ${snapshot.data![index].xdocnum}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Depo DC Date : " +
                                  " ${snapshot.data![index].xdate}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "From Depot/Store : " +
                                  "${snapshot.data![index].xfwh}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            /*Text(
                              "LC No: " + snapshot.data![index].xlcno,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),*/
                            Text(
                              "From Depot/Store Name :" +
                                  "${snapshot.data![index].xfwhdesc}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "To Depot/Store : " +
                                  "${snapshot.data![index].xtwh}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "From Depot/Store Name :" +
                                  "${snapshot.data![index].xtwhdesc}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Transfer Chalan No : " +
                                  "${snapshot.data![index].xtornum}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Vehicle : " +
                                  "${snapshot.data![index].xvehicle}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Driver Name :" +
                                  "${snapshot.data![index].xdrivername}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Driver Phone :" +
                                  "${snapshot.data![index].xphone}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Approval Status: " +
                                  "${snapshot.data![index].status}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            Text(
                              "Depo DC Status: " +
                                  "${snapshot.data![index].statusdoc}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                //color: Color(0xff074974),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              //color: Colors.lightBlueAccent,
                              onPressed: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DepoDCDetailsNotification(
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
                                debugPrint(result.toString());
                                print(result);
                                if (result.toString() == "approval") {
                                  debugPrint("pressed");
                                  setState(() {
                                    snapshot.data!.removeAt(index);
                                  });
                                }
                              },
                              child: const Center(
                                  child: Text(
                                "Details",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     TextButton(
                            //       color: Colors.green,
                            //       onPressed: () async {
                            //         var response = await http.post(
                            //             Uri.parse(
                            //                 'http://172.20.20.69/aygaz/notifications/grnapprove.php'),
                            //             body: jsonEncode(<String, String>{
                            //               "zid": widget.zid,
                            //               "user": widget.zemail,
                            //               "xposition": widget.xposition,
                            //               "xgrnnum": snapshot
                            //                   .data![index].xgrnnum
                            //                   .toString(),
                            //               "ypd": "0",
                            //               " xstatusdoc": snapshot
                            //                   .data![index].xstatusdoc
                            //                   .toString(),
                            //               "aprcs": "GRN Approval"
                            //             }));
                            //
                            //         Get.snackbar('Message', 'Approved',
                            //             backgroundColor: Color(0XFF8CA6DB),
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
                            //       child: Text("Approve"),
                            //     ),
                            //     SizedBox(
                            //       width: 50,
                            //     ),
                            //     TextButton(
                            //       color: Colors.red,
                            //       onPressed: () {
                            //         showDialog(
                            //             context: context,
                            //             builder: (BuildContext context) {
                            //               return AlertDialog(
                            //                 title: const Text("Reject Note"),
                            //                 content: Column(
                            //                   children: [
                            //                     Container(
                            //                       //height: MediaQuery.of(context).size.height/6,
                            //                       child: TextField(
                            //                         style:
                            //                             GoogleFonts.bakbakOne(
                            //                           //fontWeight: FontWeight.bold,
                            //                           fontSize: 18,
                            //                           color: Colors.black,
                            //                         ),
                            //                         onChanged: (input) {
                            //                           rejectNote = input;
                            //                         },
                            //                         // validator: (input) {
                            //                         //   if (input!.isEmpty) {
                            //                         //     return "Please Write Reject Note";
                            //                         //   }
                            //                         // },
                            //                         scrollPadding:
                            //                             EdgeInsets.all(20),
                            //                         decoration:
                            //                             InputDecoration(
                            //                           contentPadding:
                            //                               EdgeInsets.only(
                            //                                   left:
                            //                                       20), // add padding to adjust text
                            //                           isDense: false,
                            //
                            //                           hintStyle: GoogleFonts
                            //                               .bakbakOne(
                            //                             //fontWeight: FontWeight.bold,
                            //                             fontSize: 18,
                            //                             color: Colors.black,
                            //                           ),
                            //                           labelText:
                            //                               "Reject Note",
                            //                           labelStyle: GoogleFonts
                            //                               .bakbakOne(
                            //                             fontSize: 18,
                            //                             color: Colors.black,
                            //                           ),
                            //                           border:
                            //                               OutlineInputBorder(),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 actions: [
                            //                   TextButton(
                            //                     color: Color(0xff064A76),
                            //                     onPressed: () async {
                            //                       //http://172.20.20.69/adminapprove/poreject.php
                            //
                            //                       var response = await http.post(
                            //                           Uri.parse(
                            //                               'http://172.20.20.69/aygaz/notifications/grnreject.php'),
                            //                           body: jsonEncode(<
                            //                               String, String>{
                            //                             "zid": widget.zid,
                            //                             "user": widget.zemail,
                            //                             "xposition":
                            //                                 widget.xposition,
                            //                             "xgrnnum": snapshot
                            //                                 .data![index]
                            //                                 .xgrnnum,
                            //                             "wh": "0",
                            //                             "xnote1": rejectNote
                            //                           }));
                            //                       print(response.statusCode);
                            //                       print(response.body);
                            //                       print(rejectNote);
                            //                       Navigator.pop(context);
                            //
                            //                       Get.snackbar(
                            //                           'Message', 'Rejected',
                            //                           backgroundColor:
                            //                               Color(0XFF8CA6DB),
                            //                           colorText: Colors.white,
                            //                           snackPosition:
                            //                               SnackPosition
                            //                                   .BOTTOM);
                            //
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
                            //       child: Text("Reject"),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
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
