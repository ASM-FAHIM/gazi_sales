import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../conts_api_link.dart';
import '../../../../../../screen/hr_approver_home.dart';
import '../notification_models/leave_emp_admin_model.dart';

class Admin_Leave_Tour_NotificationList extends StatefulWidget {
  Admin_Leave_Tour_NotificationList({
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
  _Admin_Leave_Tour_NotificationListState createState() =>
      _Admin_Leave_Tour_NotificationListState();
}

class _Admin_Leave_Tour_NotificationListState
    extends State<Admin_Leave_Tour_NotificationList> {
  @override
  Future<List<LeaveandTourempNotiModel>>? futurePost;
  final note = GlobalKey<FormState>();
  String rejectNote = " ";

  Future<List<LeaveandTourempNotiModel>> fetchPost() async {
    var response = await http.post(Uri.parse(ConstApiLink().leaveTourEpmApi),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<LeaveandTourempNotiModel>(
              (json) => LeaveandTourempNotiModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();

    // submitData();
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
            "Leave And Tour Approval",
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
        child: FutureBuilder<List<LeaveandTourempNotiModel>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  child: Column(
                    children: [
                      // Icon(Icons.notifications_active_outlined),
                      // SizedBox(
                      //   width: 100,
                      // ),

                      Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Text((DateFormat("dd-MM-yyyy").format(DateTime.parse((snapshot.data![index].intime.date).toString()))).toString(),
                                    //   style: GoogleFonts.bakbakOne(
                                    //     fontSize: 18,
                                    //     //color: Color(0xff074974),
                                    //   ),
                                    // ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: Text(
                                          " ${snapshot.data![index].xname}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.bakbakOne(
                                            fontSize: 18,
                                            //color: Color(0xff074974),
                                          )),
                                    ),
                                    Text(
                                      " ${snapshot.data![index].xtypeleave}",
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    //Text(" ${snapshot.data![index].status}")
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "From Date : " +
                                    (DateFormat("dd-MM-yyyy").format(
                                            DateTime.parse((snapshot
                                                    .data![index]
                                                    .xdatefrom
                                                    .date)
                                                .toString())))
                                        .toString(),
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              // Text("Day : "+(DateFormat("dd-MM-yyyy").format(DateTime.parse((snapshot.data![index].toDate.date).toString()))).toString(),
                              //   style: TextStyle(
                              //       fontSize: 15,
                              //       fontWeight: FontWeight.bold
                              //   ),
                              // ),
                              Text(
                                "To Time : " +
                                    (DateFormat("dd-MM-yyyy").format(
                                            DateTime.parse((snapshot
                                                    .data![index].xdateto.date)
                                                .toString())))
                                        .toString(),
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),

                              Text(
                                "Leave Type: " +
                                    "${snapshot.data![index].xtypeleave.toString()}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Applied Date : " +
                                    "${snapshot.data![index].xappday.toString()}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Approved Day : " +
                                    "${snapshot.data![index].xday.toString()}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Note : " +
                                    "${snapshot.data![index].xnote.toString()}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Status : " +
                                    "${snapshot.data![index].xstatus.toString()}",
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
                                    //color: Colors.green,
                                    onPressed: () async {
                                      //http://172.20.20.69/adminapprove/earlyapprove.php
                                      var response = await http.post(
                                          Uri.parse(ConstApiLink()
                                              .leaveTourEpmApproveApi),
                                          body: jsonEncode(<String, String>{
                                            "zid": "100000",
                                            "user": widget.xposition,
                                            "xposition": widget.xposition,
                                            "xstaff":
                                                snapshot.data![index].xstaff,
                                            "xyearperdate": snapshot
                                                .data![index].xyearperdate
                                                .toString(),
                                            "xnote": "kjdfg",
                                            "xtypeleave": snapshot
                                                .data![index].xtypeleave,
                                            "xdatefrom": snapshot
                                                .data![index].xdatefrom
                                                .toString(),
                                            "xdateto": snapshot
                                                .data![index].xdateto
                                                .toString(),
                                            "xstatus":
                                                snapshot.data![index].xstatus,
                                            "xday": snapshot.data![index].xday,
                                            "xyear": snapshot.data![index].xyear
                                                .toString()
                                          }));

                                      print(response.body);

                                      Get.snackbar('Message', 'Approved',
                                          backgroundColor: Color(0XFF8CA6DB),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP);

                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });

                                      //print("Approve"+snapshot.data![index].name.toString());
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
                                    //color: Colors.red,
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Reject Note"),
                                              content: Form(
                                                key: note,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      //height: MediaQuery.of(context).size.height/6,
                                                      child: TextFormField(
                                                        style: GoogleFonts
                                                            .bakbakOne(
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
                                                          labelStyle:
                                                              GoogleFonts
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
                                                              .leaveTourEpmRejectApi),
                                                          body: jsonEncode(<
                                                              String, String>{
                                                            "zid": "100000",
                                                            "user": widget
                                                                .xposition,
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

                                      //print("Reject"+snapshot.data![index].name.toString());
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
