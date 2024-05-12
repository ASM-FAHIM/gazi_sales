import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../data_model/notificaiton_count/total_count_model.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/cash_adv_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/cs_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/po_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/padj_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/prn_notofication.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/spr_notification.dart';
import '../sales/constant/app_constants.dart';
import '../sales/constant/colors.dart';

class PurchaseNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  String xposition;
  String xstaff;
  String zemail;
  String zid;
  PurchaseNotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid

  });

  @override
  _PurchaseNotificationListState createState() =>
      _PurchaseNotificationListState();
}

class _PurchaseNotificationListState extends State<PurchaseNotificationList> {
  String poCount = '0';
  String csCount = '0';
  String sprCount = '0';
  String prnCount = '0';
  String cashAdvCount = '0';
  String padjCount = '0';

  int scmModel = 0;
  late ScmmOdel scmModel1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });

    var responseInv = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/notification/scm/total_scm.php?zid=${widget.zid}&xposition=${widget.xposition}'));
    //print('---------------${responseInv.body}');

    scmModel1 = scmmOdelFromJson(responseInv.body);
    poCount = scmModel1.poCount.toString();
    csCount = scmModel1.csCount.toString();
    sprCount = scmModel1.sprCount.toString();
    // prnCount = scmModel1.prnCount.toString();
    cashAdvCount = scmModel1.cashAdvCount.toString();
    padjCount = scmModel1.padjCount.toString();

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
          "Supply Chain Notifications",
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
                    if (poCount == '0')
                      ...[
                        // Center(child: const Text("No Data Available")),
                      ]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            poCount,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 8,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PO_WO_approval_NotificationList(
                                              xposition: widget.xposition,
                                              xstaff: widget.xstaff,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                            )));
                              },
                              child: Text(
                                "PO/WO For Approval",
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
                    //Fahim's edit
                    if (csCount == "0")
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            csCount,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 8,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CS_notification(
                                              xposition: widget.xposition,
                                              xstaff: widget.xstaff,
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
                      ),
                    ],

                    /*if (widget.adminCash == "0")
                ...[]
              else ...[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 8,
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
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cash_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Badge(
                        showBadge:
                            int.parse(widget.adminCash) == 0 ? false : true,
                        // padding: const EdgeInsets.only(
                        //     left: 5, top: 5, bottom: 5, right: 5),
                        badgeContent: StreamBuilder(
                          stream: _eventCash.stream,
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
                              "Cash Notifications",
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
              ],*/

                    if (padjCount == "0")
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            padjCount,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 8,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PADJ_notification(
                                              xposition: widget.xposition,
                                              xstaff: widget.xstaff,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                            )));
                              },
                              child: Text(
                                "PADJ Notifications",
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

                    if (cashAdvCount == "0")
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            cashAdvCount,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 8,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CashAdvNotifScreen(
                                              xposition: widget.xposition,
                                              xstaff: widget.xstaff,
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
                        ),
                      ),
                    ],

                    if (prnCount == "0")
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            prnCount,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 8,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PRN_notification(
                                              xposition: widget.xposition,
                                              xstaff: widget.xstaff,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                            )));
                              },
                              child: Text(
                                "PRN Notifications",
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

                    if (sprCount == "0")
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            sprCount,
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 8,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
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
                              child: Text(
                                "SPR Notifications",
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

                    /*if (widget.adminPAF == "0")
                ...[]
              else ...[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.width / 8,
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
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PAF_notification(
                                      xposition: widget.xposition,
                                      xstaff: widget.xstaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: Badge(
                        showBadge:
                            int.parse(widget.adminPAF) == 0 ? false : true,
                        // padding: const EdgeInsets.only(
                        //     left: 5, top: 5, bottom: 5, right: 5),
                        badgeContent: StreamBuilder(
                          stream: _eventPAF.stream,
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
                              "PAF Notifications",
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
              ],*/
                  ],
                ),
              ),
            ),
    );
  }
}
