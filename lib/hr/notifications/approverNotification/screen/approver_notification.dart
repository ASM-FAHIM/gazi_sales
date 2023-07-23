import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import 'inventory/notification_pages/grn_notification.dart';
import 'supply_chain/notification_page/spr_notification.dart';
import 'inventory/notification_pages/sqc_notification.dart';
import 'inventory/notification_pages/sr_notification.dart';
import 'inventory/notification_pages/asti_notification.dart';
import 'inventory/notification_pages/damage_approval_notification.dart';
import 'inventory/notification_pages/lre_notification.dart';
import 'inventory/notification_pages/rr_notification.dart';
import 'inventory/notification_pages/to_notification.dart';

class AdminNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  //String adminSPR;
  String adminSR;
  String adminRR;
  String adminASTI;
  String adminTO;
  String adminLRE;
  String adminGRN;
  String adminSQC;

  //String adminInspection;
  String adminDamage;

  AdminNotificationList({
    this.xposition = '0',
    this.xstaff = '0',
    this.zemail = '0',
    this.zid = '0',
    this.adminSR = '0',
    this.adminGRN = '0',
    // this.adminSPR = '0',
    this.adminRR = '0',
    this.adminASTI = '0',
    this.adminTO = '0',
    this.adminLRE = '0',
    this.adminDamage = '0',
    //this.adminInspection = '0',
    this.adminSQC = '0',
  });

  @override
  _AdminNotificationListState createState() => _AdminNotificationListState();
}

class _AdminNotificationListState extends State<AdminNotificationList> {
  @override
/*  late StreamController<int> _eventPO;

  void _poCounter() {
    widget.adminPO;
    _eventPO.add(int.parse(widget.adminPO));
  }

  late StreamController<int> _eventCS;

  void _csCounter() {
    widget.adminCS;
    _eventCS.add(int.parse(widget.adminCS));
  }*/

  late StreamController<int> _eventSR;

  void _srCounter() {
    widget.adminSR;
    _eventSR.add(int.parse(widget.adminSR));
  }

  /*  late StreamController<int> _eventLA;

  void _laCounter() {
    widget.adminLA;
    _eventLA.add(int.parse(widget.adminLA));
  }

  late StreamController<int> _eventLFA;

  void _lfaCounter() {
    widget.adminLFA;
    _eventLFA.add(int.parse(widget.adminLFA));
  }*/

  //fahim's edit
  late StreamController<int> _eventGRN;

  void _grnCounter() {
    widget.adminGRN;
    _eventGRN.add(int.parse(widget.adminGRN));
    print('------${widget.adminGRN} ');
  }

  late StreamController<int> _eventSPR;

  /*void _sprCounter() {
    widget.adminSPR;
    _eventSPR.add(int.parse(widget.adminSPR));
    print('------${widget.adminSPR} ');
  }*/

  late StreamController<int> _eventRR;

  void _rrCounter() {
    widget.adminRR;
    _eventRR.add(int.parse(widget.adminRR));
    print('------${widget.adminRR} ');
  }

  late StreamController<int> _eventASTI;

  void _astiCounter() {
    widget.adminASTI;
    _eventASTI.add(int.parse(widget.adminASTI));
    print('------${widget.adminASTI} ');
  }

  late StreamController<int> _eventTO;

  void _toCounter() {
    widget.adminTO;
    _eventTO.add(int.parse(widget.adminTO));
    print('------${widget.adminTO} ');
  }

  late StreamController<int> _eventLRE;

  void _lreCounter() {
    widget.adminLRE;
    _eventLRE.add(int.parse(widget.adminLRE));
    print('------${widget.adminLRE} ');
  }

  late StreamController<int> _eventDamage;

  void _damageCounter() {
    widget.adminDamage;
    _eventDamage.add(int.parse(widget.adminDamage));
    print('------${widget.adminDamage} ');
  }

  late StreamController<int> _eventInspection;

  /*void _inspectionCounter() {
    widget.adminInspection;
    _eventInspection.add(int.parse(widget.adminInspection));
    print('------${widget.adminInspection} ');
  }*/

  late StreamController<int> _eventSQC;

