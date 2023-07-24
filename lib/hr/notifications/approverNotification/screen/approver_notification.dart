import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';
import 'inventory/notification_pages/grn_notification.dart';
import 'inventory/notification_pages/sqc_notification.dart';
import 'inventory/notification_pages/sr_notification.dart';
import 'inventory/notification_pages/damage_approval_notification.dart';
import 'inventory/notification_pages/lre_notification.dart';
import 'inventory/notification_pages/rr_notification.dart';
import 'inventory/notification_pages/to_notification.dart';

class AdminNotificationList extends StatefulWidget {
  String xposition;
  String xstaff;
  String zemail;
  String zid;

  AdminNotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
  });

  @override
  _AdminNotificationListState createState() => _AdminNotificationListState();
}

class _AdminNotificationListState extends State<AdminNotificationList> {
  String toCount = "1";

  //late AbsentCountModel toCount1;

  String astiCount = "1";

  //late LeaveandTourCountModel astiCount1;

  String damageCount = "1";

  // late EarlyCountModel damageCount1;

  String grnCount = "1";

  //late LateCountModel grnCount1;

  String lreCount = "1";

  //late AbsentCountModel lreCount1;

  String rrCount = "1";

  //late LeaveandTourCountModel rrCount1;

  String sqcCount = "1";

  // late EarlyCountModel sqcCount1;

  String srCount = "1";

  //late LateCountModel srCount1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });
    /*http.Response responseAbsentCount = await http.post(
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

  @override
  void initState() {
    super.initState();
    //getAdminNotificationCount();
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
          "Inventory Notifications",
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
            //Fahim's edit
            if (srCount == "0")
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    srCount,
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
                                builder: (context) => SR_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Sales Return Notifications",
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
            if (rrCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    rrCount,
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
                                builder: (context) => RR_Notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "RR Notifications",
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
            if (grnCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    grnCount,
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
                                builder: (context) => GRN_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "GRN Notifications",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            /*if (widget.adminSPR == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Container(
                  height: MediaQuery.of(context).size.width / 8,
                  width: MediaQuery.of(context).size.width,
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
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SPR_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminSPR) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventSPR.stream,
                        builder: (BuildContext context, snapshot) {
                          return Text(
                            "${snapshot.data}",
                            style: GoogleFonts.bakbakOne(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      //badgeColor: Color(0xff064A76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Store Purchase Requisition",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],*/
            /*if (widget.adminASTI == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Container(
                  height: MediaQuery.of(context).size.width / 8,
                  width: MediaQuery.of(context).size.width,
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
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ASTI_Notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge:
                          int.parse(widget.adminASTI) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventASTI.stream,
                        builder: (BuildContext context, snapshot) {
                          return Text(
                            "${snapshot.data}",
                            style: GoogleFonts.bakbakOne(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      //badgeColor: Color(0xff064A76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ASTI Notification",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],*/
            if (toCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    toCount,
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
                                builder: (context) => TO_Notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "TO Notification",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
            if (lreCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    lreCount,
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
                                builder: (context) => LRE_Notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "LRE Notification",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
            if (damageCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    damageCount,
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
                                    DamageApproval_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Damage Approval Notification",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
            /*if (widget.adminInspection == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Container(
                  height: MediaQuery.of(context).size.width / 8,
                  width: MediaQuery.of(context).size.width,
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
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
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
                    child: Badge(
                      showBadge:
                          int.parse(widget.adminInspection) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventInspection.stream,
                        builder: (BuildContext context, snapshot) {
                          return Text(
                            "${snapshot.data}",
                            style: GoogleFonts.bakbakOne(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      //badgeColor: Color(0xff064A76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Inspection Approval Notification",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],*/
            if (sqcCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    sqcCount,
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
                                builder: (context) => SQC_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "SQC Notification",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
