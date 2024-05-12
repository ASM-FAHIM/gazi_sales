import 'dart:convert';
import '../../../../../../../conts_api_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../data_model/notification_model/admin_approver_model/details/cs_details_model.dart';
import '../../../../../../../sales/constant/app_constants.dart';

class CS_details_notification extends StatefulWidget {
  CS_details_notification(
      {required this.xporeqnum,
      required this.zid,
      required this.xposition,
      required this.xstatusreq,
      required this.zemail});

  String xporeqnum;
  String zid;
  String xposition;
  String xstatusreq;
  String zemail;

  @override
  State<CS_details_notification> createState() =>
      _CS_details_notificationState();
}

class _CS_details_notificationState extends State<CS_details_notification> {
  Future<List<CsDetailsModel>>? futurePost;

  //String rejectNote = " ";
  TextEditingController rejectNote = TextEditingController();

  Future<List<CsDetailsModel>> fetchPostdetails() async {
    var response = await http.post(
        Uri.parse(
            "http://${AppConstants.baseurl}/GAZI/Notification/scm/CS/cs_Details.php"),
        body: jsonEncode(<String, String>{
          "xporeqnum": widget.xporeqnum,
          "zid": widget.zid
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<CsDetailsModel>((json) => CsDetailsModel.fromJson(json))
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
          icon: Icon(Icons.arrow_back),
          color: Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "${widget.xporeqnum} Details",
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
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<CsDetailsModel>>(
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
                              _commonItemDescWidget('Specification', snapshot.data![index].productName.toString()),
                              _commonItemDescWidget('Unit', snapshot.data![index].xunitpur.toString()),
                              _commonItemDescWidget('Quantity', snapshot.data![index].xqtyreq.toString()),
                              _commonItemDescWidget('Rate', snapshot.data![index].xrate.toString()),

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
                                  "http://${AppConstants.baseurl}/GAZI/Notification/scm/CS/csapprove.php"),
                              body: jsonEncode(<String, String>{
                                "zid": widget.zid,
                                "user": widget.zemail,
                                "xposition": widget.xposition,
                                "xporeqnum": widget.xporeqnum,
                                "xstatusreq": widget.xstatusreq,
                              }));

                          Get.snackbar('Message', 'Approved',
                              backgroundColor: Color(0XFF8CA6DB),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP);

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
                                        child: TextFormField(
                                          style: GoogleFonts.bakbakOne(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                          onChanged: (input) {
                                            rejectNote.text = input;
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
                                        if (rejectNote.text.isEmpty) {
                                          Navigator.pop(context);
                                          Get.snackbar('Warning!',
                                              'Please enter reject note',
                                              backgroundColor: Colors.redAccent,
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP);
                                        } else {
                                          var response = await http.post(
                                              Uri.parse(
                                                  "http://${AppConstants.baseurl}/GAZI/Notification/scm/CS/csreject.php"),
                                              body: jsonEncode(<String, String>{
                                                "zid": widget.zid,
                                                "user": widget.zemail,
                                                "xposition": widget.xposition,
                                                "xporeqnum":
                                                    widget.xporeqnum.toString(),
                                                "xnote": rejectNote.text,
                                              }));
                                          Get.snackbar('Message', 'Rejected',
                                              backgroundColor:
                                                  Color(0XFF8CA6DB),
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP);

                                          Navigator.pop(context);
                                          Navigator.pop(context, "approval");
                                        }

                                        // setState(() {
                                        //   snapshot.data!.removeAt(index);
                                        // });
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

  Widget _commonItemDescWidget(String tileName, String tileValue){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
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
