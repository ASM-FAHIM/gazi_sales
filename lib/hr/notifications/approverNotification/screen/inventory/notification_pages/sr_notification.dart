import 'dart:convert';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/inventory/notification_pages/details_page/sr_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../conts_api_link.dart';
import '../../../../../../data_model/notification_model/admin_approver_model/sr_admin_model.dart';
import '../../../../../../sales/constant/app_constants.dart';
import '../../approver_notification.dart';

class SR_notification extends StatefulWidget {
  SR_notification(
      {required this.xposition,
      required this.zemail,
      required this.zid,
      required this.xstaff});

  String xposition;
  String zemail;
  String zid;
  String xstaff;

  @override
  State<SR_notification> createState() => _SR_notificationState();
}

class _SR_notificationState extends State<SR_notification> {
  Future<List<SrNotiModel>>? futurePost;

  //String rejectNote = " ";
  TextEditingController rejectNote = TextEditingController();

  Future<List<SrNotiModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/inventory/sr_notifications.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<SrNotiModel>((json) => SrNotiModel.fromJson(json))
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
            "Pending SR For Approval",
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
        child: FutureBuilder<List<SrNotiModel>>(
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
                          padding: EdgeInsets.only(bottom: 6.0, left: 10),
                          child: ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: Text(
                                        "${snapshot.data![index].requisition}",
                                        style: GoogleFonts.bakbakOne(
                                          fontSize: 18,
                                          //color: Color(0xff074974),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "SR Date: " + snapshot.data![index].xdate,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Business ID:" +
                                    " ${snapshot.data![index].zid}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Store name : ${snapshot.data![index].twhdesc}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Requisition number :  ${snapshot.data![index].requisition}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Status:" +
                                    "${snapshot.data![index].xstatustor}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    primary: Colors.lightBlueAccent),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SR_details_notification(
                                                xtornum: snapshot
                                                    .data![index].requisition,
                                                zid: widget.zid,
                                                xposition: widget.xposition,
                                                zemail: widget.zemail,
                                                xstatustor: snapshot
                                                    .data![index].xstatustor,
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
                                child: Center(
                                    child: Text(
                                  "Details",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    onPressed: () async {
                                      var response = await http.post(
                                          Uri.parse(
                                              'http://${AppConstants.baseurl}/GAZI/Notification/sr/srapprove.php'),
                                          body: jsonEncode(<String, String>{
                                            // "zid":snapshot.data![index].zid.toString(),
                                            "zid": widget.zid,
                                            "user": widget.zemail,
                                            "xposition": widget.xposition,
                                            "xtornum": snapshot
                                                .data![index].requisition
                                                .toString(),
                                            "ypd": "0",
                                            "xstatustor": snapshot
                                                .data![index].xstatustor
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
                                        backgroundColor: Colors.red),
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
                                                        rejectNote.text = input;
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
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xff064A76)),
                                                  onPressed: () async {
                                                    if (rejectNote
                                                        .text.isEmpty) {
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
                                                                  .BOTTOM);
                                                    } else {
                                                      var response =
                                                          await http.post(
                                                              Uri.parse(
                                                                  'http://${AppConstants.baseurl}/GAZI/Notification/sr/srreject.php'),
                                                              body: jsonEncode(<
                                                                  String,
                                                                  String>{
                                                                // "zid": snapshot.data![index].zid.toString(),
                                                                "zid":
                                                                    widget.zid,
                                                                "user": widget
                                                                    .zemail,
                                                                "xposition": widget
                                                                    .xposition,
                                                                "xtornum": snapshot
                                                                    .data![
                                                                        index]
                                                                    .requisition
                                                                    .toString(),
                                                                "wh": "0",
                                                                "xnote":
                                                                    rejectNote
                                                                        .text,
                                                              }));
                                                      print(response.body);

                                                      print("Rejected " +
                                                          snapshot.data![index]
                                                              .requisition
                                                              .toString());
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        snapshot.data!
                                                            .removeAt(index);
                                                      });

                                                      Get.snackbar(
                                                          'Message', 'Rejected',
                                                          backgroundColor:
                                                              Color(0XFF8CA6DB),
                                                          colorText:
                                                              Colors.white,
                                                          snackPosition:
                                                              SnackPosition
                                                                  .BOTTOM);
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
                child: Image(image: AssetImage("assets/images/loading.gif")),
              );
            }
          },
        ),
      ),
    );
  }
}
