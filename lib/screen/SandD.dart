import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/deposit_notification.dart';
import '../hr/notifications/approverNotification/screen/sales_distribution/so_notification.dart';

class SalesDistribution extends StatefulWidget {
  String xposition;
  String zid;
  String zemail;
  String xstaff;

  SalesDistribution(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
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
            ),
            /*Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width / 8,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                                DealerVisitList(
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
    );
  }
}
