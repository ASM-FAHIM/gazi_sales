/*
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'notifications/absent_information.dart';
import 'notifications/early_leave_information.dart';
import 'notifications/late_info_notification.dart';
import 'notifications/leave&tour_notification.dart';

class NotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  NotificationList(
      {required this.xposition,
      required this.zid,
      */
/*required this.earlyCount,
      required this.leaveCount,
      required this.lateCount,
      required this.absentCount*//*

      });
  String xposition;
  String zid;
*/
/*  String earlyCount;
  String leaveCount;
  String lateCount;
  String absentCount;*//*


  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  late StreamController<int> _eventlate;


  @override
  void initState() {
    super.initState();
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
              "Notifications",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.zid == "200010") ...[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Late_NotificationList(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                    )));
                      },
                      child: Badge(
                        showBadge:
                            int.parse(widget.lateCount) == 0 ? false : true,
                        padding: EdgeInsets.only(
                            left: 5, top: 5, bottom: 5, right: 5),
                        badgeContent: StreamBuilder(
                          stream: _eventlate.stream,
                          builder: (BuildContext context, snapshot) {
                            return new Text("${snapshot.data}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        badgeColor: Color(0xff064A76),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Late Information Details",
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LeaveTour_NotificationList(
                                        xposition: widget.xposition)));
                      },
                      child: Badge(
                        showBadge:
                            int.parse(widget.leaveCount) == 0 ? false : true,
                        padding: EdgeInsets.only(
                            left: 5, top: 5, bottom: 5, right: 5),
                        badgeContent: StreamBuilder(
                          stream: _eventleave_tour.stream,
                          builder: (BuildContext context, snapshot) {
                            return new Text("${snapshot.data}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        badgeColor: Color(0xff064A76),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Leave&Tour Information Details",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bakbakOne(
                                  fontSize: 18,
                                  color: Color(0xff064A76),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("Working on progress",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Early_Leave_NotificationList(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                    )));
                      },
                      child: Badge(
                        showBadge:
                            int.parse(widget.earlyCount) == 0 ? false : true,
                        padding: EdgeInsets.only(
                            left: 5, top: 5, bottom: 5, right: 5),
                        badgeContent: StreamBuilder(
                          stream: _eventearly.stream,
                          builder: (BuildContext context, snapshot) {
                            return new Text("${snapshot.data}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        badgeColor: Color(0xff064A76),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Early Leave Information Details",
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Absent_NotificationList(
                                    xposition: widget.xposition)));
                      },
                      child: Badge(
                        showBadge:
                            int.parse(widget.absentCount) == 0 ? false : true,
                        padding: EdgeInsets.only(
                            left: 5, top: 5, bottom: 5, right: 5),
                        badgeContent: StreamBuilder(
                          stream: _eventabsent.stream,
                          builder: (BuildContext context, snapshot) {
                            return new Text("${snapshot.data}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        badgeColor: Color(0xff064A76),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Absent Information Details",
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
              ] else
                ...[]
            ],
          ),
        ));
  }
}
*/
