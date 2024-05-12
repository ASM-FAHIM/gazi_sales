import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/production/notification_page/bat_notification.dart';
import 'package:gazi_sales_app/hr/notifications/approverNotification/screen/production/notification_page/inspection_approval_notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../data_model/notificaiton_count/total_count_model.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';
import '../hr/notifications/approverNotification/screen/production/notification_page/assambleBatch_notification.dart';
import '../hr/notifications/approverNotification/screen/production/notification_page/bom_notification.dart';
import '../hr/notifications/approverNotification/screen/production/notification_page/customBatch_notification.dart';
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

  String customBatchCount = "0";

  String assembleBatchCount = "0";

  int productionCount = 0;
  late ProductionModel productionCount1;

  bool isLoading = false;
  int totalCount = 0;

  /*Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });
    var responseInv = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/notification/production/total_production.php?zid=${widget.zid}&xposition=${widget.xposition}'));
    //print('---------------${responseInv.body}');

    productionCount1 = productionModelFromJson(responseInv.body);
    bomCount = productionCount1.bomCount.toString();
    batCount = productionCount1.batchCOunt.toString();
    inspCount = productionCount1.InsCount.toString();
    customBatchCount = productionCount1.customBatchCount.toString();
    assembleBatchCount = productionCount1.assembleBatchCount.toString();

    setState(() {
      isLoading = false;
    });
    return '';
  }*/
  /*Future<void> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/notification/production/total_production.php?zid=${widget.zid}&xposition=${widget.xposition}'));

      if (response.statusCode == 200) {
        productionCount1 = productionModelFromJson(response.body);
        bomCount = productionCount1.bomCount.toString();
        batCount = productionCount1.batchCount.toString();
        inspCount = productionCount1.insCount.toString();
        customBatchCount = productionCount1.customBatchCount.toString();
        assembleBatchCount = productionCount1.assembleBatchCount.toString();
      } else {
        // Handle server error
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error fetching data: $e');
    }

    setState(() {
      isLoading = false;
    });
  }*/

  Future<void> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/notification/production/total_production.php?zid=${widget.zid}&xposition=${widget.xposition}'));

      print('Response Body: ${response.body}'); // Add this line for debugging

      if (response.statusCode == 200) {
        productionCount1 = productionModelFromJson(response.body);
        bomCount = productionCount1.bomCount.toString();
        batCount = productionCount1.batchCount.toString();
        inspCount = productionCount1.insCount.toString();
        customBatchCount = productionCount1.customBatchCount.toString();
        assembleBatchCount = productionCount1.assembleBatchCount.toString();
      } else {
        // Handle server error
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error fetching data: $e');
    }
    print('batCount value inside if block: ${productionCount1.batchCount}');
    setState(() {
      isLoading = false;
    });
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
                      ...[
                        // Center(child: const Text("No Data Available")),
                      ]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
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
                          label: Text(
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
                      ...[

                        //print('batCount value inside if block: $batCount');
                      ]
                    else ...[
                      Padding(

                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
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
                                "Pending Batch Approval",
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
                    if (customBatchCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            customBatchCount,
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
                                        builder: (context) => CustomBAT_notification(
                                          xposition: widget.xposition,
                                          xstaff: widget.xstaff,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                              },
                              child: Text(
                                "Pending Custom Batch Approval",
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
                    if (assembleBatchCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            assembleBatchCount,
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
                                        builder: (context) => AssembleBAT_notification(
                                          xposition: widget.xposition,
                                          xstaff: widget.xstaff,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                              },
                              child: Text(
                                "Pending Assemble Batch Approval",
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
