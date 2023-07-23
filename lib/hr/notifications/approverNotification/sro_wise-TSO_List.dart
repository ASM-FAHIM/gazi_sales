import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/sales_distribution/dealer_visit_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../data_model/notification_model/srowise_tso_visitList_model.dart';
import '../../../sales/constant/app_constants.dart';

class DealerVisitList extends StatefulWidget {
  DealerVisitList({
    required this.xposition,
    required this.zemail,
    required this.zid,
  });

  String xposition;
  String zemail;
  String zid;

  @override
  State<DealerVisitList> createState() => _DealerVisitListState();
}

class _DealerVisitListState extends State<DealerVisitList> {
  Future<List<SroWiseTsoVisitList>>? futurePost;
  AppConstants appConstants = AppConstants();

  /*Future<List<DealerVisitListModel>> fetchPost() async {
    var response = await http.get(Uri.parse("http://${AppConstants.baseurl}/salesforce/TSO_Daily_Visit.php?id=${widget.xposition}"),);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<DealerVisitListModel>((json) => DealerVisitListModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }*/
  Future<List<SroWiseTsoVisitList>> fetchTSOList() async {
    var response = await http.get(
      Uri.parse(
          "http://${AppConstants.baseurl}/salesforce/TSO_DailyVisitID.php?id=${widget.xposition}"),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<SroWiseTsoVisitList>(
              (json) => SroWiseTsoVisitList.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePost = fetchTSOList();
    fetchTSOList().whenComplete(() => futurePost);
  }

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
            "Daily visit(${DateFormat.yMMMMd().format(DateTime.now())})",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: Color(0xff074974),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<SroWiseTsoVisitList>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyVisitListScreen(
                                  tsoId: snapshot.data![index].tsoid,
                                  tsoName: snapshot.data![index].name)));
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data![index].name,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 16,
                                    //color: Color(0xff074974),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              snapshot.data![index].tsoid,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 14,
                                //color: Color(0xff074974),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
