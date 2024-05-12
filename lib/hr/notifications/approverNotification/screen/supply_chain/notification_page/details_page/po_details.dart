import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../api.dart';
import '../../notification_model/details_model/paf_details_model.dart';
import '../../notification_model/details_model/po_details_model.dart';

class PO_details_notification extends StatefulWidget {
  PO_details_notification({
    required this.xpornum,
    required this.zid,
    required this.xposition,
    required this.xstatus,
    required this.zemail,
    required this.xstaff,
  });

  String xpornum;
  String zid;
  String xposition;
  String xstatus;
  String xstaff;
  String zemail;

  @override
  State<PO_details_notification> createState() =>
      _PO_details_notificationState();
}

class _PO_details_notificationState extends State<PO_details_notification> {
  String api = API_Names().api;
  Future<List<POdetailsModel>>? futurePost;
  String rejectNote = " ";

  Future<List<POdetailsModel>> fetchPostdetails() async {
    print('status: ${widget.xstatus}');
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/Notification/scm/po_wo/po_detail.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xporeqnum": widget.xpornum,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<POdetailsModel>((json) => POdetailsModel.fromJson(json))
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
  bool is_pressed_approved_reject = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "${widget.xpornum} Details",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: const Color(0xff074974),
            ),
          ),
        ),
        actions: const [
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<POdetailsModel>>(
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
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _commonItemDescWidget('Item Code', snapshot.data![index].xitem.toString()),
                              _commonItemDescWidget('Description', snapshot.data![index].xdesc.toString()),
                              _commonItemDescWidget('Unit', snapshot.data![index].xunitpur.toString()),
                              _commonItemDescWidget('Quantity', snapshot.data![index].xqtypur.toString()),
                              _commonItemDescWidget('Rate', snapshot.data![index].xrate.toString()),
                              _commonItemDescWidget('Amount', snapshot.data![index].xlineamt.toString()),
                              _commonItemDescWidget('Specifications', snapshot.data![index].xspecification.toString()),

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
                        style: is_pressed_approved_reject ?  TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ) : TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: is_pressed_approved_reject ? null :  () async {

                          setState(() {
                            is_pressed_approved_reject = true;
                          });

                          var response = await http.post(
                              Uri.parse(
                                  'http://${AppConstants.baseurl}/GAZI/Notification/scm/po_wo/POApprove.php'),
                              body: jsonEncode(<String, String>{
                                "zid": widget.zid,
                                "user": widget.zemail,
                                "xposition": widget.xposition,
                                "xpornum": widget.xpornum,
                                "xstatus": widget.xstatus,
                              }));

                          Get.snackbar('Message', 'Approved',
                              backgroundColor: const Color(0XFF8CA6DB),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP);

                          Navigator.pop(context, "approval");
                          print(response.statusCode);
                        },
                        child: const Text("Approve",
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      TextButton(
                        style: is_pressed_approved_reject ?  TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ) : TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: is_pressed_approved_reject ? null :  () async {
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
                                          scrollPadding: const EdgeInsets.all(20),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 20),
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
                                      style: is_pressed_approved_reject ?  TextButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ) : TextButton.styleFrom(
                                        backgroundColor: Color(0xff064A76),
                                      ),
                                      onPressed: is_pressed_approved_reject ? null :  () async {

                                        setState(() {
                                          is_pressed_approved_reject = true;
                                        });

                                        //http://172.20.20.69/adminapprove/poreject.php
                                        if (rejectNote == " ") {
                                          Navigator.pop(context);
                                          print('response code: Empty field');
                                          Get.snackbar('Warning!',
                                              'Please enter reject note',
                                              backgroundColor: Colors.redAccent,
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP);
                                        } else {
                                          var response = await http.post(
                                              Uri.parse(
                                                  'http://${AppConstants.baseurl}/GAZI/Notification/scm/po_wo/POReject.php'),
                                              body: jsonEncode(<String, String>{
                                                "zid": widget.zid,
                                                "user": widget.zemail,
                                                "xposition": widget.xposition,
                                                "xpornum": widget.xpornum,
                                                "xnote": rejectNote
                                              }));
                                          Get.snackbar('Message', 'Rejected',
                                              backgroundColor:
                                                  const Color(0XFF8CA6DB),
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP);
                                          Navigator.pop(context);
                                          Navigator.pop(context, "approval");
                                          print(response.statusCode);
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
                              });
                        },
                        child: const Text("Reject",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                ],
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

  Widget _commonItemDescWidget(String tileName, String tileValue){
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
