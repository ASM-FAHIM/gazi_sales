import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../../data_model/notificaiton_count/admin_count.dart';
import '../../../../sales/constant/colors.dart';
import '../../../../screen/FinanaceAccounts.dart';
import '../../../../screen/Production.dart';
import '../../../../screen/Purchase.dart';
import '../../../../screen/SandD.dart';
import '../../../../widgets/ap_not_container.dart';
import '../../../../screen/hr_approver_home.dart';
import '../../../notification.dart';
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
  @override
/*  String po_Count = "0";
  late PoModel po_Count1;

  String cs_Count = "0";
  late CsModel cs_Count1;

  String sr_Count = "0";
  late SrModel sr_Count1;

  String pendingVoucher_Count = "0";
  late PendingVoucherModel pendingVoucher_Count1;

  String spr_Count = "0";
  late SprModel spr_Count1;

  String spa_Count = "0";
  late SpaModel spa_Count1;

  String grn_Count = "0";
  late GrnModel grn_Count1;

  String sqc_Count = "0";
  late SqcModel sqc_Count1;

  String prn_Count = "0";
  late PrnModel prn_Count1;

  String so_Count = "0";
  late SoModel so_Count1;

  String dc_Count = "0";
  late DcCountModel dc_Count1;

  String do_Count = "0";
  late DoModel do_Count1;

  String salesReturn_Count = "0";
  late SalesReturnModel salesReturn_Count1;

  String bm_Count = "0";
  late BomModel bm_Count1;

  String bmp_Count = "0";
  late BmpModel bmp_Count1;

  String batp_Count = "0";
  late BatpModel batp_Count1;

  String bat_Count = "0";
  late BatModel bat_Count1;

  String cusList_Count = "0";
  late CusListCountModel cusList_Count1;*/

  // String penSup_Count = "0";
  // late CusListCountModel penSup_Count1;

/*  String monReq_Count = "0";
  late MonReqCountModel monReq_Count1;

  String monReqAdj_Count = "0";
  late MonReqAdjCountModel monReqAdj_Count1;

  String serviceNoti_Count = "0";
  late ServiceNotifyCountModel serviceNoti_Count1;

  String items_Count = "0";
  late ItemsCountModel items_Count1;

  String supplier_Count = "0";
  late SupplierCountModel supplier_Count1;*/

/*  String absentemployee_count = "0";
  late AbsentCountModel absentemployee_count1;

  String leaveandtouradmin_count = "0";
  late LeaveandTourCountModel leaveandtouradmin_count1;

  String earlyemployee_count = "0";
  late EarlyCountModel earlyemployee_count1;

  String lateemployee_count = "0";
  late LateCountModel lateemployee_count1;*/

