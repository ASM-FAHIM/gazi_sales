import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:gazi_sales_app/screen/FinanaceAccounts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../Notification_model/bill_admin_model.dart';

class BillNotificationScreen extends StatefulWidget {
  BillNotificationScreen(
      {required this.xposition,
        required this.xstaff,
        required this.zemail,
        required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<BillNotificationScreen> createState() => _BillNotificationScreenState();
}

class _BillNotificationScreenState extends State<BillNotificationScreen> {
  Future<List<BillAdminModel>>? futurePost;
  dynamic rejectNote = " ";
  Set<String> pressedButtonIds = {}; // Set to store the unique identifiers of pressed buttons

  // Declare uniqueId property directly in _BillNotificationScreenState
  late String uniqueId = "";

  Future<List<BillAdminModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/accounts/bill/bill.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<BillAdminModel>((json) => BillAdminModel.fromJson(json))
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

  @override
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
            "Pending Bill Notification",
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
            if (widget.zid == '100000') ...[
              Text(
                "Gazi Group",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ] else if (widget.zid == '400060') ...[
              Text(
                "Gazi SINKS",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ] else if (widget.zid == '400070') ...[
              Text(
                "Gazi DOORS",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ] else if (widget.zid == '400080') ...[
              Text(
                "Gazi TANKS",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ] else if (widget.zid == '400090') ...[
              Text(
                "Gazi PIPES",
                style: GoogleFonts.bakbakOne(
                  fontSize: 20,
                  color: const Color(0xff074974),
                ),
              ),
            ],
            Expanded(
              child: FutureBuilder<List<BillAdminModel>>(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data![index].xbillno}",
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
                            _commonExpansionTileWidget('Date', '${snapshot.data![index].xdate}'),
                            _commonExpansionTileWidget('Amount', '${snapshot.data![index].xamount}'),
                            _commonExpansionTileWidget('Employee', '${snapshot.data![index].xstaff}, ${snapshot.data![index].preparerName}'),
                            _commonExpansionTileWidget('Location', '${snapshot.data![index].xwh}, ${snapshot.data![index].xfbrname}'),
                            _commonExpansionTileWidget('Justification', '${snapshot.data![index].xlong}'),
                            _commonExpansionTileWidget('Status', '${snapshot.data![index].xstatusrdesc}'),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: pressedButtonIds.contains(snapshot.data![index])
                                      ? TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  )
                                      : TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: pressedButtonIds.contains(index)
                                      ? null
                                      : () async {
                                    // Add the unique identifier of the current item to the set
                                    setState(() {
                                      pressedButtonIds.add(index.toString());
                                    });
                                    var response = await http.post(
                                        Uri.parse(
                                            'http://${AppConstants.baseurl}/gazi/notification/accounts/bill/bill_approve.php'),
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

                                    //print(response.statusCode);
                                    //print(response.body);
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
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
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
                                                  style: GoogleFonts.bakbakOne(
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
                                                  scrollPadding: const EdgeInsets.all(20),
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.only(left: 20),
                                                    // add padding to adjust text
                                                    isDense: false,
                                                    hintStyle: GoogleFonts.bakbakOne(
                                                      //fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    ),
                                                    labelText: "Reject Note",
                                                    labelStyle: GoogleFonts.bakbakOne(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    ),
                                                    border: const OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Color(0xff064A76),
                                              ),
                                              onPressed: () async {
                                                //http://172.20.20.69/adminapprove/poreject.php
                                                if (rejectNote == " ") {
                                                  Navigator.pop(context);
                                                  //print('response code: Empty field');
                                                  Get.snackbar('Warning!',
                                                      'Please enter reject note',
                                                      backgroundColor: Colors.redAccent,
                                                      colorText: Colors.white,
                                                      snackPosition: SnackPosition.TOP);
                                                } else {
                                                  var response = await http.post(
                                                      Uri.parse(
                                                          'http://${AppConstants.baseurl}/gazi/notification/accounts/bill/bill_reject.php'),
                                                      body: jsonEncode(<String, String>{
                                                        "zid": widget.zid,
                                                        "user": widget.zemail,
                                                        "xposition": widget.xposition,
                                                        "xbillno": snapshot.data![index].xbillno,
                                                        "xnote": rejectNote
                                                      }));
                                                  //print(response.statusCode);
                                                  Navigator.pop(context);
                                                  Get.snackbar('Message', 'Rejected',
                                                      backgroundColor: const Color(0XFF8CA6DB),
                                                      colorText: Colors.white,
                                                      snackPosition: SnackPosition.TOP);

                                                  setState(() {
                                                    snapshot.data!.removeAt(index);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                "Reject",
                                                style: GoogleFonts.bakbakOne(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                          scrollable: true,
                                        );
                                      },
                                    );
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

  Widget _commonExpansionTileWidget(String tileName, String tileValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.6,
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
                Text(
                  ':',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    //color: Color(0xff074974),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              tileValue,
              style: GoogleFonts.poppins(
                fontSize: 14,
                //color: Color(0xff074974),
              ),
            ),
          )
        ],
      ),
    );
  }
}
