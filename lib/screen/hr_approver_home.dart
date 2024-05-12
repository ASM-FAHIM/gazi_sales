import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/hr_approver/notification_pages/employee_clearance.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/hr_approver/notification_pages/employee_hrd_transfer.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/hr_approver/notification_pages/employee_settlement.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../data_model/notificaiton_count/admin_count.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';
import '../hr/notifications/approverNotification/screen/hr_approver/notification_pages/employee_requisition.dart';
import '../hr/notifications/approverNotification/screen/hr_approver/notification_pages/employee_short_leave.dart';
import '../sales/constant/app_constants.dart';
import '../sales/constant/colors.dart';
import '../hr/notifications/approverNotification/screen/hr_approver/notification_pages/absent_employee.dart';
import '../hr/notifications/approverNotification/screen/hr_approver/notification_pages/early_employee.dart';
import '../hr/notifications/approverNotification/screen/hr_approver/notification_pages/late_employee.dart';
import '../hr/notifications/approverNotification/screen/hr_approver/notification_pages/leave_tour_employee.dart';

class HrApproverHome extends StatefulWidget {
  HrApproverHome({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,

    // required this.adminearly,
    // required this.adminlate,
    // required this.adminleave,
    // required this.adminabsent,
  });

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  _HrApproverHomeState createState() => _HrApproverHomeState();
}

class _HrApproverHomeState extends State<HrApproverHome> {
  String absentemployee_count = "0";
  late AbsentCountModel absentemployee_count1;

  String leaveandtouradmin_count = "0";
  late LeaveandTourCountModel leaveandtouradmin_count1;

  String earlyemployee_count = "0";
  late EarlyCountModel earlyemployee_count1;

  String lateemployee_count = "0";
  late LateCountModel lateemployee_count1;

  String clearLCount = "0";
  String empReqCount = "0";
  String shortLeaveCount = "0";
  late ClEmpSlModel clEmpSlModel;


  String settleLCount = "0";

  String hrdTCount = "0";

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });
    http.Response responseAbsentCount = await http.post(
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
    print("Admin Early Notification:" + responseEarlyCount.body);



    http.Response responseclEmpSl = await http.get(
        Uri.parse(
            'http://${AppConstants.baseurl}/GAZI/notification/HR/adminHRCount.php?zid=${widget.zid}&xposition=${widget.xposition}'),);
    clEmpSlModel = clEmpSlModelFromJson(responseclEmpSl.body);

    // clearLCount = clEmpSlModel.clRcount.toString();
    empReqCount = clEmpSlModel.empReqCount.toString();
    shortLeaveCount = clEmpSlModel.slCount.toString();


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
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xff064A76),
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
        centerTitle: true,
        title: Text(
          "HR Notifications",
          style: GoogleFonts.bakbakOne(
            fontSize: 20,
            color: const Color(0xff074974),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading == true
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const CircularProgressIndicator(
                      color: AppColor.appBarColor,
                    ),
                  ),
                  const Text('Loading...')
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [

                  // if (lateemployee_count == '0')
                  //   ...[
                  //     // Center(child: const Text("No Data Available")),
                  //   ]
                  // else ...[
                  //   Padding(
                  //     padding:
                  //         const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  //     child: Badge(
                  //       label: Text(
                  //         lateemployee_count,
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.width / 7.5,
                  //         width: MediaQuery.of(context).size.width,
                  //         clipBehavior: Clip.hardEdge,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white70,
                  //           borderRadius: BorderRadius.circular(20),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 5,
                  //               offset: const Offset(
                  //                   0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: TextButton(
                  //           // shape: RoundedRectangleBorder(
                  //           //     borderRadius: BorderRadius.circular(20.0)),
                  //           onPressed: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     Admin_Late_Leave_NotificationList(
                  //                   xposition: widget.xposition,
                  //                   xstaff: widget.xstaff,
                  //                   zemail: widget.zemail,
                  //                   zid: widget.zid,
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //           child: Text(
                  //             "Late Employees",
                  //             textAlign: TextAlign.center,
                  //             style: GoogleFonts.bakbakOne(
                  //               fontSize: 18,
                  //               color: const Color(0xff064A76),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ],
                  // if (earlyemployee_count == '0')
                  //   ...[]
                  // else ...[
                  //   Padding(
                  //     padding:
                  //         const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  //     child: Badge(
                  //       label: Text(
                  //         earlyemployee_count,
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       child: Container(
                  //         height: MediaQuery.of(context).size.width / 7.5,
                  //         width: MediaQuery.of(context).size.width,
                  //         clipBehavior: Clip.hardEdge,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white70,
                  //           borderRadius: BorderRadius.circular(20),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 1,
                  //               blurRadius: 5,
                  //               offset: const Offset(
                  //                   0, 3), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: TextButton(
                  //           // shape: RoundedRectangleBorder(
                  //           //     borderRadius: BorderRadius.circular(20.0)),
                  //           onPressed: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         Admin_Early_Leave_NotificationList(
                  //                           xposition: widget.xposition,
                  //                           xstaff: widget.xstaff,
                  //                           zemail: widget.zemail,
                  //                           zid: widget.zid,
                  //                         )));
                  //           },
                  //           child: Text(
                  //             "Early Leave Employee",
                  //             textAlign: TextAlign.center,
                  //             style: GoogleFonts.bakbakOne(
                  //               fontSize: 18,
                  //               color: const Color(0xff064A76),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ],

                  if (leaveandtouradmin_count == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          leaveandtouradmin_count,
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
                                          Admin_Leave_Tour_NotificationList(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Leave & Tour for Approval",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (absentemployee_count == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          absentemployee_count,
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
                                          Admin_Absent_NotificationList(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Absent Employee",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (empReqCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          empReqCount,
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
                                      builder: (context) => EmpReqScreen(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Employee Requisition List",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (shortLeaveCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          shortLeaveCount,
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
                                      builder: (context) => ShortLeaveScreen(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Short Leave Approval",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (clearLCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          clearLCount,
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
                                      builder: (context) => ClearanceListScreen(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Clearance List Approval",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (settleLCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          settleLCount,
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
                                          SettlementListScreen(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Settlement List Approval",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (hrdTCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          hrdTCount,
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
                                      builder: (context) => HRDTransferScreen(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "HRD Transfer List",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            )),
    );
  }
}
