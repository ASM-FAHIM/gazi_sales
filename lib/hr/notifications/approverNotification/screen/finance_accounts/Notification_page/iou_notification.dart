import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:gazi_sales_app/screen/FinanaceAccounts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../Notification_model/iou_admin_model.dart';

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
      is_pressed_approved_reject.clear();
      for (int i = 0; i < parsed.length; i++) {
        is_pressed_approved_reject.add(false);
      }

      return parsed
          .map<PendingIouModel>((json) => PendingIouModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  List<bool> is_pressed_approved_reject = [];

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
              color: const Color(0xff074974),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            if(widget.zid == '100000')...[
              Text(
                "Gazi Group",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ]
            else if(widget.zid == '400060')...[
              Text(
                "Gazi SINKS",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ]
            else if(widget.zid == '400070')...[
                Text(
                  "Gazi DOORS",
                  style: GoogleFonts.bakbakOne(
                    fontSize: 20,
                    color: const Color(0xff074974),
                  ),
                ),
              ]
              else if(widget.zid == '400080')...[
                  Text(
                    "Gazi TANKS",
                    style: GoogleFonts.bakbakOne(
                      fontSize: 20,
                      color: const Color(0xff074974),
                    ),
                  ),
                ]
                else if(widget.zid == '400090')...[
                    Text(
                      "Gazi PIPES",
                      style: GoogleFonts.bakbakOne(
                        fontSize: 20,
                        color: const Color(0xff074974),
                      ),
                    ),
                  ],
            Expanded(
              child: FutureBuilder<List<PendingIouModel>>(
                future: futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Card(
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          collapsedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50))),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].xbillno,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Prepared By : ${snapshot.data![index].preparerName ?? ""}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          childrenPadding: const EdgeInsets.only(left: 10, right: 10),
                          children: <Widget>[
                            _commonExpansionTileWidget('Date', snapshot.data![index].xdate),
                            _commonExpansionTileWidget('Employee', '${snapshot.data![index].xstaff}, ${snapshot.data![index].preparerName}'),
                            _commonExpansionTileWidget('Location', '${snapshot.data![index].xwh}, ${snapshot.data![index].regidesc}'),
                            _commonExpansionTileWidget('Purpose', snapshot.data![index].xpurpose),
                            _commonExpansionTileWidget('Req. Amount', snapshot.data![index].xamount),
                            _commonExpansionTileWidget('Justification', '${snapshot.data![index].xwh}, ${snapshot.data![index].xlong}'),
                            _commonExpansionTileWidget('Status', snapshot.data![index].xstatusdesc),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: is_pressed_approved_reject[index]  ?  TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ) : TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: is_pressed_approved_reject[index]  ? null :  () async {

                                    // print("snapshot.data![index].xbillno.toString() ${snapshot.data![index].xbillno.toString()}");


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
                                        backgroundColor: const Color(0XFF8CA6DB),
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP);

                                    setState(() {
                                      snapshot.data!.removeAt(index);
                                    });

                                    print(response.statusCode);
                                    print(response.body);
                                  },
                                  child: const Text(
                                    "Approve",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                TextButton(
                                  style: is_pressed_approved_reject[index] ?  TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ) : TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: is_pressed_approved_reject[index]? null :  () async {
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
                                                        const EdgeInsets.all(20),
                                                    decoration:
                                                        InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(
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
                                                          const OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                style: is_pressed_approved_reject[index] ?  TextButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                ) : TextButton.styleFrom(
                                                  backgroundColor: Color(0xff064A76),
                                                ),
                                                onPressed: is_pressed_approved_reject[index] ? null :  () async {

                                                  setState(() {
                                                    is_pressed_approved_reject.removeAt(index);
                                                  });
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
                                                          const Color(0XFF8CA6DB),
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
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
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
          ],
        ),
      ),
    );
  }

  Widget _commonExpansionTileWidget(String tileName, String tileValue){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tileName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    //color: Color(0xff074974),
                  ),
                ),
                Text(':',style: GoogleFonts.poppins(
                  fontSize: 14,
                  //color: Color(0xff074974),
                ),),
              ],
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Text(tileValue,style: GoogleFonts.poppins(
              fontSize: 14,
              //color: Color(0xff074974),
            ),),
          )
        ],
      ),
    );
  }
}
