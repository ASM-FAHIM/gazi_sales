import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/sales_distribution/notification_pages/dc_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/deposit_notification.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/so_notification.dart';

class SalesDistribution extends StatefulWidget {
  String xposition;
  String zid;
  String zemail;
  String xstaff;

  SalesDistribution(
      {required this.xposition,
      required this.zid,
      required this.zemail,
      required this.xstaff,
      Key? key})
      : super(key: key);

  @override
  State<SalesDistribution> createState() => _SalesDistributionState();
}

class _SalesDistributionState extends State<SalesDistribution> {
  String soCount = "1";

  //late AbsentCountModel bomCount1;

  String dcCount = "1";

  String depositCount = "1";

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });
/*    http.Response responseAbsentCount = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/HR/Notification/smallAPI/totalabsent.php'),
        body: jsonEncode(<String, String>{
          "xposition": widget.xposition,
        }));
    absentemployee_count1 = absentCountModelFromJson(responseAbsentCount.body);
    absentemployee_count = absentemployee_count1.total.toString();
    print("Admin Absent Notification:" + responseAbsentCount.body);

    http.Response responseLeaveandTourCount = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/HR/Notification/smallAPI/totalleaveandtour.php'),
        body: jsonEncode(<String, String>{
          "xposition": widget.xposition,
        }));
    leaveandtouradmin_count1 =
        leaveandTourCountModelFromJson(responseLeaveandTourCount.body);
    leaveandtouradmin_count = leaveandtouradmin_count1.total.toString();
    print(
        "Admin Leave and Tour Notification:" + responseLeaveandTourCount.body);

    http.Response responseLateCount = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/HR/Notification/smallAPI/totallate.php'),
        body: jsonEncode(<String, String>{
          "xposition": widget.xposition,
        }));
    lateemployee_count1 = lateCountModelFromJson(responseLateCount.body);
    lateemployee_count = lateemployee_count1.total.toString();
    print("Admin Late Notification:" + responseLateCount.body);

    http.Response responseEarlyCount = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/HR/Notification/smallAPI/totalearly.php'),
        body: jsonEncode(<String, String>{
          "xposition": widget.xposition,
        }));
    earlyemployee_count1 = earlyCountModelFromJson(responseEarlyCount.body);
    earlyemployee_count = earlyemployee_count1.total.toString();
    print("Admin Early Notification:" + responseEarlyCount.body);*/

    setState(() {
      isLoading = false;
    });
    return '';
  }

  bool isLoadingAN = false;

  @override
  void initState() {
    super.initState();
    getAdminNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Color(0xff064A76),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Sales & Distribution",
          style: GoogleFonts.bakbakOne(
            fontSize: 20,
            color: Color(0xff074974),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Badge(
                position: BadgePosition.topEnd(end: 0),
                badgeContent: Text(
                  depositCount,
                  style: TextStyle(color: Colors.white),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width / 7.5,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SO_notification(
                                    xposition: widget.xposition,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                    xStaff: widget.xstaff,
                                  )));
                    },
                    child: Text(
                      "Sales Order",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Badge(
                position: BadgePosition.topEnd(end: 0),
                badgeContent: Text(
                  depositCount,
                  style: TextStyle(color: Colors.white),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width / 7.5,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepositNotifiScreen(
                                    xposition: widget.xposition,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                    xstaff: widget.xstaff,
                                  )));
                    },
                    child: Text(
                      "Deposit Notification",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Badge(
                position: BadgePosition.topEnd(end: 0),
                badgeContent: Text(
                  dcCount,
                  style: TextStyle(color: Colors.white),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width / 7.5,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DC_Notification(
                                    xposition: widget.xposition,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                    xstaff: widget.xstaff,
                                  )));
                    },
                    child: Text(
                      "DC Notification",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width / 8,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DealerVisitList(
                                  xposition: widget.xposition,
                                  zemail: widget.zemail,
                                  zid: widget.zid,
                                )));
                  },
                  child: Text(
                    "Daily visit list",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bakbakOne(
                      fontSize: 18,
                      color: Color(0xff064A76),
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
