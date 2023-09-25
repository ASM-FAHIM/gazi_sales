import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/inventory/notification_pages/depo_dc_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../data_model/notificaiton_count/total_count_model.dart';
import '../../../../sales/constant/app_constants.dart';
import '../../../../sales/constant/colors.dart';
import 'approver.dart';
import 'inventory/notification_pages/grn_notification.dart';
import 'inventory/notification_pages/sqc_notification.dart';
import 'inventory/notification_pages/sr_notification.dart';
import 'inventory/notification_pages/damage_approval_notification.dart';
import 'inventory/notification_pages/rr_notification.dart';
import 'inventory/notification_pages/sto_notification.dart';
import 'inventory/notification_pages/to_notification.dart';

class AdminNotificationList extends StatefulWidget {
  final String xposition;
  final String xstaff;
  final String zemail;
  final String zid;

  const AdminNotificationList({
    super.key,
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
  });

  @override
  _AdminNotificationListState createState() => _AdminNotificationListState();
}

class _AdminNotificationListState extends State<AdminNotificationList> {
  String toCount = "0";

  String astiCount = "0";

  String damageCount = "0";

  String grnCount = "0";

  //String lreCount = "0";

  String rrCount = "0";

  String sqcCount = "0";

  String srCount = "0";

  String stoCount = "0";

  String depoDcCount = "0";

  int inventory = 0;
  late InventoryModel inventory1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });
    var responseInv = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/notification/inventory/total_inventory.php?zid=${widget.zid}&xposition=${widget.xposition}'));
    //print('---------------${responseInv.body}');
    inventory1 = inventoryModelFromJson(responseInv.body);
    toCount = inventory1.toCount.toString();
    stoCount = inventory1.stoCount.toString();
    damageCount = inventory1.damageCount.toString();
    grnCount = inventory1.grnCount.toString();
    rrCount = inventory1.rrCount.toString();
    sqcCount = inventory1.sqcCount.toString();
    srCount = inventory1.srCount.toString();
    depoDcCount = inventory1.depoDcCount.toString();
    setState(() {
      isLoading = false;
    });
    return '';
  }

  @override
  void initState() {
    super.initState();
    getAdminNotificationCount();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
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
          "Inventory Notifications",
          style: GoogleFonts.bakbakOne(
            fontSize: 20,
            color: const Color(0xff074974),
          ),
        ),
        actions: [
          const SizedBox(
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
              child: Column(
                children: [
                  //Fahim's edit
                  if (srCount == "0")
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          srCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => SR_notification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Store Requisition Notifications",
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
                  if (rrCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          rrCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => RR_Notification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "RR Notifications",
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
                  if (grnCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          grnCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => GRN_notification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "GRN Notifications",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 18,
                                    color: const Color(0xff064A76),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (toCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          toCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => TO_Notification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "TO Notification",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  if (damageCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          damageCount,
                          style: const TextStyle(color: Colors.white),
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
                                          DamageApproval_notification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Damage Approval Notification",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  if (sqcCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          sqcCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => SQC_notification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "SQC Notification",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: const Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  if (stoCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          stoCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => PendingSTOScreen(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "STO Approval",
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
                  if (depoDcCount == '0')
                    ...[]
                  else ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: Badge(
                        label: Text(
                          depoDcCount,
                          style: const TextStyle(color: Colors.white),
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
                                      builder: (context) => DepoDCNotification(
                                            xposition: widget.xposition,
                                            xstaff: widget.xstaff,
                                            zemail: widget.zemail,
                                            zid: widget.zid,
                                          )));
                            },
                            child: Text(
                              "Depo DC Approval",
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
            ),
    );
  }
}
