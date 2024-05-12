import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../conts_api_link.dart';
import '../../../../../../screen/hr_approver_home.dart';
import '../notification_models/early_emp_admin_appr.dart';

class Admin_Early_Leave_NotificationList extends StatefulWidget {
  Admin_Early_Leave_NotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
  });

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  _Admin_Early_Leave_NotificationListState createState() =>
      _Admin_Early_Leave_NotificationListState();
}

class _Admin_Early_Leave_NotificationListState
    extends State<Admin_Early_Leave_NotificationList> {
  @override
  Future<List<AdminearlyNotiModel>>? futurePost;
  String rejectNote = " ";

  Future<List<AdminearlyNotiModel>> fetchPost() async {
    var response = await http.post(Uri.parse(ConstApiLink().earlyLeaveEpmApi),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<AdminearlyNotiModel>(
              (json) => AdminearlyNotiModel.fromJson(json))
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
                    builder: (context) => HrApproverHome(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          xstaff: widget.xstaff,
                          zid: widget.zid,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Early Employee Notification",
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
        child: FutureBuilder<List<AdminearlyNotiModel>>(
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
                          padding: EdgeInsets.only(
                              top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child:
                                          Text(" ${snapshot.data![index].name}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.bakbakOne(
                                                fontSize: 18,
                                                //color: Color(0xff074974),
                                              )),
                                    ),
                                    Text(
                                      "Date : " +
                                          (DateFormat("dd-MM-yyyy").format(
                                                  DateTime.parse((snapshot
                                                          .data![index]
                                                          .xtimein
                                                          .date)
                                                      .toString())))
                                              .toString(),
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  " Early\n Leave",
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 18,
                                    //color: Color(0xff074974),
                                  ),
                                )
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "Date : " +
                                    (DateFormat("dd-MM-yyyy").format(
                                            DateTime.parse((snapshot
                                                    .data![index].xtimein.date)
                                                .toString())))
                                        .toString(),
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "In Time : " +
                                    (DateFormat("hh:mm:ss a").format(
                                            DateTime.parse((snapshot
                                                    .data![index].xtimein.date)
                                                .toString())))
                                        .toString(),
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Out Time : " +
                                    (DateFormat("hh:mm:ss a").format(
                                            DateTime.parse((snapshot
                                                    .data![index]
                                                    .xtimeout1
                                                    .date)
                                                .toString())))
                                        .toString(),
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              // Text("OUT Time : "+"${snapshot.data![index].approvedDayS.toString()}",
                              //   style: TextStyle(
                              //       fontSize: 15,
                              //       fontWeight: FontWeight.bold
                              //   ),
                              // ),
                              Text(
                                "Working Hour : " +
                                    (DateFormat("HH:mm:ss").format(
                                            DateTime.parse((snapshot
                                                    .data![index]
                                                    .xworktime
                                                    .date)
                                                .toString())))
                                        .toString(),
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Note: " +
                                    "${snapshot.data![index].xnote ?? " "}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Status : " +
                                    "${snapshot.data![index].xstatusel.toString()}",
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
                                    // color: Colors.green,
                                    onPressed: () async {
                                      //http://172.20.20.69/adminapprove/earlyapprove.php
                                      var response = await http.post(
                                          Uri.parse(ConstApiLink()
                                              .earlyLeaveEpmApproveApi),
                                          body: jsonEncode(<String, String>{
                                            "zid": "100000",
                                            "user": widget.zemail,
                                            "xposition": widget.xposition,
                                            "xstaff":
                                                snapshot.data![index].xstaff,
                                            "xyearperdate": snapshot
                                                .data![index].xyearperdate
                                                .toString(),
                                            "xnote": rejectNote
                                          }));

                                      print(response.body);

                                      Get.snackbar('Message', 'Approved',
                                          backgroundColor: Color(0XFF8CA6DB),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP);

                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });

                                      print("Approve" +
                                          snapshot.data![index].name
                                              .toString());
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
                                    // color: Colors.red,
                                    onPressed: () async {
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
                                                  // color: Color(0xff064A76),
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
                                                      var response = await http.post(
                                                          Uri.parse(ConstApiLink()
                                                              .earlyLeaveEpmRejectApi),
                                                          body: jsonEncode(<
                                                              String, String>{
                                                            "zid": "100000",
                                                            "user":
                                                                widget.zemail,
                                                            "xposition": widget
                                                                .xposition,
                                                            "xstaff": snapshot
                                                                .data![index]
                                                                .xstaff,
                                                            "xyearperdate":
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .xyearperdate
                                                                    .toString(),
                                                            "xnote": rejectNote
                                                          }));

                                                      print(response.body);

                                                      Navigator.pop(context);

                                                      Get.snackbar(
                                                          'Message', 'Rejected',
                                                          backgroundColor:
                                                              Color(0XFF8CA6DB),
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .TOP);

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

                                      print("Reject" +
                                          snapshot.data![index].name
                                              .toString());
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
