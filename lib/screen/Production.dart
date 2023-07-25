import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/production/notification_page/inspection_approval_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import '../hr/notifications/approverNotification/screen/production/notification_page/bom_notification.dart';
import '../hr/notifications/approverNotification/screen/production/notification_page/sto_notification.dart';

class ProductionNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  String xposition;
  String xstaff;
  String zemail;
  String zid;
  String adminBOM;

  ProductionNotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
    this.adminBOM = '0',
  });

  @override
  _ProductionNotificationListState createState() =>
      _ProductionNotificationListState();
}

class _ProductionNotificationListState
    extends State<ProductionNotificationList> {
  String bomCount = "1";

  //late AbsentCountModel bomCount1;

  String inspCount = "1";

  //late LeaveandTourCountModel leaveandtouradmin_count1;

  String stoCount = "1";

  // late EarlyCountModel earlyemployee_count1;

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Production Notifications",
          style: GoogleFonts.bakbakOne(
            fontSize: 20,
            color: Color(0xff074974),
          ),
        ),
        actions: [
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (bomCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    bomCount,
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
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BOM_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "BOM Approval",
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
            ],
            if (inspCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    inspCount,
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
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InspectionApproval_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Inspection Approval",
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
            ],
            if (inspCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    stoCount,
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
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PendingSTOScreen(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "STO Approval",
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
            ],
          ],
        ),
      ),
    );
  }
}
