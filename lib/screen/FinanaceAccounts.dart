import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/finance_accounts/Notification_page/bill_notification.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/finance_accounts/Notification_page/do_notification.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/finance_accounts/Notification_page/iou_notification.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/finance_accounts/Notification_page/pending_voucher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';
import '../hr/notifications/approverNotification/screen/finance_accounts/Notification_page/pending_mr_notification.dart';
import '../hr/notifications/approverNotification/screen/finance_accounts/Notification_page/petty_notification.dart';
import '../hr/notifications/approverNotification/screen/finance_accounts/Notification_page/supplier_payment_notification.dart';

class FinanceAccountNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  FinanceAccountNotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
  });

  @override
  _FinanceAccountNotificationListState createState() =>
      _FinanceAccountNotificationListState();
}

class _FinanceAccountNotificationListState
    extends State<FinanceAccountNotificationList> {
  String billCount = "1";

  //late AbsentCountModel absentemployee_count1;

  String doCount = "1";

  //late LeaveandTourCountModel leaveandtouradmin_count1;

  String voucherCount = "1";

  String mrCount = "1";

  String pmCount = "1";

  String iouCount = "1";

  String ptCashCount = "1";

  //late EarlyCountModel earlyemployee_count1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });

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
          "Accounts Notifications",
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
            if (billCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    billCount,
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
                                builder: (context) => BillNotificationScreen(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Pending Bill Approval",
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
            if (doCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    doCount,
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
                                builder: (context) => DO_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Pending Do Approval",
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
            if (voucherCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    voucherCount,
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
                                builder: (context) => Pending_voucher(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Pending voucher Approval",
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
            if (mrCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    mrCount,
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
                                builder: (context) => MRNotificationScreen(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Pending MR Approval",
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
            if (pmCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    pmCount,
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
                                    SupplierPMNotificationScreen(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Supplier Payment Approval",
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
            if (iouCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    iouCount,
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
                                builder: (context) => IOUNotificationScreen(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Supplier IOU Approval",
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
            if (ptCashCount == '0')
              ...[]
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Badge(
                  position: BadgePosition.topEnd(end: 0),
                  badgeContent: Text(
                    ptCashCount,
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
                                builder: (context) => PettyNotificationScreen(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Text(
                        "Pending Petty Cash Approval",
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
