import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notifications/absent_information.dart';
import 'notifications/early_leave_information.dart';
import 'notifications/late_info_notification.dart';
import 'notifications/leave&tour_notification.dart';

class NotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  NotificationList({
    required this.xposition,
    required this.zid,
    required this.xstaff,
    // required this.earlyCount,
    // required this.leaveCount,
    // required this.lateCount,
    // required this.absentCount
  });

  String xposition;
  String zid;
  String xstaff;

  // String earlyCount;
  // String leaveCount;
  // String lateCount;
  // String absentCount;

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
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
              "Personal Notifications",
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
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Late_NotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Text(
                      "Late Information Details",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
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
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LeaveTour_NotificationList(
                                    xposition: widget.xposition,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Text(
                      "Leave&Tour Information Details",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
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
                                    zid: widget.zid,
                                  )));
                    },
                    child: Text(
                      "Early Leave Information Details",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
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
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Absent_NotificationList(
                                    xposition: widget.xposition,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Text(
                      "Absent Information Details",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
              ),
              /*if (widget.zid == "200010") ...[
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
                      child: Text(
                        "Late Information Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
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
                      child: Text(
                        "Leave&Tour Information Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
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
                      child: Text(
                        "Early Leave Information Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
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
                      child: Text(
                        "Absent Information Details",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          color: Color(0xff064A76),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else
                ...[]*/
            ],
          ),
        ));
  }
}
