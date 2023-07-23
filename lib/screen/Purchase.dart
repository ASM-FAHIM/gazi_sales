import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/cs_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/po_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/padj_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/paf_notification.dart';
import '../hr/notifications/approverNotification/screen/supply_chain/notification_page/pr_cash_notification.dart';

class PurchaseNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  String xposition;
  String xstaff;
  String zemail;
  String zid;
  String adminPO;
  String adminCS;
  String adminCash;
  String adminPADJ;
  String adminPAF;

  PurchaseNotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
    this.adminPO = '0',
    this.adminCS = '0',
    this.adminCash = '0',
    this.adminPADJ = '0',
    this.adminPAF = '0',
  });

  @override
  _PurchaseNotificationListState createState() =>
      _PurchaseNotificationListState();
}

class _PurchaseNotificationListState extends State<PurchaseNotificationList> {
  @override
  late StreamController<int> _eventPO;

  void _poCounter() {
    widget.adminPO;
    _eventPO.add(int.parse(widget.adminPO));
  }

  late StreamController<int> _eventCS;

  void _csCounter() {
    widget.adminCS;
    _eventCS.add(int.parse(widget.adminCS));
  }

  late StreamController<int> _eventCash;

  void _cashCounter() {
    widget.adminCash;
    _eventCash.add(int.parse(widget.adminCash));
  }

  late StreamController<int> _eventPADJ;

  void _padjCounter() {
    widget.adminPADJ;
    _eventPADJ.add(int.parse(widget.adminPADJ));
  }

  late StreamController<int> _eventPAF;

  void _pafCounter() {
    widget.adminPAF;
    _eventPAF.add(int.parse(widget.adminPAF));
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (_) => _poCounter());
    _eventPO = new StreamController<int>();
    _eventPO.add(int.parse(widget.adminPO));

    Timer.periodic(Duration(seconds: 1), (_) => _csCounter());
    _eventCS = new StreamController<int>();
    _eventCS.add(int.parse(widget.adminCS));

    Timer.periodic(Duration(seconds: 1), (_) => _cashCounter());
    _eventCash = new StreamController<int>();
    _eventCash.add(int.parse(widget.adminCash));

    Timer.periodic(Duration(seconds: 1), (_) => _padjCounter());
    _eventPADJ = new StreamController<int>();
    _eventPADJ.add(int.parse(widget.adminPADJ));

    Timer.periodic(Duration(seconds: 1), (_) => _pafCounter());
    _eventPAF = new StreamController<int>();
    _eventPAF.add(int.parse(widget.adminPAF));
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
          "Purchase Notifications",
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
            ///PO/WO need to replace
            if (widget.adminPO == '0')
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
                                  PO_WO_approval_NotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminPO) == 0 ? false : true,
                      // padding:
                      //     EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventPO.stream,
                        builder: (BuildContext context, snapshot) {
                          return new Text(
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
                            "PO/WO For Approval",
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
            //Fahim's edit
            if (widget.adminCS == "0")
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
                              builder: (context) => CS_notification(
                                    xposition: widget.xposition,
                                    //xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminCS) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventCS.stream,
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
                      // badgeColor: Color(0xff064A76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "CS Notifications",
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

            if (widget.adminCash == "0")
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
            ],

            if (widget.adminPADJ == "0")
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
                              builder: (context) => PADJ_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge:
                          int.parse(widget.adminPADJ) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventPADJ.stream,
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
                            "PADJ Notifications",
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

            if (widget.adminPAF == "0")
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
                              builder: (context) => PAF_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminPAF) == 0 ? false : true,
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
            ],
          ],
        ),
      ),
    );
  }
}
