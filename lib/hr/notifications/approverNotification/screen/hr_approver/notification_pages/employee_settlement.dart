import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../screen/hr_approver_home.dart';

class SettlementListScreen extends StatefulWidget {
  //const SettlementListScreen({Key? key}) : super(key: key);

  SettlementListScreen({
    required this.xposition,
    required this.xstaff,
    required this.zemail,
    required this.zid,
  });

  String xposition;
  String xstaff;
  String zemail;
  String zid;

  @override
  State<SettlementListScreen> createState() => _SettlementListScreenState();
}

class _SettlementListScreenState extends State<SettlementListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HrApproverHome(
                          xposition: widget.xposition,
                          zemail: widget.zemail,
                          xstaff: widget.xstaff,
                          zid: widget.zid,
                        )));
          },
        ),
        title: Center(
          child: Text(
            "Settlement List Approval",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: Color(0xff074974),
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}
