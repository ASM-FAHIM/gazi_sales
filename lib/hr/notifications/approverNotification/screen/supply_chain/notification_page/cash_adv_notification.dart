import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/SupplyChain.dart';
import '../notification_model/cash_adv_admin_model.dart';
import 'details_page/cash_adv_details.dart';

class CashAdvNotifScreen extends StatefulWidget {
 final String xposition;
 final String xstaff;
 final String zemail;
 final String zid;

  const CashAdvNotifScreen(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid,
      Key? key})
      : super(key: key);

  @override
  State<CashAdvNotifScreen> createState() => _CashAdvNotifScreenState();
}

class _CashAdvNotifScreenState extends State<CashAdvNotifScreen> {
  Future<List<CashAdvNotificationModel>>? futurePost;
  String rejectNote = " ";

  Future<List<CashAdvNotificationModel>> fetchPost() async {
    var response = await http.post(
      Uri.parse(
          'http://${AppConstants.baseurl}/GAZI/Notification/scm/Cash_Adv/cash_adv.php'),
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
          .map<CashAdvNotificationModel>(
              (json) => CashAdvNotificationModel.fromJson(json))
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
                    builder: (context) => PurchaseNotificationList(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          zid: widget.zid,
                          xstaff: widget.xstaff,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Cash Adv. Approval",
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
              child: FutureBuilder<List<CashAdvNotificationModel>>(
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
                                      "${snapshot.data![index].xporeqnum}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Total Amount : ${snapshot.data![index].totalAmt}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
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
                            _commonExpansionTileWidget('Store', '${snapshot.data![index].xtwh}, ${snapshot.data![index].xtypeobj}'),
                            _commonExpansionTileWidget('Purchase Type', '${snapshot.data![index].xtype}'),
                            _commonExpansionTileWidget('Request Status', '${snapshot.data![index].statusName}'),

                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent),
                              onPressed: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CashAdvDetailsNotifiScreen(
                                              reqNumber: snapshot
                                                  .data![index].xporeqnum.toString(),
                                              zid: widget.zid,
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              xstatusreq: snapshot
                                                  .data![index].xstatusreq.toString(),
                                            )));
                                debugPrint(result.toString());
                                if (result.toString() == "approval") {
                                  debugPrint("pressed");
                                  setState(() {
                                    snapshot.data!.removeAt(index);
                                  });
                                }
                              },
                              child: const Center(
                                  child: Text(
                                "Details",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
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
