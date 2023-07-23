import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../data_model/notification_model/admin_approver_model/details/voucher_details_model.dart';
import '../../../../../../../sales/constant/app_constants.dart';

class Voucher_details_notification extends StatefulWidget {
  Voucher_details_notification(
      {required this.xvoucher,
      required this.zid,
      required this.xstaff,
      required this.xposition,
      required this.xstatus,
      required this.zemail});

  String xvoucher;
  String xstaff;
  String zid;
  String xposition;
  String xstatus;
  String zemail;

  @override
  State<Voucher_details_notification> createState() =>
      _Voucher_details_notificationState();
}

class _Voucher_details_notificationState
    extends State<Voucher_details_notification> {
  Future<List<VoucherDetailsModel>>? futurePost;
  String rejectNote = " ";

  Future<List<VoucherDetailsModel>> fetchPostdetails() async {
    print('voucher: ${widget.zid}');
    print('voucher: ${widget.xvoucher}');
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/Notification/voucher/pendingVoucherDetails.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xvoucher": widget.xvoucher,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<VoucherDetailsModel>(
              (json) => VoucherDetailsModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePost = fetchPostdetails();
    fetchPostdetails().whenComplete(() => futurePost);
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
            "Voucher Details",
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
        child: FutureBuilder<List<VoucherDetailsModel>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Card(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6.0, left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data![index].xacc}",
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Description : " +
                                          snapshot.data![index].xdesc,
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Sub Code : " +
                                          snapshot.data![index].xsub,
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    //
                                    Text(
                                      "Sub description : " +
                                          "${snapshot.data![index].subdesc}",
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Debit: " +
                                          "${snapshot.data![index].xdebit}",
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Credit : " +
                                          snapshot.data![index].xcredit,
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
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () async {
                          var response = await http.post(
                              Uri.parse(
                                  'http://${AppConstants.baseurl}/ughcm/UG/pendingVoucherapproval.php'),
                              body: jsonEncode(<String, String>{
                                "zid": widget.zid,
                                "user": widget.zemail,
                                "xposition": widget.xposition,
                                "xvoucher": widget.xvoucher,
                                "xstatus": widget.xstatus
                                // "aprcs": "GRN Approval"
                              }));

                          Get.snackbar('Message', 'Approved',
                              backgroundColor: Color(0XFF8CA6DB),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);

                          Navigator.pop(context, "approval");

                          // setState(() {
                          //   snapshot.data!.removeAt(index);
                          // });

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
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
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
                                        child: TextField(
                                          style: GoogleFonts.bakbakOne(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          onChanged: (input) {
                                            rejectNote = input;
                                          },
                                          // validator: (input) {
                                          //   if (input!.isEmpty) {
                                          //     return "Please Write Reject Note";
                                          //   }
                                          // },
                                          scrollPadding: EdgeInsets.all(20),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 20),
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
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xff064A76)),
                                      onPressed: () async {
                                        //http://172.20.20.69/adminapprove/poreject.php

                                        var response = await http.post(
                                            Uri.parse(
                                                'http://${AppConstants.baseurl}/ughcm/UG/pendingVoucherreject.php'),
                                            body: jsonEncode(<String, String>{
                                              "zid": widget.zid,
                                              "user": widget.zemail,
                                              "xposition": widget.xposition,
                                              "xvoucher": widget.xvoucher,
                                              "xnote": rejectNote
                                            }));
                                        print(response.statusCode);
                                        print(response.body);
                                        print(rejectNote);

                                        Get.snackbar('Message', 'Rejected',
                                            backgroundColor: Color(0XFF8CA6DB),
                                            colorText: Colors.white,
                                            snackPosition:
                                                SnackPosition.BOTTOM);

                                        Navigator.pop(context);
                                        Navigator.pop(context, "approval");
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
