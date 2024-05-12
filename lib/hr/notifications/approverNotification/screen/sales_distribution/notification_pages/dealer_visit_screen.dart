import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../../../data_model/notification_model/admin_approver_model/dealer_visit_list_model.dart';
import '../../../../../../sales/constant/app_constants.dart';
import '../../../../../../screen/SandD.dart';

class DailyVisitListScreen extends StatefulWidget {
  DailyVisitListScreen({
    required this.tsoId,
    required this.tsoName,
  });

  String tsoId;
  String tsoName;

  @override
  State<DailyVisitListScreen> createState() => _DailyVisitListScreenState();
}

class _DailyVisitListScreenState extends State<DailyVisitListScreen> {
  Future<List<DealerVisitListModel>>? futurePost;
  AppConstants appConstants = AppConstants();

  Future<List<DealerVisitListModel>> fetchPost() async {
    var response = await http.get(
      Uri.parse(
          "http://${AppConstants.baseurl}/salesforce/TSO_Daily_Visit.php?id=${widget.tsoId}"),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<DealerVisitListModel>(
              (json) => DealerVisitListModel.fromJson(json))
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
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => SalesDistribution(
            //           xposition: widget.xposition,
            //           zemail: widget.zemail,
            //           zid: widget.zid,
            //           xstaff: widget.xstaff,
            //         )));
          },
        ),
        title: Center(
          child: Text(
            "Dealer Visit List",
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
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<DealerVisitListModel>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 6.0),
                          child: ExpansionTile(
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data![index].tsoid,
                                                style: GoogleFonts.bakbakOne(
                                                  fontSize: 18,
                                                  //color: Color(0xff074974),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data![index].xdate,
                                                style: GoogleFonts.bakbakOne(
                                                  fontSize: 18,
                                                  //color: Color(0xff074974),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            snapshot.data![index].dealer,
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
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                "Intime: " + " ${snapshot.data![index].inTime}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "OutTime: " +
                                    " ${snapshot.data![index].outTime}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              Text(
                                "Location: " +
                                    " ${snapshot.data![index].location}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),
                              /*Text(
                                "Visit Date: " +
                                    " ${snapshot.data![index].xdate}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  //color: Color(0xff074974),
                                ),
                              ),*/
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 300,
                                width: 400,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'http://${AppConstants.baseurl}/salesforce/images/${snapshot.data![index].image}'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),
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
    );
  }
}
