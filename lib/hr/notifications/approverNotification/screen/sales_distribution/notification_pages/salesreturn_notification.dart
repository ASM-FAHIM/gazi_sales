import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/screen/SandD.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:gazi_sales_app/sales/constant/app_constants.dart';

import '../../../../../../data_model/notificaiton_count/admin_count.dart';
import '../notification_models/salesreturn_admin_model.dart';
import 'details/salesreturn_details.dart';

class PSRA_notification extends StatefulWidget {
  PSRA_notification(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<PSRA_notification> createState() => _PSRA_notificationState();
}

class _PSRA_notificationState extends State<PSRA_notification> {
  Future<List<SalesReturnNoticationModel>>? futurePost;
  String rejectNote = " ";

  Future<List<SalesReturnNoticationModel>> fetchPost() async {
    var response = await http.post(Uri.parse('http://${AppConstants.baseurl}/gazi/notification/sales/sr/sr.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<SalesReturnNoticationModel>(
              (json) => SalesReturnNoticationModel.fromJson(json))
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
          icon: Icon(Icons.arrow_back),
          color: Color(0xff064A76),
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
            "Sales Return Notification",
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
              child: FutureBuilder<List<SalesReturnNoticationModel>>(
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
                                      "${snapshot.data![index].xcrnnum}",
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
                                    Text(
                                      "${snapshot.data![index].preparerXdeptname}",
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
                          childrenPadding: const EdgeInsets.only(left: 10, right: 10),
                          children: <Widget>[
                            _commonExpansionTileWidget('Invoice No: ', '${snapshot.data![index].xordernum}'),
                            _commonExpansionTileWidget('Date', '${snapshot.data![index].xdate}'),
                            _commonExpansionTileWidget('Reason: ', '${snapshot.data![index].xref}'),
                            _commonExpansionTileWidget('Customer', '${snapshot.data![index].xcus}, ${snapshot.data![index].xorg}'),
                            _commonExpansionTileWidget('Depo/Store', '${snapshot.data![index].xwh}, ${snapshot.data![index].xwhdesc}'),
                            _commonExpansionTileWidget('Executive ', '${snapshot.data![index].executive}'),
                            _commonExpansionTileWidget('ZM', '${snapshot.data![index].zm}'),
                            _commonExpansionTileWidget('DSM', '${snapshot.data![index].dsm}'),
                            _commonExpansionTileWidget('Base', '${snapshot.data![index].base}'),
                            _commonExpansionTileWidget('Zone', '${snapshot.data![index].zone}'),
                            _commonExpansionTileWidget('Division', '${snapshot.data![index].division}'),
                            _commonExpansionTileWidget('Total Amount', '${snapshot.data![index].xtotamt}'),
                            _commonExpansionTileWidget('Sales Return Status', '${snapshot.data![index].statuscrn}'),
                            _commonExpansionTileWidget('Approval Status', '${snapshot.data![index].status}'),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                    //     String xcrnnum;
                                    // String zid;
                                    // String xposition;
                                    // String xstatus;
                                    //   String xstaff;
                                    //   String zemail;
                                            SalesReturnDetailsScreen(
                                              xcrnnum: snapshot
                                                  .data![index].xcrnnum,
                                              zid: widget.zid,
                                              xposition: widget.xposition,
                                              xstatus: snapshot
                                                  .data![index].xstatus,
                                              xstaff: widget.xstaff,
                                              zemail: widget.zemail,
                                            )));
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
