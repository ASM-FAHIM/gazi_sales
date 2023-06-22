import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/report/customer_ledger_screen.dart';
import 'package:gazi_sales_app/sales/module/view/report/monthly_so_report.dart';
import 'package:gazi_sales_app/sales/module/view/report/pending_so_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import 'dart:math';

import '../../../widget/business_widget.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
/*  double _progress1 = 30;
  double _progress2 = 70;
  double _progress3 = 60;
  double _progress4 = 80;*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            ),
          ),
          title: BigText(
            text: "Report",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BusinessWidget(
                    businessName: 'Pending SO report',
                    imgPath: 'assets/images/report.png',
                    height: 70,
                    onPressed: () {
                      Get.to(() => PendingSOReport());
                    },
                  ),
                  BusinessWidget(
                    businessName: 'Monthly SO report',
                    imgPath: 'assets/images/worknote.png',
                    height: 70,
                    onPressed: () {
                      Get.to(() => MonthlySOReport());
                    },
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.width / 2.5,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.appBarColor.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CustomerLedgerScreen()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/expense_report.png'),
                          height: 70,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BigText(
                          text: 'Customer ledger',
                          size: 12,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class CircleProgress extends CustomPainter {
  const CircleProgress({
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.width,
  })  : assert(progress != null),
        assert(startColor != null),
        assert(endColor != null),
        assert(width != null),
        super();

  final double progress;
  final Color startColor;
  final Color endColor;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: 3 * pi / 2,
      endAngle: 7 * pi / 2,
      tileMode: TileMode.repeated,
      colors: [startColor, endColor],
    );

    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (progress / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}*/
