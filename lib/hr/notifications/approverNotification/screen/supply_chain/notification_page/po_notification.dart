import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../conts_api_link.dart';
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/SupplyChain.dart';
import '../notification_model/po_wo_admin_model.dart';
import 'details_page/po_details.dart';

class PO_WO_approval_NotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  PO_WO_approval_NotificationList(
      {required this.xposition,
      required this.xstaff,
      required this.zemail,
      required this.zid});

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  _PO_WO_approval_NotificationListState createState() =>
      _PO_WO_approval_NotificationListState();
}

class _PO_WO_approval_NotificationListState
    extends State<PO_WO_approval_NotificationList> {
  @override
  String rejectNote = " ";
  List<PoAdminModel>? dataLength;
  Future<List<PoAdminModel>>? futurePost;

  Future<List<PoAdminModel>> fetchPost() async {
    var response = await http.post(
      Uri.parse(
          'http://${AppConstants.baseurl}/GAZI/Notification/scm/po_wo/PO_notification.php'),
      body: jsonEncode(
        <String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        },
      ),
    );
    print(ConstApiLink().poWoApi);
    print(response.body);
    if (response.statusCode == 200) {
      dataLength = poAdminModelFromJson(response.body);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<PoAdminModel>((json) => PoAdminModel.fromJson(json))
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
                    builder: (context) => PurchaseNotificationList(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          zid: widget.zid,
                          xstaff: widget.xstaff,
                        )));
          },
        ),
        centerTitle: true,
        title: Text(
          "Pending PO/WO Approval",
          style: GoogleFonts.bakbakOne(
            fontSize: 20,
            color: const Color(0xff074974),
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
              child: FutureBuilder<List<PoAdminModel>>(
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
                                      "${snapshot.data![index].xpornum}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Prepared By : ${snapshot.data![index].prepname ?? ""}",
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
                            _commonExpansionTileWidget('Purchase Date', '${snapshot.data![index].xdate}'),
                            _commonExpansionTileWidget('Supplier', '${snapshot.data![index].xcus}, ${snapshot.data![index].cusdesc}'),
                            _commonExpansionTileWidget('Location', '${snapshot.data![index].xwh}, ${snapshot.data![index].xwhdesc}'),
                            _commonExpansionTileWidget('Purchase Type', '${snapshot.data![index].xtype}'),
                            _commonExpansionTileWidget('PO Value', '${snapshot.data![index].povalue}'),
                            _commonExpansionTileWidget('Remarks', '${snapshot.data![index].xrem}'),
                            _commonExpansionTileWidget('Approval Status', '${snapshot.data![index].statusName}'),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.grey,
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
                                            PO_details_notification(
                                              xpornum: snapshot
                                                  .data![index].xpornum.toString(),
                                              zid: widget.zid,
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              xstatus: snapshot
                                                  .data![index].xstatus.toString(),
                                              xstaff: widget.xstaff,
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
