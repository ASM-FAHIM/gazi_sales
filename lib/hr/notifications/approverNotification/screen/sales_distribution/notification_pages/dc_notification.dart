import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/SandD.dart';
import '../notification_models/dc_admin_model.dart';
import 'details/dc_notification_details.dart';

class DC_Notification extends StatefulWidget {
  DC_Notification(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<DC_Notification> createState() => _DC_NotificationState();
}

class _DC_NotificationState extends State<DC_Notification> {
  Future<List<DcAdminModel>>? futurePost;
  dynamic rejectNote = " ";

  Future<List<DcAdminModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<DcAdminModel>((json) => DcAdminModel.fromJson(json))
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
          icon: Icon(Icons.arrow_back),
          color: Color(0xff064A76),
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
            "Delivery Chalan Notification",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: Color(0xff074974),
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<DcAdminModel>>(
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
                          padding: EdgeInsets.only(left: 10, bottom: 6.0),
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
                                            "${snapshot.data![index].xdornum}",
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "Delivery Chalan: " +
                                    " ${snapshot.data![index].xdornum}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "DC Date: " + " ${snapshot.data![index].xdate}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Customer ID: " +
                                    "${snapshot.data![index].xcus}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Customer Name: " +
                                    "${snapshot.data![index].xorg}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Depo/Store: " + "${snapshot.data![index].xwh}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Depo/Store Name: " +
                                    snapshot.data![index].xwhdesc,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "DC Type: " +
                                    "${snapshot.data![index].xpaymenttype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Incentive Applicable: " +
                                    "${snapshot.data![index].xopincapply}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "SO Number: " +
                                    "${snapshot.data![index].xsonumber}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Executive Channel: " +
                                    "${snapshot.data![index].executive}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              // Text(
                              //   "Location: " +
                              //       "${snapshot.data![index]}",
                              //   style: GoogleFonts.bakbakOne(
                              //     fontSize: 18,
                              //     //color: Color(0xff074974),
                              //   ),
                              // ),
                              //ASM Name
                              Text(
                                "ZM: " + "\n ${snapshot.data![index].zm}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "DSM: " + "${snapshot.data![index].dsm}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Location: " + "${snapshot.data![index].zone}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Division: " +
                                    "${snapshot.data![index].division}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Exp Adjustment Amt: " +
                                    "${snapshot.data![index].xexpamt}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Discount Type: " +
                                    "${snapshot.data![index].xdisctype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Voucher Number: " +
                                    "${snapshot.data![index].xvoucher}",
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
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DC_Details_Notification(
                                                xdornum: snapshot
                                                    .data![index].xdornum,
                                                xdocnum: snapshot
                                                    .data![index].xdornum,
                                                zid: widget.zid,
                                                xposition: widget.xposition,
                                                zemail: widget.zemail,
                                                xstatus: snapshot
                                                    .data![index].xstatus,
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
                              //       color: Colors.green,
                              //       onPressed: () async {
                              //         var response = await http.post(
                              //             Uri.parse(
                              //                 'http://172.20.20.69/aygaz/notifications/pendingInvoiceApprove.php'),
                              //             body: jsonEncode(<String, String>{
                              //               "zid": widget.zid,
                              //               "user": widget.zemail,
                              //               "xposition": widget.xposition,
                              //               "xdornum": snapshot
                              //                   .data![index].xdornum
                              //                   .toString(),
                              //               "ypd": "0",
                              //               " xstatus": snapshot
                              //                   .data![index].xstatus
                              //                   .toString(),
                              //               "aprcs": "DO Approval"
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
                              //                       child: TextFormField(
                              //                         style:
                              //                             GoogleFonts.bakbakOne(
                              //                           //fontWeight: FontWeight.bold,
                              //                           fontSize: 18,
                              //                           color: Colors.black,
                              //                         ),
                              //                         onChanged: (input) {
                              //                           rejectNote = input;
                              //                         },
                              //                         validator: (input) {
                              //                           if (input!.isEmpty) {
                              //                             return "Please Write Reject Note";
                              //                           }
                              //                         },
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
                              //                               'http://172.20.20.69/aygaz/notifications/pendingInvoiceReject.php'),
                              //                           body: jsonEncode(<
                              //                               String, String>{
                              //                             "zid": widget.zid,
                              //                             "user": widget.zemail,
                              //                             "xposition":
                              //                                 widget.xposition,
                              //                             "wh": "0",
                              //                             "xdornum": snapshot
                              //                                 .data![index]
                              //                                 .xdornum,
                              //                             "xnote1": rejectNote
                              //                           }));
                              //                       print(response.statusCode);
                              //                       print(response.body);
                              //                       Navigator.pop(context);
                              //                       debugPrint(
                              //                           rejectNote.toString());
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
                ),
              );
            } else {
              return Center(
                child: Image(image: AssetImage("assets/images/loading.gif")),
              );
            }
          },
        ),
      ),
    );
  }
}
