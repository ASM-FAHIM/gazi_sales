import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/production/notification_page/bat_notification.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/production/notification_page/inspection_approval_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import '../data_model/notificaiton_count/total_count_model.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';
import '../hr/notifications/approverNotification/screen/production/notification_page/bom_notification.dart';
import '../hr/notifications/approverNotification/screen/inventory/notification_pages/sto_notification.dart';
import '../sales/constant/app_constants.dart';
import '../sales/constant/colors.dart';

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
  String bomCount = "0";

  String inspCount = "0";

  String batCount = "0";

  int productionCount = 0;
  late ProductionModel productionCount1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });
    var responseInv = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/notification/production/total_production.php?zid=${widget.zid}&xposition=${widget.xposition}'));
    //print('---------------${responseInv.body}');

    productionCount1 = productionModelFromJson(responseInv.body);
    bomCount = productionCount1.bomCount.toString();
    batCount = productionCount1.batchCOunt.toString();

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
          "Production Notifications",
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
                    if (bomCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          position: BadgePosition.topEnd(end: 0),
                          badgeContent: Text(
                            bomCount,
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
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
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
                              child: Text(
                                "BOM Approval",
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
                    if (inspCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          position: BadgePosition.topEnd(end: 0),
                          badgeContent: Text(
                            inspCount,
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
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
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
                              child: Text(
                                "Inspection Approval",
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
                    if (batCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          position: BadgePosition.topEnd(end: 0),
                          badgeContent: Text(
                            batCount,
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
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BAT_notification(
                                              xposition: widget.xposition,
                                              xstaff: widget.xstaff,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                            )));
                              },
                              child: Text(
                                "Pending BAT Approval",
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
            ),
    );
  }
}
