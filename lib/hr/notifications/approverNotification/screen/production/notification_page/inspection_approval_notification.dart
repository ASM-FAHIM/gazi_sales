import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../api.dart';
import 'package:get/get.dart';
import '../../../../../../screen/Production.dart';
import '../notification_model/inspection_approval_admin_model.dart';

class InspectionApproval_notification extends StatefulWidget {
  const InspectionApproval_notification(
      {super.key, required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  final String xposition;
  final String xstaff;
  final String zemail;
  final String zid;

  @override
  State<InspectionApproval_notification> createState() =>
      _InspectionApproval_notificationState();
}

class _InspectionApproval_notificationState
    extends State<InspectionApproval_notification> {
  Future<List<InspectionNotificationModel>>? futurePost;
  String rejectNote = " ";
  String api = API_Names().api;

  Future<List<InspectionNotificationModel>> fetchPost() async {
    var response =
        await http.post(Uri.parse('http://${AppConstants.baseurl}/gazi/notification/production/ins/ins.php'),
            body: jsonEncode(<String, String>{
              "zid": widget.zid,
              "xposition": widget.xposition,
            }));

    // print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      is_pressed_approved_reject.clear();
      for (int i = 0; i < parsed.length; i++) {
        is_pressed_approved_reject.add(false);
      }

      return parsed
          .map<InspectionNotificationModel>(
              (json) => InspectionNotificationModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
  List<bool> is_pressed_approved_reject = [];
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
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductionNotificationList(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          zid: widget.zid,
                          xstaff: widget.xstaff,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Inspection Approval",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: const Color(0xff074974),
            ),
          ),
        ),
        actions: [
          const SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<InspectionNotificationModel>>(
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
                                "${snapshot.data![index].xtornum}",
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
                      _commonExpansionTileWidget('From Store', '${snapshot.data![index].xfwh}, ${snapshot.data![index].xfwhdesc}'),
                      _commonExpansionTileWidget('Finished Store', '${snapshot.data![index].xtwh}, ${snapshot.data![index].xtwhdesc}'),
                      _commonExpansionTileWidget('Finished Product', '${snapshot.data![index].xparentitem}, ${snapshot.data![index].xparentitemdesc}'),
                      _commonExpansionTileWidget('Goods Quantity', '${snapshot.data![index].xqtyfin}'),
                      _commonExpansionTileWidget('QC Reject Product', '${snapshot.data![index].xwastitem}, ${snapshot.data![index].xwastitemdesc}'),
                      _commonExpansionTileWidget('Reject Quantity', '${snapshot.data![index].xwastqty}'),
                      _commonExpansionTileWidget('Justification', '${snapshot.data![index].xlong}'),
                      _commonExpansionTileWidget('Status', '${snapshot.data![index].xstatustordesc}'),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),

                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 4.5,
                        padding: const EdgeInsets.only(left: 5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.centerLeft,
                        decoration:
                        const BoxDecoration(color: Colors.green),
                        child: const Text(
                          'Approvers :',
                          style: TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ),
                      if ('${snapshot.data![index].approverName1}'
                          .isNotEmpty) ...[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data![index].approverName1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverDesignation1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverXdeptname1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if ('${snapshot.data![index].approverName2}'
                          .isNotEmpty) ...[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data![index].approverName2}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverDesignation2}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverXdeptname2}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if ('${snapshot.data![index].approverName3}'
                          .isNotEmpty) ...[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data![index].approverName3}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverDesignation3}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverXdeptname3}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if ('${snapshot.data![index].approverName4}'
                          .isNotEmpty) ...[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data![index].approverName4}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverDesignation4}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverXdeptname4}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if ('${snapshot.data![index].approverName5}'
                          .isNotEmpty) ...[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data![index].approverName5}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverDesignation5}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].approverXdeptname5}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if ('${snapshot.data![index].rejectName}'
                          .isNotEmpty) ...[
                        Container(
                          height: 30,
                          width:
                          MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration:
                          const BoxDecoration(color: Colors.red),
                          child: const Text(
                            'Reject Signatory :',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                      if ('${snapshot.data![index].rejectName}'
                          .isNotEmpty) ...[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 5),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey))),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data![index].rejectName}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].rejectDesignation}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                '${snapshot.data![index].rejectXdeptname}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  //color: Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: is_pressed_approved_reject[index] ?  TextButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ) : TextButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: is_pressed_approved_reject[index] ? null :  () async{
                              setState(() {
                                is_pressed_approved_reject.removeAt(index);
                              });
                              var response = await http.post(
                                  Uri.parse(
                                      'http://${AppConstants.baseurl}/gazi/notification/production/ins/ins_approve.php'),
                                  body: jsonEncode(<String, String>{
                                    "zid": widget.zid,
                                    "user": widget.zemail,
                                    "xposition": widget.xposition,
                                    "xtornum": snapshot.data![index].xtornum.toString(),
                                    "xstatustor": snapshot.data![index].xstatustor.toString(),
                                  }));

                              Get.snackbar('Message', 'Approved',
                                  backgroundColor: const Color(0XFF8CA6DB),
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);

                              setState(() {
                                if (index >= 0 && index < snapshot.data!.length) {
                                  snapshot.data!.removeAt(index);
                                }
                              });

                              print(response.statusCode);
                              print(response.body);
                            },
                            child: const Text("Approve", style: TextStyle(color: Colors.white),),
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
                            onPressed: is_pressed_approved_reject[index] ? null :  () async{
                              setState(() {
                                is_pressed_approved_reject.removeAt(index);
                              });
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
                                              style:
                                                  GoogleFonts.bakbakOne(
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
                                              scrollPadding:
                                                  const EdgeInsets.all(20),
                                              decoration:
                                                  InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
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
                                          onPressed: is_pressed_approved_reject[index] ? null :  () async{
                                            setState(() {
                                              is_pressed_approved_reject.removeAt(index);
                                            });
                                            //http://172.20.20.69/adminapprove/poreject.php
                                            if (rejectNote == " ") {
                                              Navigator.pop(context);
                                              //print('response code: Empty field');
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
                                                      'http://${AppConstants.baseurl}/gazi/notification/production/ins/ins_reject.php'),
                                                  body: jsonEncode(<String, String>{
                                                    "zid": widget.zid,
                                                    "user": widget.zemail,
                                                    "xposition": widget.xposition,
                                                    "xtornum": snapshot.data![index].xtornum.toString(),
                                                    "xnote": rejectNote
                                                  }));
                                              //print(response.statusCode);
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
                            child: const Text("Reject", style: TextStyle(color: Colors.white),),
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
