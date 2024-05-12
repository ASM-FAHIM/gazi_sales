import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/FinanaceAccounts.dart';
import '../Notification_model/do_admin_model.dart';

class DO_notification extends StatefulWidget {
  DO_notification(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<DO_notification> createState() => _DO_notificationState();
}

class _DO_notificationState extends State<DO_notification> {
  Future<List<DoModel>>? futurePost;
  dynamic rejectNote = " ";

  Future<List<DoModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/accounts/do/do.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<DoModel>((json) => DoModel.fromJson(json)).toList();
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
            "Supplier Invoice Notification",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: Color(0xff074974),
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
              child: FutureBuilder<List<DoModel>>(
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
                                      "${snapshot.data![index].xgrninvno}",
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
                            _commonExpansionTileWidget('Supplier Invoice Number: ', '${snapshot.data![index].xgrninvno}'),
                            _commonExpansionTileWidget('Date: ', '${snapshot.data![index].xdate}'),
                            _commonExpansionTileWidget('PO Number: ', '${snapshot.data![index].xpornum}'),
                            _commonExpansionTileWidget('Invoice Number: ', '${snapshot.data![index].xinvnum}'),
                            _commonExpansionTileWidget('Supplier: ', '${snapshot.data![index].xpornum}, ${snapshot.data![index].xsupname}'),
                            _commonExpansionTileWidget('GRN Amount: ', '${snapshot.data![index].xgrnamt}'),
                            _commonExpansionTileWidget('Supplier Payable: ', '${snapshot.data![index].xgrnamt}'),
                            _commonExpansionTileWidget('Approval Status: ', '${snapshot.data![index].xstatusrdesc}'),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () async {/*
                                    var response = await http.post(
                                        Uri.parse(
                                            'http://${AppConstants.baseurl}/gazi/notification/accounts/Voucher/Voucher_approve.php'),
                                        body: jsonEncode(<String, String>{
                                          "zid": widget.zid,
                                          "user": widget.zemail,
                                          "xposition": widget.xposition,
                                          "xvoucher": snapshot
                                              .data![index].xvoucher
                                              .toString(),
                                          "xstatus": snapshot
                                              .data![index].xstatusmr
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
                                    print(response.body);*/
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
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                  const Color(0xff064A76),
                                                ),
                                                //color: Color(0xff064A76),
                                                onPressed: () async {/*
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
                                                            'http://${AppConstants.baseurl}/gazi/notification/accounts/mr/mr_reject.php'),
                                                        body: jsonEncode(<
                                                            String,
                                                            String>{
                                                          "zid":
                                                          widget.zid,
                                                          "user": widget
                                                              .zemail,
                                                          "xposition": widget
                                                              .xposition,
                                                          "xvoucher": snapshot
                                                              .data![
                                                          index]
                                                              .xvoucher
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
                                                  }*/
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



      /*body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<DoModel>>(
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
                          padding: EdgeInsets.only(left: 10, bottom: 6.0),
                          child: ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data![index].xvoucher}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data![index].preparer ?? ""}",
                                            style: GoogleFonts.bakbakOne(
                                              fontSize: 18,
                                              //color: Color(0xff074974),
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data![index].deptname ?? ""}",
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
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "Invoice Number: " +
                                    " ${snapshot.data![index].xvoucher}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Date: " + " ${snapshot.data![index].xdate}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              */ /*Text(
                                "Delivery Date: " +
                                    " ${DateFormat("dd-MM-yyyy").format(DateTime.parse((snapshot.data![index].xdatedel.date).toString()))}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),*/ /*
                              Text(
                                "PO Number: " + "${snapshot.data![index].xp}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Customer Name: " +
                                    "${snapshot.data![index].xorg ?? " "}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Customer Type: " +
                                    "${snapshot.data![index].xpaymentterm ?? " "}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Plant/Project Code: " +
                                    snapshot.data![index].xwh,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Sub Category: " +
                                    "${snapshot.data![index].xsubcat}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              //Cash
                              Text(
                                "Invoice Type: " +
                                    "${snapshot.data![index].xpaymenttype}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "District: " +
                                    "${snapshot.data![index].xdistrictop}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Thana: " + "${snapshot.data![index].xthanaop}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Zone: " + "${snapshot.data![index].xarea}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              //ASM Name
                              Text(
                                "ASM Name: " +
                                    "${snapshot.data![index].asmname}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Territory: " +
                                    "${snapshot.data![index].xterritory}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Division: " +
                                    "${snapshot.data![index].xdivisionop}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Division Sales Manager Name: " +
                                    "${snapshot.data![index].dsmname}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Territory Sales Officer Name: " +
                                    "${snapshot.data![index].xtsoname}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Transfer Chalan Number: " +
                                    "${snapshot.data![index].xtornum}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Order Status: " +
                                    "${snapshot.data![index].xtornum}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Approval Status: " +
                                    "${snapshot.data![index].xstatus}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Voucher Number: " +
                                    "${snapshot.data![index].xvoucher ?? " "}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Status: " +
                                    "${snapshot.data![index].xstatusjv}",
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                                //color: Colors.lightBlueAccent,
                                onPressed: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DO_details_notification(
                                                xdornum: snapshot
                                                    .data![index].xdornum,
                                                zid: widget.zid,
                                                xposition: widget.xposition,
                                                zemail: widget.zemail,
                                                xstatus: snapshot
                                                    .data![index].xstatus,
                                                xstaff: widget.xstaff,
                                              )));
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
      ),*/
  Widget _commonExpansionTileWidget(String tileName, String tileValue){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.2,
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
