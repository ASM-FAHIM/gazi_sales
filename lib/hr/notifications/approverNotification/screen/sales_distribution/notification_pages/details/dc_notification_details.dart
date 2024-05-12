import 'dart:convert';

import '../../../../../../../conts_api_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../sales/constant/app_constants.dart';
import '../../notification_models/details_model/dc_details_model.dart';

class DC_Details_Notification extends StatefulWidget {
  DC_Details_Notification(
      {required this.xdornum,
      required this.xdocnum,
      required this.zid,
      required this.xposition,
      required this.xstatus,
      required this.zemail,
      required this.xstaff});

  String xdornum;
  String xdocnum;
  String zid;
  String xposition;
  String xstatus;
  String xstaff;
  String zemail;

  @override
  State<DC_Details_Notification> createState() =>
      _DC_Details_NotificationState();
}

class _DC_Details_NotificationState extends State<DC_Details_Notification> {
  Future<List<DcDetailsModel>>? futurePost;
  String rejectNote = " ";

  Future<List<DcDetailsModel>> fetchPostdetails() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc_Details.php'),
        body: jsonEncode(
            <String, String>{"zid": widget.zid, "xdornum": widget.xdocnum}));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      print("Dc Details Api:${ConstApiLink().dcDetailsApi}");
      print(response.body);

      return parsed
          .map<DcDetailsModel>((json) => DcDetailsModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  bool is_pressed_approved_reject = false;

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
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "${widget.xdocnum} Details",
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
        child: FutureBuilder<List<DcDetailsModel>>(
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
                              _commonItemDescWidget('Unit', snapshot.data![index].xunit.toString()),
                              _commonItemDescWidget('Quantity', snapshot.data![index].xqtyord.toString()),
                              _commonItemDescWidget('Rate', snapshot.data![index].xrate.toString()),
                              _commonItemDescWidget('Regular Price', snapshot.data![index].xlineamt.toString()),
                              _commonItemDescWidget('VAT Amt', snapshot.data![index].xvatamt.toString()),
                              _commonItemDescWidget('Net Amt', snapshot.data![index].xnetamt.toString()),

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
                                  'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc_Approve.php'),
                              body: jsonEncode(<String, String>{
                                "zid": widget.zid,
                                "user": widget.zemail,
                                "xposition": widget.xposition,
                                "xdornum": widget.xdornum.toString(),
                                "xstatus": widget.xstatus.toString()
                              }));
                          print(widget.xdornum.toString());

                          Get.snackbar('Message', 'Approved',
                              backgroundColor: const Color(0XFF8CA6DB),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP);

                          Navigator.pop(context, "approval");
                          print(response.statusCode);
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
                                        if (rejectNote == " ") {
                                          Navigator.pop(context);
                                          Get.snackbar('Warning!',
                                              'Please enter reject note',
                                              backgroundColor: Colors.redAccent,
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP);
                                        } else {
                                          var response = await http.post(
                                              Uri.parse(
                                                  'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc_Reject.php'),
                                              body: jsonEncode(<String, String>{
                                                "zid": widget.zid,
                                                "user": widget.zemail,
                                                "xposition": widget.xposition,
                                                "xdornum": widget.xdornum,
                                                "xnote": rejectNote
                                              }));
                                          print(
                                              'successful: ${response.statusCode}');
                                          Get.snackbar('Message', 'Rejected',
                                              backgroundColor:
                                                  const Color(0XFF8CA6DB),
                                              colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP);

                                          Navigator.pop(context);
                                          Navigator.pop(context, "approval");
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
                        child: const Text(
                          "Reject",
                          style: TextStyle(color: Colors.white),
                        ),
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
