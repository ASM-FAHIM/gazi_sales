import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../../screen/SandD.dart';
import '../notification_models/cus_approval_admin_model.dart';

class CustomerApprovalNotification extends StatefulWidget {
  final String xposition;
  final String zemail;
  final String zid;
  final String xstaff;

  const CustomerApprovalNotification(
      {required this.xposition,
        required this.zemail,
        required this.zid,
        required this.xstaff,
        Key? key})
      : super(key: key);

  @override
  State<CustomerApprovalNotification> createState() => _CustomerApprovalNotificationState();
}

class _CustomerApprovalNotificationState extends State<CustomerApprovalNotification> {
  Future<List<CusApprovalModel>>? futurePost;
  String rejectNote = " ";

  Future<List<CusApprovalModel>> fetchPost() async {
    var response = await http.post(
      Uri.parse(
          'http://${AppConstants.baseurl}/gazi/notification/sales/customer/cus.php'),
      body: jsonEncode(
        <String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        },
      ),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<CusApprovalModel>(
              (json) => CusApprovalModel.fromJson(json))
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
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SalesDistribution(
                      xposition: widget.xposition,
                      zemail: widget.zemail,
                      zid: widget.zid,
                      xstaff: widget.xstaff,
                    )));
          },
        ),
        title: Center(
          child: Text(
            "Customer Approval",
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
              child: FutureBuilder<List<CusApprovalModel>>(
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
                                      "${snapshot.data![index].xcus}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Name : ${snapshot.data![index].xorg ?? ""}",
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
                            _commonExpansionTileWidget('Customer Group', '${snapshot.data![index].xgcus}'),
                            _commonExpansionTileWidget('Territory', '${snapshot.data![index].xterritory}'),
                            _commonExpansionTileWidget('Zone', '${snapshot.data![index].xzone}'),
                            _commonExpansionTileWidget('Zone Manage', '${snapshot.data![index].zm}'),
                            _commonExpansionTileWidget('Division', '${snapshot.data![index].division}'),
                            _commonExpansionTileWidget('DSM', '${snapshot.data![index].dsm}'),
                            _commonExpansionTileWidget('Executive', '${snapshot.data![index].xtsoname}'),
                            _commonExpansionTileWidget('Approval Status', '${snapshot.data![index].xstatusdesc}'),
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
                                  onPressed: () async {
                                    var response = await http.post(
                                        Uri.parse(
                                            'http://${AppConstants.baseurl}//gazi/notification/sales/customer/cus_Approve.php'),
                                        body: jsonEncode(<String, String>{
                                          "zid": widget.zid,
                                          "user": widget.zemail,
                                          "xposition": widget.xposition,
                                          "xcus": snapshot.data![index].xcus.toString(),
                                          "xstatus": snapshot.data![index].xstatus.toString()
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
                                    backgroundColor: Colors.redAccent,
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
                                                      }else{
                                                        return 'null';
                                                      }
                                                    },
                                                    scrollPadding:
                                                    const EdgeInsets.all(20),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                      // add padding to adjust text
                                                      isDense: false,

                                                      hintStyle:
                                                      GoogleFonts.bakbakOne(
                                                        //fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                      ),
                                                      labelText: "Reject Note",
                                                      labelStyle:
                                                      GoogleFonts.bakbakOne(
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
                                                onPressed: () async {
                                                  //http://$api/ughcm/adminapprove/poreject.php
                                                  if (rejectNote == " ") {
                                                    Navigator.pop(context);
                                                    print(
                                                        'response code: Empty field');
                                                    Get.snackbar('Warning!',
                                                        'Please enter reject note',
                                                        backgroundColor:
                                                        Colors.redAccent,
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                        SnackPosition.TOP);
                                                  } else {
                                                    var response = await http.post(
                                                        Uri.parse(
                                                            'http://${AppConstants.baseurl}/GAZI/Notification/sales/customer/cus_reject.php'),
                                                        body: jsonEncode(<
                                                            String, String>{
                                                          "zid": widget.zid,
                                                          "user": widget.zemail,
                                                          "xposition": widget.xposition,
                                                          "xcus": snapshot.data![index].xcus.toString(),
                                                          "xnote": rejectNote
                                                        }));
                                                    print(response.body);
                                                    Navigator.pop(context);
                                                    Get.snackbar(
                                                        'Message', 'Rejected',
                                                        backgroundColor:
                                                        const Color(0XFF8CA6DB),
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                        SnackPosition.TOP);

                                                    setState(() {
                                                      snapshot.data!
                                                          .removeAt(index);
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
                                        });
                                  },
                                  child: const Text("Reject",
                                      style: TextStyle(color: Colors.white)),
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
            width: MediaQuery.of(context).size.width / 2.3,
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
