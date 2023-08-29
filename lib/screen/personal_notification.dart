import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data_model/notificaiton_count/admin_count.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';
import '../hr/notifications/approverNotification/screen/personal/notification_pages/absent_information.dart';
import '../hr/notifications/approverNotification/screen/personal/notification_pages/early_leave_information.dart';
import '../hr/notifications/approverNotification/screen/personal/notification_pages/late_info_notification.dart';
import '../hr/notifications/approverNotification/screen/personal/notification_pages/leave&tour_notification.dart';
import 'package:http/http.dart' as http;

class PersonalNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  PersonalNotificationList({
    required this.xposition,
    required this.zid,
    required this.xstaff,
    required this.zemail,
    // required this.earlyCount,
    // required this.leaveCount,
    // required this.lateCount,
    // required this.absentCount
  });

  String xposition;
  String zid;
  String xstaff;
  String zemail;

  // String earlyCount;
  // String leaveCount;
  // String lateCount;
  // String absentCount;

  @override
  _PersonalNotificationListState createState() =>
      _PersonalNotificationListState();
}

class _PersonalNotificationListState extends State<PersonalNotificationList> {
  String pAbsCount = "0";
  late AbsentCountModel absentemployee_count1;

  String pLeaveCount = "0";
  late LeaveandTourCountModel leaveandtouradmin_count1;

  String pEarlyCount = "0";
  late EarlyCountModel earlyemployee_count1;

  String pLateCount = "0";
  late LateCountModel lateemployee_count1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });

    // var responseInv = await http.post(
    //     Uri.parse(
    //         'http://${AppConstants.baseurl}/gazi/notification/accounts/total_count_accounts.php'),
    //     body: jsonEncode(<String, dynamic>{
    //       "zid": widget.zid,
    //       "xposition": widget.xposition
    //     }));
    // print('---------------${responseInv.body}');

    /*InventoryCount1 = inventoryCountModelFromJson(responseInv.body);
    pAbsCount = InventoryCount1.srCount.toInt();
    pLeaveCount = InventoryCount1.rrCount.toInt();
    pLateCount = InventoryCount1.astiCount.toInt();
    pLateCount = InventoryCount1.toCount.toInt();*/

    setState(() {
      isLoading = false;
    });
    return '';
  }

  bool isLoadingAN = false;
  bool isLoadingHR = false;

  @override
  void initState() {
    super.initState();
    getAdminNotificationCount();
    print(widget.zid);
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
                      builder: (context) => AdminNotification(
                            xposition: widget.xposition,
                            zemail: widget.zemail,
                            xStaff: widget.xstaff,
                            zid: widget.zid,
                          )));
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                if (pLateCount == '0')
                  ...[]
                else ...[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Badge(
                      label: Text(
                        pLateCount,
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                  ),
                ],
                if (pLeaveCount == '0')
                  ...[]
                else ...[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Badge(
                      label: Text(
                        pLeaveCount,
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                  ),
                ],
                if (pEarlyCount == '0')
                  ...[]
                else ...[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Badge(
                      label: Text(
                        pEarlyCount,
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                  ),
                ],
                if (pAbsCount == '0')
                  ...[]
                else ...[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Badge(
                      label: Text(
                        pAbsCount,
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                                        Absent_NotificationList(
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
                  ),
                ],
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
          ),
        ));
  }
}
