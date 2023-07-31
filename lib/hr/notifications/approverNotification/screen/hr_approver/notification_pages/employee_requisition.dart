import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../conts_api_link.dart';
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/hr_approver_home.dart';
import '../notification_models/emp_req_admin_model.dart';

class EmpReqScreen extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  EmpReqScreen(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  _EmpReqScreenState createState() => _EmpReqScreenState();
}

class _EmpReqScreenState extends State<EmpReqScreen> {
  // fetchnotification _noteList = fetchnotification();
  //fetchnotification _noteList = fetchnotification();

  @override
  Future<List<EmpReqAdminModel>>? futurePost;

  String rejectNote = " ";

  Future<List<EmpReqAdminModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/hr/Emp_Req/empReq.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "zemail": widget.zemail,
        }));

    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<EmpReqAdminModel>((json) => EmpReqAdminModel.fromJson(json))
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
            "Employee Requisition List",
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
        child: FutureBuilder<List<EmpReqAdminModel>>(
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
                                    Text(" ${snapshot.data![index].xpdreqnum}",
                                        style: GoogleFonts.bakbakOne(
                                          fontSize: 18,
                                          //color: Color(0xff074974),
                                        )),

                                    Text(
                                      " ${snapshot.data![index].xstatusreqdesc}",
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
                                "Date : " + "${snapshot.data![index].xdate}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Position Name: " +
                                    "${snapshot.data![index].xpositiondesc}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Headcount(Actual): " +
                                    "${snapshot.data![index].xdeadcounta}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Position Type: " +
                                    "${snapshot.data![index].xpositiontype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Reporting To: " +
                                    "${snapshot.data![index].xstaff}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Reporting Name: " +
                                    "${snapshot.data![index].staffn}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Budgeted Salary: " +
                                    "${snapshot.data![index].xsalbudget}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Location: " +
                                    "${snapshot.data![index].xlocation}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Employment Type: " +
                                    "${snapshot.data![index].xemptype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Made Of Advertisement: " +
                                    "${snapshot.data![index].xadvertise}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Requisition Status: " +
                                    "${snapshot.data![index].xstatusreqdesc}",
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
                                          Uri.parse(
                                              'http://${AppConstants.baseurl}/gazi/notification/hr/Emp_Req/empReq_Approve.php'),
                                          body: jsonEncode(<String, String>{
                                            "zid": "100000",
                                            "user": widget.zemail,
                                            "xposition": widget.xposition,
                                            "xpdreqnum": snapshot
                                                .data![index].xpdreqnum
                                                .toString(),
                                            "xstatusreq": snapshot
                                                .data![index].xstatusreq
                                                .toString(),
                                          }));
                                      Get.snackbar('Message', 'Approved',
                                          backgroundColor: Color(0XFF8CA6DB),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.TOP);

                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });
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
                                      /*showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Reject"),
                                              content: Column(
                                                children: [
                                                  Container(
                                                    //height: MediaQuery.of(context).size.height/6,
                                                    child: Column(
                                                      children: [
                                                        Text('')
                                                      ],
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
                                                                  'http://${AppConstants.baseurl}/gazi/notification/hr/Emp_Req/empReq_Reject.php'),
                                                              body: jsonEncode(<
                                                                  String,
                                                                  String>{
                                                                "zid": "100000",
                                                                "user": widget
                                                                    .zemail,
                                                                "xposition": widget
                                                                    .xposition,
                                                                "xstaff": snapshot.data![index].xstaff,
                                                                "xpdreqnum": snapshot.data![index].xpdreqnum.toString(),
                                                                "xnote": rejectNote
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
                                          });*/
                                      var response = await http.post(
                                          Uri.parse(
                                              'http://${AppConstants.baseurl}/gazi/notification/hr/Emp_Req/empReq_Reject.php'),
                                          body: jsonEncode(<String, String>{
                                            "zid": "100000",
                                            "user": widget.zemail,
                                            "xposition": widget.xposition,
                                            "xstaff":
                                                snapshot.data![index].xstaff,
                                            "xpdreqnum": snapshot
                                                .data![index].xpdreqnum
                                                .toString(),
                                            "xnote": rejectNote
                                          }));
                                      Get.snackbar(
                                        'Message',
                                        'Rejected',
                                        backgroundColor: Color(0XFF8CA6DB),
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                      );
                                      setState(() {
                                        snapshot.data!.removeAt(index);
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
