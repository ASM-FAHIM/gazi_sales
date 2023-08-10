import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../data_model/notificaiton_count/total_count_model.dart';
import '../../../../sales/constant/app_constants.dart';
import '../../../../sales/constant/colors.dart';
import '../../../../screen/FinanaceAccounts.dart';
import '../../../../screen/Production.dart';
import '../../../../screen/SupplyChain.dart';
import '../../../../screen/SandD.dart';
import '../../../../widgets/ap_not_container.dart';
import '../../../../screen/hr_approver_home.dart';
import '../../../../screen/personal_notification.dart';
import 'approver_notification.dart';

class AdminNotification extends StatefulWidget {
  AdminNotification({
    required this.xposition,
    required this.zemail,
    required this.zid,
    required this.xStaff,
  });

  String xposition;
  String zemail;
  String zid;
  String xStaff;

  //LoginModel loginModel;

  @override
  _AdminNotificationState createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  String hrApproval = '0';
  String pHrApproval = '0';
  String invApproval = '0';
  String fAApproval = '0';
  String prApproval = '0';
  String sApproval = '0';
  String sCMApproval = '0';

  bool isLoading = false;
  int totalCount = 0;
  late TotalAdminCount totalCount1;

  Future<String> getAllnotificationTotalCount() async {
    setState(() {
      isLoading = true;
    });

    var responseInv = await http.post(
        Uri.parse(
            'http://${AppConstants.baseurl}/gazi/notification/totalAdminCount.php'),
        body: jsonEncode(<String, String>{
          "zid": widget.zid,
          "xposition": widget.xposition,
        }));
    //print('---------------${responseInv.body}');

    totalCount1 = totalAdminCountFromJson(responseInv.body);
    // hrApproval = totalCount1.poCount.toString();
    // pHrApproval = totalCount1.poCount.toString();
    invApproval = totalCount1.inventoryCount.toString();
    fAApproval = totalCount1.accountsCount.toString();
    prApproval = totalCount1.productionCount.toString();
    sApproval = totalCount1.salesCount.toString();
    sCMApproval = totalCount1.scmCount.toString();

    setState(() {
      isLoading = false;
    });
    return '';
  }

