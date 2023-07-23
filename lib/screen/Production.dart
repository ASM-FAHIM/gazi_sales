import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import '../hr/notifications/approverNotification/screen/production/notification_page/bom_notification.dart';

class ProductionNotificationList extends StatefulWidget {
  //const NotificationList({Key? key}) : super(key: key);

  String xposition;
  String xstaff;
  String zemail;
  String zid;
  String adminBOM;

  ProductionNotificationList({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
    this.adminBOM = '0',
  });

  @override
  _ProductionNotificationListState createState() =>
      _ProductionNotificationListState();
}

class _ProductionNotificationListState
    extends State<ProductionNotificationList> {
  @override
  late StreamController<int> _eventBOM;

  void _BOMCounter() {
    widget.adminBOM;
    _eventBOM.add(int.parse(widget.adminBOM));
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (_) => _BOMCounter());
    _eventBOM = new StreamController<int>();
    _eventBOM.add(int.parse(widget.adminBOM));
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
            if (widget.adminBOM == '0')
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
                              builder: (context) => BOM_notification(
                                    xposition: widget.xposition,
                                    xstaff: widget.xstaff,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Badge(
                      showBadge: int.parse(widget.adminBOM) == 0 ? false : true,
                      // padding:
                      //     EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
                      badgeContent: StreamBuilder(
                        stream: _eventBOM.stream,
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
                      // badgeColor: Color(0xff064A76),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "BOM Approval",
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
