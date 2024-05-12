import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/production/notification_model/bat_model.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../screen/Production.dart';
import 'details_page/bat_notification_details.dart';

class BAT_notification extends StatefulWidget {
  BAT_notification(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<BAT_notification> createState() => _BAT_notificationState();
}

class _BAT_notificationState extends State<BAT_notification> {
  Future<List<BatAdminModel>>? futurePost;
  String rejectNote = " ";

  Future<List<BatAdminModel>> fetchPost() async {
    var response = await http.post(
      Uri.parse(
          'http://${AppConstants.baseurl}/gazi/notification/production/batch/batch.php'),
      body: jsonEncode(
        <String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        },
      ),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<BatAdminModel>((json) => BatAdminModel.fromJson(json))
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
            "Pending Batch Notification",
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
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<BatAdminModel>>(
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
                                      "${snapshot.data![index].xbatch}",
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
                            _commonExpansionTileWidget('Finished Product', '${snapshot.data![index].xitem}, ${snapshot.data![index].xitemdesc}'),
                            _commonExpansionTileWidget('BOM Info', '${snapshot.data![index].xbomkey}, ${snapshot.data![index].xbomdesc}'),
                            _commonExpansionTileWidget('RM Store', '${snapshot.data![index].xwhcompdesc}'),
                            _commonExpansionTileWidget('Production Qty', '${snapshot.data![index].xqtyprd}'),
                            _commonExpansionTileWidget('Receiving Store', '${snapshot.data![index].xwhdesc}'),
                            _commonExpansionTileWidget('Machine', '${snapshot.data![index].xmachinenodesc}, ${snapshot.data![index].xmoprcsdesc}'),
                            _commonExpansionTileWidget('Arm No. ', '${snapshot.data![index].xarmno}'),
                            _commonExpansionTileWidget('Operator', '${snapshot.data![index].xrefstaff}, ${snapshot.data![index].xrefstaffdesc}'),
                            _commonExpansionTileWidget('Shift', '${snapshot.data![index].xshiftdesc}'),
                            _commonExpansionTileWidget('No of Worker', '${snapshot.data![index].xnoworker}'),
                            _commonExpansionTileWidget('Shift Engineer', '${snapshot.data![index].xshiftengr}, ${snapshot.data![index].xshiftengrdesc}'),
                            _commonExpansionTileWidget('Reject Qty', '${snapshot.data![index].xwastqty}'),
                            _commonExpansionTileWidget('Reject Store', '${snapshot.data![index].xwhwastdesc}'),
                            _commonExpansionTileWidget('Shift Engineer', '${snapshot.data![index].xshiftengr}, ${snapshot.data![index].xshiftengrdesc}'),
                            _commonExpansionTileWidget('Reject Item', '${snapshot.data![index].xwastitem}, ${snapshot.data![index].xwastitemdesc}'),
                            _commonExpansionTileWidget('Note', '${snapshot.data![index].xwastitem}, ${snapshot.data![index].xlong}'),
                            _commonExpansionTileWidget('Production Status', '${snapshot.data![index].descxstatusmor}'),
                            _commonExpansionTileWidget('Approval Status', '${snapshot.data![index].descxstatus}'),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 3,
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
                                    MediaQuery.of(context).size.width / 2.2,
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
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              // color: Colors.lightBlueAccent,
                              onPressed: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BAT_details_notification(
                                              xbatch:
                                                  '${snapshot.data![index].xbatch}',
                                              zid: widget.zid,
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              xstatus:
                                                  '${snapshot.data![index].xstatus}',
                                              xstaff: widget.xstaff,
                                              xqtyprd:
                                                  '${snapshot.data![index].xqtyprd}',
                                              xwastqty:
                                                  '${snapshot.data![index].xwastqty}',
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
            width: MediaQuery.of(context).size.width / 2.31,
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
