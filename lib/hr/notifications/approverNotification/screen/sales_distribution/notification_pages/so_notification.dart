import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../conts_api_link.dart';
import '../../../../../../screen/SandD.dart';
import '../notification_models/so_admin_model.dart';
import '../../../../../../sales/constant/app_constants.dart';
import 'details/so_notification_details.dart';

class SO_notification extends StatefulWidget {
  SO_notification(
      {required this.xposition,
      required this.zemail,
      required this.zid,
      required this.xStaff});

  String xposition;
  String zemail;
  String zid;
  String xStaff;

  @override
  State<SO_notification> createState() => _SO_notificationState();
}

class _SO_notificationState extends State<SO_notification> {
  Future<List<SoModel>>? futurePost;
  String rejectNote = " ";
  AppConstants appConstants = AppConstants();

  Future<List<SoModel>> fetchPost() async {
    var response = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/Notification/sales/so/so.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition
        }));

    if (response.statusCode == 200) {
      print('body of so : ${response.body}');
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<SoModel>((json) => SoModel.fromJson(json)).toList();
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
                          xstaff: widget.xStaff,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Sales Order List",
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
              child: FutureBuilder<List<SoModel>>(
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
                                      "${snapshot.data![index].xsonumber}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    Text(
                                      "Prepared By : ${snapshot.data![index].tsoName ?? ""}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //color: Color(0xff074974),
                                      ),
                                    ),
                                    //_commonExpansionTileWidget('Date', '${snapshot.data![index].xdate}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          childrenPadding: const EdgeInsets.only(left: 10, right: 10),
                          children: <Widget>[
                            _commonExpansionTileWidget('Customer', '${snapshot.data![index].xcus}, ${snapshot.data![index].cusname}'),
                            _commonExpansionTileWidget('Store/Depot', '${snapshot.data![index].xfwh}, ${snapshot.data![index].xwhdesc}'),
                            _commonExpansionTileWidget('Reference', '${snapshot.data![index].xref}'),
                            _commonExpansionTileWidget('Incentive Applicable', '${snapshot.data![index].xopincapply}'),
                            _commonExpansionTileWidget('Product Nature', '${snapshot.data![index].xpnature}'),
                            _commonExpansionTileWidget('Discount Type', '${snapshot.data![index].xdisctype}'),
                            _commonExpansionTileWidget('Department', '${snapshot.data![index].xtsoname}'),
                            _commonExpansionTileWidget('Location', '${snapshot.data![index].location}'),
                            _commonExpansionTileWidget('Delivery Location', '${snapshot.data![index].xdeliloc}'),
                            _commonExpansionTileWidget('SO Status', '${snapshot.data![index].statusName}'),
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
                                            SO_details_notification(
                                              xsonumber: snapshot
                                                  .data![index].xsonumber.toString(),
                                              zid: widget.zid,
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              xstatustor: snapshot
                                                  .data![index].xstatus.toString(),
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
                    );
                  } else {
                    return Center(
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
            width: MediaQuery.of(context).size.width / 2.6,
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