  bool isLoadingAN = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllnotificationTotalCount();
  }

  @override
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
        actions: const [
          SizedBox(
            width: 20,
          )
        ],
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
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.zid == '100000') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HrApproverHome(
                                            xposition: widget.xposition,
                                            xstaff: widget.xStaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: ReusableWidget(
                              circleColor: hrApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: hrApproval,
                              image: 'assets/images/management.png',
                              text: 'HCM Approval',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PersonalNotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xStaff,
                                    zid: widget.zid,
                                    zemail: widget.zemail,
                                    // earlyCount: earlyCount,
                                    // lateCount: lateCount,
                                    // leaveCount: leaveCount,
                                    // absentCount: absentCount,
                                    // user: widget.loginModel.zemail,
                                  ),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: pHrApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: pHrApproval,
                              image: 'assets/images/personal.png',
                              text: 'Personal',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminNotificationList(
                                      xposition: widget.xposition,
                                      xstaff: widget.xStaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: invApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: invApproval,
                              image: 'assets/images/inventory.png',
                              text: 'Inventory',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PurchaseNotificationList(
                                          xposition: widget.xposition,
                                          xstaff: widget.xStaff,
                                          zemail: widget.zemail,
                                          zid: widget.zid),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: sCMApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: sCMApproval,
                              image: 'assets/images/folder.png',
                              text: 'Supply chain',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FinanceAccountNotificationList(
                                          xposition: widget.xposition,
                                          xstaff: widget.xStaff,
                                          zemail: widget.zemail,
                                          zid: widget.zid),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: fAApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: fAApproval,
                              image: 'assets/images/procurement.png',
                              text: 'Finance',
                              textS: '& Accounts',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductionNotificationList(
                                          xposition: widget.xposition,
                                          xstaff: widget.xStaff,
                                          zemail: widget.zemail,
                                          zid: widget.zid),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: prApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: prApproval,
                              image: 'assets/images/production.png',
                              text: 'Production',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SalesDistribution(
                                            xposition: widget.xposition,
                                            xstaff: widget.xStaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: ReusableWidget(
                              circleColor: sApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: sApproval,
                              image: 'assets/images/money (1).png',
                              text: 'Sales',
                              textS: '& Distribution',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminNotificationList(
                                      xposition: widget.xposition,
                                      xstaff: widget.xStaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: invApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: invApproval,
                              image: 'assets/images/inventory.png',
                              text: 'Inventory',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PurchaseNotificationList(
                                          xposition: widget.xposition,
                                          xstaff: widget.xStaff,
                                          zemail: widget.zemail,
                                          zid: widget.zid),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: sCMApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: sCMApproval,
                              image: 'assets/images/folder.png',
                              text: 'Supply chain',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FinanceAccountNotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xStaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                    //adminVoucher: VoucherCount,
                                  ),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: fAApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: fAApproval,
                              image: 'assets/images/procurement.png',
                              text: 'Finance',
                              textS: '& Accounts',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductionNotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xStaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                    //adminBOM: BOMCount,
                                  ),
                                ),
                              );
                            },
                            child: ReusableWidget(
                              circleColor: prApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: prApproval,
                              image: 'assets/images/production.png',
                              text: 'Production',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SalesDistribution(
                                            xposition: widget.xposition,
                                            xstaff: widget.xStaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: ReusableWidget(
                              circleColor: sApproval == '0'
                                  ? Colors.transparent
                                  : Colors.red,
                              badgeText: sApproval,
                              image: 'assets/images/money (1).png',
                              text: 'Sales',
                              textS: '& Distribution',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]
                    /*if (widget.zid == '100000') ...[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              //print('Employee HR Approval pressed');
                              setState(() {
                                isLoadingHR = true;
                              });

                              Future.delayed(
                                Duration(seconds: 1),
                                () {
                                  setState(() {
                                    isLoadingHR = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HrApproverHome(
                                                xposition: widget.xposition,
                                                xstaff: widget.xStaff,
                                                zemail: widget.zemail,
                                                zid: widget.zid,
                                              )));
                                },
                              );
                            },
                            child: totalCount == 0
                                ? Text(
                                    "Employee HR Approval",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.bakbakOne(
                                      fontSize: 18,
                                      color: Color(0xff064A76),
                                    ),
                                  )
                                : Badge(
                                    position: BadgePosition.topEnd(end: -30),
                                    badgeContent: Text(
                                      '$totalCount',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    child: Text(
                                      "Employee HR Approval",
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
                    ] else
                      ...[],
                    if (widget.zid == '100000') ...[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                                    Offset(0, 3), // changes position of shadow
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
                                  builder: (context) => NotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xStaff,
                                    zid: widget.zid,
                                    // earlyCount: earlyCount,
                                    // lateCount: lateCount,
                                    // leaveCount: leaveCount,
                                    // absentCount: absentCount,
                                    // user: widget.loginModel.zemail,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Personal notifications",
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
                      ...[],*/
                    /*Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                                        PO_WO_approval_NotificationList(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                          },
                          child: Text(
                            "PO/WO Notifications",
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
                                    builder: (context) => CS_notification(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                          },
                          child: Text(
                            "CS Notifications",
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
                                    builder: (context) => SR_notification(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                          xstaff: widget.xStaff,
                                        )));
                          },
                          child: Text(
                            "SR Notifications",
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
                                    builder: (context) => Pending_voucher(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                          },
                          child: Text(
                            "Voucher Notifications",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    /*Padding(
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
                              builder: (context) => CashAdvNotifScreen(
                                    xposition: widget.xposition,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Text(
                      "Cash adv Notifications",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
            ),*/
                    /*Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                                    builder: (context) => CashAdvNotifScreen(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                          },
                          child: Text(
                            "Cash Adv. Notifications",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.width / 8,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white70,
                    //       borderRadius: BorderRadius.circular(20),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.5),
                    //           spreadRadius: 1,
                    //           blurRadius: 5,
                    //           offset: Offset(0, 3), // changes position of shadow
                    //         ),
                    //       ],
                    //     ),
                    //     child: TextButton(
                    //       style: TextButton.styleFrom(
                    //           backgroundColor: Colors.white
                    //       ),
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => Cash_notification(
                    //                   xposition: widget.xposition,
                    //                   zemail: widget.zemail,
                    //                   zid: widget.zid,
                    //                 )));
                    //       },
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "Cash Notifications",
                    //             textAlign: TextAlign.center,
                    //             style: GoogleFonts.bakbakOne(
                    //               fontSize: 18,
                    //               color: Color(0xff064A76),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    /*Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                                    builder: (context) => SO_notification(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                          xStaff: widget.xStaff,
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                                    builder: (context) => DepositNotifiScreen(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
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
                    ),*/
                    /*Padding(
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
                              builder: (context) => DealerVisitList(
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
            ),
    );
  }
}
