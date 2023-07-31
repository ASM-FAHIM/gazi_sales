import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/hr_approver_home.dart';
import '../notification_models/clearance_admin_model.dart';
import '../notification_models/short_leave_model.dart';

class ClearanceListScreen extends StatefulWidget {
  //const ClearanceListScreen({Key? key}) : super(key: key);
  ClearanceListScreen({
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
  State<ClearanceListScreen> createState() => _ClearanceListScreenState();
}

class _ClearanceListScreenState extends State<ClearanceListScreen> {
  Future<List<ClearanceAdminModel>>? futurePost;

  String acceptNote = " ";
  String rejectNote = " ";

  Future<List<ClearanceAdminModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/hr/Short_Leave/SL.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ClearanceAdminModel>(
              (json) => ClearanceAdminModel.fromJson(json))
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
            "Clearance List Approval",
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
        child: FutureBuilder<List<ClearanceAdminModel>>(
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
                              top: 10, left: 6.0, right: 6.0, bottom: 6.0),
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " ${snapshot.data![index].xcase}",
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      " ${snapshot.data![index].xname}",
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      " ${snapshot.data![index].xname}",
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
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            childrenPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            children: <Widget>[
                              Text(
                                "Employee ID: " +
                                    "${snapshot.data![index].xstaff}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Approval Department: " +
                                    "${snapshot.data![index].xtype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Approver Name: " +
                                    "${snapshot.data![index].appxname}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Clearance Status: " +
                                    "${snapshot.data![index].xstatus}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Remarks: " + "${snapshot.data![index].xnote}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Designation: " +
                                    "${snapshot.data![index].xdesignation}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Department Name: " +
                                    "${snapshot.data![index].xdeptname}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Salary Unit: " +
                                    "${snapshot.data![index].xempcategory}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Type Of Employment: " +
                                    "${snapshot.data![index].xemptype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Gross Salary: " +
                                    "${snapshot.data![index].xempcategory}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Joining Date: " +
                                    "${snapshot.data![index].xdatejoin}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Date Of Release: " +
                                    "${snapshot.data![index].xenddate}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Reason For Exit: " +
                                    "${snapshot.data![index].xreason}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Advance Amount Against Expenses: " +
                                    "${snapshot.data![index].xadvamtexp}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Advance Amount Against Salary: " +
                                    "${snapshot.data![index].xadvamtsal}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Other Deduction: " +
                                    "${snapshot.data![index].xothers}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Total Deduction: " +
                                    "${snapshot.data![index].xdeduction}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Clearance Approval: " +
                                    "${snapshot.data![index].xstatus}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Preparer: " +
                                    "${snapshot.data![index].preparerName}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Preparer designation: " +
                                    "${snapshot.data![index].preparerDesignationname}",
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Accept Note"),
                                              content: Column(
                                                children: [
                                                  Container(
                                                    //height: MediaQuery.of(context).size.height/6,
                                                    child: TextFormField(
                                                      style:
                                                          GoogleFonts.bakbakOne(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black),
                                                      onChanged: (input) {
                                                        acceptNote = input;
                                                      },
                                                      validator: (input) {
                                                        if (input!.isEmpty) {
                                                          return "Please Write Accept Note";
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
                                                            "Accept Note",
                                                        labelStyle: GoogleFonts
                                                            .bakbakOne(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
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
                                                    if (acceptNote == " ") {
                                                      Navigator.pop(context);
                                                      Get.snackbar('Warning!',
                                                          'Please enter accept note',
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
                                                                  'http://${AppConstants.baseurl}/gazi/notification/hr/Short_Leave/SL_Approve.php'),
                                                              body: jsonEncode(<
                                                                  String,
                                                                  String>{
                                                                "zid": "100000",
                                                                "user": widget
                                                                    .zemail,
                                                                "xposition": widget
                                                                    .xposition,
                                                                "xyearperdate":
                                                                    'snapshot.data![index].xyearperdate.toString()',
                                                                "xstaff": snapshot
                                                                    .data![
                                                                        index]
                                                                    .xstaff,
                                                                "xstatus": snapshot
                                                                    .data![
                                                                        index]
                                                                    .xstatus,
                                                                "xnote":
                                                                    acceptNote
                                                              }));
                                                      print(
                                                          'Accept status: ${response.statusCode}');
                                                      Navigator.pop(context);
                                                      Get.snackbar(
                                                          'Message', 'Accepted',
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
                                                    "Accept",
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
                                      "Approve",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  /*SizedBox(
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
                                                    //http://172.20.20.69/gazi/
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
                                                                  'http://${AppConstants.baseurl}/gazi/notification/hr/Short_Leave/SL_Reject.php'),
                                                              body: jsonEncode(<
                                                                  String,
                                                                  String>{
                                                                "zid": "100000",
                                                                "user": widget
                                                                    .zemail,
                                                                "xposition": widget
                                                                    .xposition,
                                                                "xyearperdate": snapshot
                                                                    .data![
                                                                        index]
                                                                    .xyearperdate
                                                                    .toString(),
                                                                "xstaff": snapshot
                                                                    .data![
                                                                        index]
                                                                    .xstaff,
                                                                "xnote":
                                                                    rejectNote
                                                              }));
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
                                    },
                                    child: Text(
                                      "Reject",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),*/
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