  void _sqcCounter() {
    widget.adminSQC;
    _eventSQC.add(int.parse(widget.adminSQC));
    print('------${widget.adminSQC} ');
  }

  @override
  void initState() {
    super.initState();

/*    Timer.periodic(Duration(seconds: 1), (_) => _poCounter());
    _eventPO = new StreamController<int>();
    _eventPO.add(int.parse(widget.adminPO));

    Timer.periodic(Duration(seconds: 1), (_) => _csCounter());
    _eventCS = new StreamController<int>();
    _eventCS.add(int.parse(widget.adminCS));*/

    /*Timer.periodic(Duration(seconds: 1), (_) => _srCounter());
    _eventSR = new StreamController<int>();
    _eventSR.add(int.parse(widget.adminSR));*/

/*    Timer.periodic(Duration(seconds: 1), (_) => _laCounter());
    _eventLA = new StreamController<int>();
    _eventLA.add(int.parse(widget.adminLA));

    Timer.periodic(Duration(seconds: 1), (_) => _lfaCounter());
    _eventLFA = new StreamController<int>();
    _eventLFA.add(int.parse(widget.adminLFA));*/

    //fahim's edit
/*    Timer.periodic(Duration(seconds: 1), (_) => _grnCounter());
    _eventGRN = new StreamController<int>();
    _eventGRN.add(int.parse(widget.adminGRN));

    Timer.periodic(Duration(seconds: 1), (_) => _sprCounter());
    _eventSPR = new StreamController<int>();
    _eventSPR.add(int.parse(widget.adminSPR));

    Timer.periodic(Duration(seconds: 1), (_) => _rrCounter());
    _eventRR = new StreamController<int>();
    _eventRR.add(int.parse(widget.adminRR));

    Timer.periodic(Duration(seconds: 1), (_) => _astiCounter());
    _eventASTI = new StreamController<int>();
    _eventASTI.add(int.parse(widget.adminASTI));

    Timer.periodic(Duration(seconds: 1), (_) => _toCounter());
    _eventTO = new StreamController<int>();
    _eventTO.add(int.parse(widget.adminTO));

    Timer.periodic(Duration(seconds: 1), (_) => _lreCounter());
    _eventLRE = new StreamController<int>();
    _eventLRE.add(int.parse(widget.adminLRE));

    Timer.periodic(Duration(seconds: 1), (_) => _damageCounter());
    _eventDamage = new StreamController<int>();
    _eventDamage.add(int.parse(widget.adminDamage));

    Timer.periodic(Duration(seconds: 1), (_) => _inspectionCounter());
    _eventInspection = new StreamController<int>();
    _eventInspection.add(int.parse(widget.adminInspection));

    Timer.periodic(Duration(seconds: 1), (_) => _sqcCounter());
    _eventSQC = new StreamController<int>();
    _eventSQC.add(int.parse(widget.adminSQC));*/
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
            if (widget.adminSR == "0")
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
                              builder: (context) => SR_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminSR) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventSR.stream,
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
                            "Sales Return Notifications",
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
            if (widget.adminRR == '0')
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
                              builder: (context) => RR_Notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminRR) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventRR.stream,
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
                            "RR Notifications",
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
            if (widget.adminGRN == '0')
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
                              builder: (context) => GRN_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminGRN) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventGRN.stream,
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
            if (widget.adminTO == '0')
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
                              builder: (context) => TO_Notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminTO) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventTO.stream,
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
                            "TO Notification",
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
            ],
            if (widget.adminLRE == '0')
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
                              builder: (context) => LRE_Notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminLRE) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventLRE.stream,
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
                            "LRE Notification",
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
            ],
            if (widget.adminDamage == '0')
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
                              builder: (context) => DamageApproval_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge:
                          int.parse(widget.adminDamage) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventDamage.stream,
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
                            "Damage Approval Notification",
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
            if (widget.adminSQC == '0')
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
                              builder: (context) => SQC_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminSQC) == 0 ? false : true,
                      // padding: const EdgeInsets.only(
                      //     left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventSQC.stream,
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
                            "SQC Notification",
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
            ],
          ],
        ),
      ),
    );
  }
}