/*  bool isLoading = false;
  int totalCount = 0;

  int inventoryCount = 0;
  int hrCount = 0;
  int purchaseCount = 0;
  int voucherCount = 0;
  int bomCount = 0;*/

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
      body: SingleChildScrollView(
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
                        // circleColor: hrCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: hrCount.toString(),
                        image: 'assets/images/management.png',
                        text: 'HCM Approval',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationList(
                              xposition: widget.xposition,
                              xstaff: widget.xStaff,
                              zid: widget.zid,
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
                        // circleColor: inventoryCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: inventoryCount.toString(),
                        image: 'assets/images/personal.png',
                        text: 'Personal',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminNotificationList(
                              xposition: widget.xposition,
                              xstaff: widget.xStaff,
                              zemail: widget.zemail,
                              zid: widget.zid,
                              // adminSPR: SPRCount.toString(),
                              // adminSR: SRCount.toString(),
                              // adminRR: RRCount.toString(),
                              // adminASTI: ASTICount.toString(),
                              // adminTO: TOCount.toString(),
                              // adminLRE: LRECount.toString(),
                              // adminGRN: GRNCount.toString(),
                              // adminSQC: SQCCount.toString(),
                              // adminInspection: INSPCount.toString(),
                              // adminDamage: DAMAGECount.toString(),
                            ),
                          ),
                        );
                      },
                      child: ReusableWidget(
                        // circleColor: inventoryCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: inventoryCount.toString(),
                        image: 'assets/images/inventory.png',
                        text: 'Inventory',
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
                            builder: (context) => PurchaseNotificationList(
                              xposition: widget.xposition,
                              xstaff: widget.xStaff,
                              zemail: widget.zemail,
                              zid: widget.zid,
                              // adminPO: POCount.toString(),
                              // adminCS: CSCount.toString(),
                              // adminCash: CashCount.toString(),
                              // adminPADJ: PADJCount.toString(),
                              // adminPAF: PAFCount.toString(),
                            ),
                          ),
                        );
                      },
                      child: ReusableWidget(
                        // circleColor: purchaseCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: purchaseCount.toString(),
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
                        // circleColor: voucherCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: voucherCount.toString(),
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
                            builder: (context) => ProductionNotificationList(
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
                        // circleColor: bomCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: bomCount.toString(),
                        image: 'assets/images/production.png',
                        text: 'Production',
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
                                builder: (context) => SalesDistribution(
                                      xposition: widget.xposition,
                                      xstaff: widget.xStaff,
                                      zemail: widget.zemail,
                                      zid: widget.zid,
                                    )));
                      },
                      child: ReusableWidget(
                        /*circleColor: PurchaseCount == 0
                              ? Colors.transparent
                              : Colors.red,*/
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
                              zid: widget.zid,
                              // adminSPR: SPRCount.toString(),
                              // adminSR: SRCount.toString(),
                              // adminRR: RRCount.toString(),
                              // adminASTI: ASTICount.toString(),
                              // adminTO: TOCount.toString(),
                              // adminLRE: LRECount.toString(),
                              // adminGRN: GRNCount.toString(),
                              // adminSQC: SQCCount.toString(),
                              // adminInspection: INSPCount.toString(),
                              // adminDamage: DAMAGECount.toString(),
                            ),
                          ),
                        );
                      },
                      child: ReusableWidget(
                        // circleColor: inventoryCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: inventoryCount.toString(),
                        image: 'assets/images/inventory.png',
                        text: 'Inventory',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PurchaseNotificationList(
                              xposition: widget.xposition,
                              xstaff: widget.xStaff,
                              zemail: widget.zemail,
                              zid: widget.zid,
                              // adminPO: POCount.toString(),
                              // adminCS: CSCount.toString(),
                              // adminCash: CashCount.toString(),
                              // adminPADJ: PADJCount.toString(),
                              // adminPAF: PAFCount.toString(),
                            ),
                          ),
                        );
                      },
                      child: ReusableWidget(
                        // circleColor: purchaseCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: purchaseCount.toString(),
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
                        // circleColor: voucherCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: voucherCount.toString(),
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
                            builder: (context) => ProductionNotificationList(
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
                        // circleColor: bomCount == 0
                        //     ? Colors.transparent
                        //     : Colors.red,
                        // badgeText: bomCount.toString(),
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
                        /*circleColor: PurchaseCount == 0
                              ? Colors.transparent
                              : Colors.red,*/
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
              /*if (widget.zid == '100000') ...[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              print('Employee HR Approval pressed');
                              setState(() {
                                isLoadingHR = true;
                              });

                              Future.delayed(
                                Duration(seconds: 1),
                                () {
                                  setState(() {
                                    isLoadingHR = false;
                                  });
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
                              );
                            },
                            child: totalCount == 0
                                ? Text(
                                    "Employee HR Approval",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.bakbakOne(
                                      fontSize: 18,
                                      color: Color(0xff064A76),
                                    ),
                                  )
                                : Badge(
                                    position: BadgePosition.topEnd(end: -30),
                                    badgeContent: Text(
                                      '$totalCount',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    child: Text(
                                      "Employee HR Approval",
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
                    ] else
                      ...[],
                    if (widget.zid == '100000') ...[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                                    Offset(0, 3), // changes position of shadow
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
                                  builder: (context) => NotificationList(
                                    xposition: widget.xposition,
                                    xstaff: widget.xStaff,
                                    zid: widget.zid,
                                    // earlyCount: earlyCount,
                                    // lateCount: lateCount,
                                    // leaveCount: leaveCount,
                                    // absentCount: absentCount,
                                    // user: widget.loginModel.zemail,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Personal notifications",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 18,
                                color: Color(0xff064A76),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ] else
                      ...[],*/
              /*Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                        PO_WO_approval_NotificationList(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                          },
                          child: Text(
                            "PO/WO Notifications",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                    builder: (context) => CS_notification(
                                          xposition: widget.xposition,
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                    builder: (context) => SR_notification(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                          xstaff: widget.xStaff,
                                        )));
                          },
                          child: Text(
                            "SR Notifications",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                    builder: (context) => Pending_voucher(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
                                        )));
                          },
                          child: Text(
                            "Voucher Notifications",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 18,
                              color: Color(0xff064A76),
                            ),
                          ),
                        ),
                      ),
                    ),*/
              /*Padding(
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
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CashAdvNotifScreen(
                                    xposition: widget.xposition,
                                    zemail: widget.zemail,
                                    zid: widget.zid,
                                  )));
                    },
                    child: Text(
                      "Cash adv Notifications",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
            ),*/
              /*Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                    builder: (context) => CashAdvNotifScreen(
                                          xposition: widget.xposition,
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
                    ),*/
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              //   child: Container(
              //     height: MediaQuery.of(context).size.width / 8,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       color: Colors.white70,
              //       borderRadius: BorderRadius.circular(20),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 1,
              //           blurRadius: 5,
              //           offset: Offset(0, 3), // changes position of shadow
              //         ),
              //       ],
              //     ),
              //     child: TextButton(
              //       style: TextButton.styleFrom(
              //           backgroundColor: Colors.white
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => Cash_notification(
              //                   xposition: widget.xposition,
              //                   zemail: widget.zemail,
              //                   zid: widget.zid,
              //                 )));
              //       },
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             "Cash Notifications",
              //             textAlign: TextAlign.center,
              //             style: GoogleFonts.bakbakOne(
              //               fontSize: 18,
              //               color: Color(0xff064A76),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              /*Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                          xStaff: widget.xStaff,
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
                              offset: Offset(0, 3), // changes position of shadow
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
                                    builder: (context) => DepositNotifiScreen(
                                          xposition: widget.xposition,
                                          zemail: widget.zemail,
                                          zid: widget.zid,
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
                    ),*/
              /*Padding(
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
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DealerVisitList(
                                xposition: widget.xposition,
                                zemail: widget.zemail,
                                zid: widget.zid,
                              )));
                    },
                    child: Text(
                      "Daily visit list",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Color(0xff064A76),
                      ),
                    ),
                  ),
                ),
            ),*/
            ],
          ),
        ),
      ),
    );
  }
}
