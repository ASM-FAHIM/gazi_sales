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
    hrApproval = totalCount1.Employee_HR_Count.toString();
    pHrApproval = totalCount1.personal_HR_Count.toString();
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
                         /* GestureDetector(
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
                          ),*/
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => SalesDistribution(
                      //                       xposition: widget.xposition,
                      //                       xstaff: widget.xStaff,
                      //                       zemail: widget.zemail,
                      //                       zid: widget.zid,
                      //                     )));
                      //       },
                      //       child: ReusableWidget(
                      //         circleColor: sApproval == '0'
                      //             ? Colors.transparent
                      //             : Colors.red,
                      //         badgeText: sApproval,
                      //         image: 'assets/images/money (1).png',
                      //         text: 'Sales',
                      //         textS: '& Distribution',
                      //       ),
                      //     ),
                      //
                      //
                      //   ],
                      // ),
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

                  ],
                ),
              ),
            ),
    );
  }
}
