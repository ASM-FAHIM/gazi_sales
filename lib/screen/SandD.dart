import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data_model/notificaiton_count/total_count_model.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/dc_notification.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/ddc_list_notifications.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/deposit_notification.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/salesreturn_notification.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/notification_pages/so_notification.dart';
import '../sales/constant/app_constants.dart';
import 'package:http/http.dart' as http;
import '../sales/constant/colors.dart';

class SalesDistribution extends StatefulWidget {
  final String xposition;
  final String zid;
  final String zemail;
  final String xstaff;

  const SalesDistribution(
      {required this.xposition,
      required this.zid,
      required this.zemail,
      required this.xstaff,
      Key? key})
      : super(key: key);

  @override
  State<SalesDistribution> createState() => _SalesDistributionState();
}

class _SalesDistributionState extends State<SalesDistribution> {
  String soCount = "0";

  String dcCount = "0";

  String depositCount = "0";

  String salesReturnCount = "0";

  String ddcListCount = "0";

  int salesCount = 0;
  late SalesMOdel salesCount1;

  bool isLoading = false;
  int totalCount = 0;

  Future<String> getAdminNotificationCount() async {
    setState(() {
      isLoading = true;
    });

    var responseInv = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/notification/sales/total_sales.php?zid=${widget.zid}&xposition=${widget.xposition}'));
    print('---------------${responseInv.body}');

    salesCount1 = salesMOdelFromJson(responseInv.body);
    soCount = salesCount1.soCount.toString();
    dcCount = salesCount1.dcCount.toString();
    depositCount = salesCount1.depositCount.toString();
    salesReturnCount = salesCount1.srCount.toString();
    ddcListCount = '1';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          "Sales & Distribution",
          style: GoogleFonts.bakbakOne(
            fontSize: 20,
            color: Color(0xff074974),
          ),
        ),
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
                    if (soCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            soCount,
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
                                        builder: (context) => SO_notification(
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                              xStaff: widget.xstaff,
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
                      ),
                    ],
                    if (depositCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            depositCount,
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DepositNotifiScreen(
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                              xstaff: widget.xstaff,
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
                        ),
                      ),
                    ],
                    if (dcCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            dcCount,
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
                                        builder: (context) => DC_Notification(
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                              xstaff: widget.xstaff,
                                            )));
                              },
                              child: Text(
                                "DC Notification",
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
                    if (salesReturnCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            salesReturnCount,
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
                                        builder: (context) => PSRA_notification(
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                              xstaff: widget.xstaff,
                                            )));
                              },
                              child: Text(
                                "Sales Return Approval",
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
                    if (ddcListCount == '0')
                      ...[]
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Badge(
                          label: Text(
                            ddcListCount,
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
                                            DDCListNotification(
                                              xposition: widget.xposition,
                                              zemail: widget.zemail,
                                              zid: widget.zid,
                                              xstaff: widget.xstaff,
                                            )));
                              },
                              child: Text(
                                "DDC List Approval",
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
