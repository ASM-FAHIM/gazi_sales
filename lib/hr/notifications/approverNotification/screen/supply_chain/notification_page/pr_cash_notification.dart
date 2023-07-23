import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../../../../api.dart';
import '../notification_model/pr_cash_admin_model.dart';
import '../notification_model/pr_cs_admin_model.dart';
import 'details_page/pr_cash_details.dart';

class Cash_notification extends StatefulWidget {
  //const CS_notification({Key? key}) : super(key: key);
  Cash_notification(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});
  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<Cash_notification> createState() => _Cash_notificationState();
}

class _Cash_notificationState extends State<Cash_notification> {
  Future<List<CashNoticationModel>>? futurePost;
  String rejectNote = " ";
  String api = API_Names().api;
  Future<List<CashNoticationModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse('http://$api/ughcm/UG/purchase/CashAdv_Notification.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    // print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<CashNoticationModel>(
              (json) => CashNoticationModel.fromJson(json))
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
          },
        ),
        title: Center(
          child: Text(
            "Cash Approval",
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
        child: FutureBuilder<List<CashNoticationModel>>(
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
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              " ${snapshot.data![index].xporeqnum}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.bakbakOne(
                                                fontSize: 18,
                                                //color: Color(0xff074974),
                                              ),
                                            ),
                                            Text(
                                              " ${snapshot.data![index].preparerName}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.bakbakOne(
                                                fontSize: 18,
                                                //color: Color(0xff074974),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Requisition Number :" +
                                    "${snapshot.data![index].xporeqnum}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Date : " + snapshot.data![index].xdate,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Requisition Status : " +
                                    snapshot.data![index].xstatusreq,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Requisition Type : " +
                                    snapshot.data![index].xtypeobj,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Note : " + snapshot.data![index].xnote,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Reject Note : " + snapshot.data![index].xnote1,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Preparer Name : " +
                                    snapshot.data![index].preparerName,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Preparer Designation : " +
                                    snapshot.data![index].preparerName,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Rejected by : " +
                                    snapshot.data![index].signrejectName,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Designation : " +
                                    snapshot.data![index].signrejectDesignation,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent
                                ),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Cash_details_notification(
                                                xporeqnum: snapshot
                                                    .data![index].xporeqnum,
                                                zid: widget.zid,
                                                xposition: widget.xposition,
                                                zemail: widget.zemail,
                                                xstatusreq: snapshot
                                                    .data![index].xstatusreq,
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
                                child: Center(child: Text("Details")),
                              ),
                              /* Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    color: Colors.green,
                                    onPressed: () async {
                                      var response = await http.post(
                                          Uri.parse(
                                              'http://$api/ughcm/adminapprove/csapprove.php'),
                                          body: jsonEncode(<String, String>{
                                            "zid": widget.zid,
                                            "user": widget.zemail,
                                            "xposition": widget.xposition,
                                            "xporeqnum": snapshot
                                                .data![index].requisition
                                                .toString(),
                                            "ypd": "0",
                                            "xstatusreq": snapshot
                                                .data![index].xstatusreq
                                                .toString(),
                                          }));

                                      Get.snackbar('Message', 'Approved',
                                          backgroundColor: Color(0XFF8CA6DB),
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM);

                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });

                                      print(response.statusCode);
                                      print(response.body);
                                    },
                                    child: Text("Approve"),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  TextButton(
                                    color: Colors.red,
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
                                                            left:
                                                            20), // add padding to adjust text
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
                                                  color: Color(0xff064A76),
                                                  onPressed: () async {
                                                    //http://$api/ughcm/adminapprove/poreject.php

                                                    var response = await http.post(
                                                        Uri.parse(
                                                            'http://$api/ughcm/adminapprove/csreject.php'),
                                                        body: jsonEncode(<
                                                            String, String>{
                                                          "zid": widget.zid,
                                                          "user": widget.zemail,
                                                          "xposition":
                                                          widget.xposition,
                                                          "xporeqnum": snapshot
                                                              .data![index]
                                                              .requisition
                                                              .toString(),
                                                          "wh": "0",
                                                          "xnote": rejectNote,
                                                        }));
                                                    print(response.body);

                                                    print("Rejected " +
                                                        snapshot.data![index]
                                                            .requisition
                                                            .toString());
                                                    Navigator.pop(context);

                                                    Get.snackbar(
                                                        'Message', 'Rejected',
                                                        backgroundColor:
                                                        Color(0XFF8CA6DB),
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                        SnackPosition
                                                            .BOTTOM);

                                                    setState(() {
                                                      snapshot.data!
                                                          .removeAt(index);
                                                    });
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
                                    child: Text("Reject"),
                                  ),
                                ],
                              )*/
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
                child: Image(image: AssetImage("images/loading.gif")),
              );
            }
          },
        ),
      ),
    );
  }
}
