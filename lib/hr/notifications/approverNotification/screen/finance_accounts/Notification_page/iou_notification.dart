import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:gazi_sales_app/screen/FinanaceAccounts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../Notification_model/iou_admin_model.dart';
import '../Notification_model/supplier_payment_admin_model.dart';

class IOUNotificationScreen extends StatefulWidget {
  IOUNotificationScreen(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<IOUNotificationScreen> createState() => _IOUNotificationScreenState();
}

class _IOUNotificationScreenState extends State<IOUNotificationScreen> {
  Future<List<PendingIouModel>>? futurePost;
  dynamic rejectNote = " ";

  Future<List<PendingIouModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/accounts/iou/iou.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<PendingIouModel>((json) => PendingIouModel.fromJson(json))
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
                    builder: (context) => FinanceAccountNotificationList(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          xstaff: widget.xstaff,
                          zid: widget.zid,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Pending IOU Notification",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: Color(0xff074974),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<PendingIouModel>>(
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
                                            "${snapshot.data![index].xbillno}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data![index].preparerName ?? ""}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data![index].preparerXdeptname ?? ""}",
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
                                "Date: " + " ${snapshot.data![index].xdate}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Approval Status: " +
                                    "${snapshot.data![index].xstatusdesc}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Requested Amount: " +
                                    "${snapshot.data![index].xprime}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Approval Amount: " +
                                    "${snapshot.data![index].xamount}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Employee Name: " +
                                    "${snapshot.data![index].xstatusdesc}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Location Name: " +
                                    "${snapshot.data![index].regidesc}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Purpose: " +
                                    "${snapshot.data![index].xpurpose}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Justification: " +
                                    "${snapshot.data![index].xlong}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    onPressed: () async {
                                      var response = await http.post(
                                          Uri.parse(
                                              'http://${AppConstants.baseurl}/gazi/notification/accounts/iou/iou_approve.php'),
                                          body: jsonEncode(<String, String>{
                                            "zid": widget.zid,
                                            "user": widget.zemail,
                                            "xposition": widget.xposition,
                                            "xbillno": snapshot
                                                .data![index].xbillno
                                                .toString(),
                                            "xstatus": snapshot
                                                .data![index].xstatus
                                                .toString(),
                                          }));

                                      Get.snackbar('Message', 'Approved',
                                          backgroundColor: Color(0XFF8CA6DB),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP);

                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });

                                      print(response.statusCode);
                                      print(response.body);
                                    },
                                    child: Text(
                                      "Approve",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Reject Note"),
                                              content: Column(
                                                children: [
                                                  Container(
                                                    //height: MediaQuery.of(context).size.height/6,
                                                    child: TextFormField(
                                                      style:
                                                          GoogleFonts.bakbakOne(
                                                        //fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                      ),
                                                      onChanged: (input) {
                                                        rejectNote = input;
                                                      },
                                                      validator: (input) {
                                                        if (input!.isEmpty) {
                                                          return "Please Write Reject Note";
                                                        }
                                                      },
                                                      scrollPadding:
                                                          EdgeInsets.all(20),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        // add padding to adjust text
                                                        isDense: false,

                                                        hintStyle: GoogleFonts
                                                            .bakbakOne(
                                                          //fontWeight: FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                        ),
                                                        labelText:
                                                            "Reject Note",
                                                        labelStyle: GoogleFonts
                                                            .bakbakOne(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                        ),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xff064A76),
                                                  ),
                                                  //color: Color(0xff064A76),
                                                  onPressed: () async {
                                                    //http://172.20.20.69/adminapprove/poreject.php
                                                    if (rejectNote == " ") {
                                                      Navigator.pop(context);
                                                      print(
                                                          'response code: Empty field');
                                                      Get.snackbar('Warning!',
                                                          'Please enter reject note',
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .TOP);
                                                    } else {
                                                      var response =
                                                          await http.post(
                                                              Uri.parse(
                                                                  'http://${AppConstants.baseurl}/gazi/notification/accounts/iou/iou_reject.php'),
                                                              body: jsonEncode(<
                                                                  String,
                                                                  String>{
                                                                "zid":
                                                                    widget.zid,
                                                                "user": widget
                                                                    .zemail,
                                                                "xposition": widget
                                                                    .xposition,
                                                                "xbillno": snapshot
                                                                    .data![
                                                                        index]
                                                                    .xbillno
                                                                    .toString(),
                                                                "xnote":
                                                                    rejectNote
                                                              }));
                                                      print(
                                                          response.statusCode);
                                                      Navigator.pop(context);
                                                      Get.snackbar(
                                                        'Message',
                                                        'Rejected',
                                                        backgroundColor:
                                                            Color(0XFF8CA6DB),
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                      );

                                                      setState(() {
                                                        snapshot.data!
                                                            .removeAt(index);
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    "Reject",
                                                    style:
                                                        GoogleFonts.bakbakOne(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              scrollable: true,
                                            );
                                          });
                                    },
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
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
