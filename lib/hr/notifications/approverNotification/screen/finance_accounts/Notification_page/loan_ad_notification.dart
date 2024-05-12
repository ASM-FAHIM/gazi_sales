import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/FinanaceAccounts.dart';
import '../Notification_model/ar_admin_model.dart';
import '../Notification_model/load_ad_admin_model.dart';

class LoanAdjustNotificationScreen extends StatefulWidget {
  LoanAdjustNotificationScreen(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<LoanAdjustNotificationScreen> createState() =>
      _LoanAdjustNotificationScreenState();
}

class _LoanAdjustNotificationScreenState
    extends State<LoanAdjustNotificationScreen> {
  Future<List<LoanAdAdminModel>>? futurePost;
  dynamic rejectNote = " ";

  Future<List<LoanAdAdminModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/accounts/Loan_Adj/LoanAdj.php'),
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
          .map<LoanAdAdminModel>((json) => LoanAdAdminModel.fromJson(json))
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
            "Loan Adjustment Notification",
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
              child: FutureBuilder<List<LoanAdAdminModel>>(
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
                                      "${snapshot.data![index].xadjnum}",
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
                            _commonExpansionTileWidget('Adjustment Type', '${snapshot.data![index].xtypeobj}'),
                            _commonExpansionTileWidget('Transaction Type', '${snapshot.data![index].xtrn}'),
                            _commonExpansionTileWidget('Loan No', '${snapshot.data![index].xloannum}'),
                            _commonExpansionTileWidget('Adjustment Amount', '${snapshot.data![index].xprime}'),
                            _commonExpansionTileWidget('Bank', '${snapshot.data![index].xbank}, ${snapshot.data![index].xbankdesc}'),
                            _commonExpansionTileWidget('Account', '${snapshot.data![index].xacc}, ${snapshot.data![index].xaccdesc}'),
                            _commonExpansionTileWidget('Approval Status', '${snapshot.data![index].xstatusrdesc}'),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: is_pressed_approved_reject[index] ?  TextButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ) : TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: is_pressed_approved_reject[index]  ? null :  () async {
                                    setState(() {
                                      is_pressed_approved_reject.removeAt(index);
                                    });
                                    var response = await http.post(
                                        Uri.parse(
                                            'http://${AppConstants.baseurl}/gazi/notification/accounts/Loan_Adj/LoanAdj_approve.php'),
                                        body: jsonEncode(<String, String>{
                                          "zid": widget.zid,
                                          "user": widget.zemail,
                                          "xposition": widget.xposition,
                                          "xadjnum": snapshot
                                              .data![index].xadjnum
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
                                                style: is_pressed_approved_reject[index]  ?  TextButton.styleFrom(
                                                  backgroundColor: Colors.grey,
                                                ) : TextButton.styleFrom(
                                                  backgroundColor: Color(0xff064A76),
                                                ),
                                                onPressed: is_pressed_approved_reject[index]  ? null :  () async {

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
                                                                'http://${AppConstants.baseurl}/gazi/notification/accounts/Loan_Adj/LoanAdj_reject.php'),
                                                            body: jsonEncode(<
                                                                String,
                                                                String>{
                                                              "zid":
                                                                  widget.zid,
                                                              "user": widget
                                                                  .zemail,
                                                              "xposition": widget
                                                                  .xposition,
                                                              "xadjnum": snapshot
                                                                  .data![
                                                                      index]
                                                                  .xadjnum
                                                                  .toString(),
                                                              "xnote":
                                                                  rejectNote
                                                            }));
                                                    print(
                                                        response.statusCode);
                                                    Navigator.pop(context);
                                                    Get.snackbar(
                                                        'Message', 'Rejected',
                                                        backgroundColor:
                                                            const Color(0XFF8CA6DB),
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
