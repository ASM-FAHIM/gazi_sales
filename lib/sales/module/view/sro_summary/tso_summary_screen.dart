import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/notify_controller.dart';

class TSOSummaryScreen extends StatefulWidget {
  String zID;
  String name;
  String tsoID;
  TSOSummaryScreen({Key? key, required this.name, required this.tsoID, required this.zID}) : super(key: key);

  @override
  State<TSOSummaryScreen> createState() => _TSOSummaryScreenState();
}

class _TSOSummaryScreenState extends State<TSOSummaryScreen> {
  NotifyController notifyController = Get.find<NotifyController>();

  double _progress1 = 30;
  double _progress2 = 70;
  double _progress3 = 100;
  double _progress4 = 100;

  @override
  void initState() {
    // TODO: implement initState
    notifyController.getTsoSummary(widget.zID, widget.tsoID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 25,
                )),
            // centerTitle: true,
            title: BigText(
              text: "TSO Activities",
              color: AppColor.defWhite,
              size: 25,
            ),
          ),
          body: Obx(() => notifyController.isDataFetched.value
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(color: AppColor.appBarColor,),
                    ),
                    const Text('Loading...'),
                  ],
                ),
              )
              : Container(
                 padding: EdgeInsets.all(8),
                 child: Column(
                   children: [
                    Container(
                      height: 85,
                      width: double.maxFinite,
                      child: Card(
                        elevation: 3,
                        color: AppColor.comColor,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/images/male.png'),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(text: '${widget.name}', color: AppColor.defWhite,),
                                      SmallText(text: '${widget.tsoID}', color: AppColor.defWhite,)
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 328,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            child: CustomPaint(
                                              painter: CircleProgress(
                                                progress: _progress3,
                                                startColor: Colors.lightBlueAccent,
                                                endColor: Colors.lightBlue,
                                                width: 4.0,
                                              ),
                                              child: Center(child: Text('${notifyController.tsoSummary!.mqty} LTR', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),),
                                            ),
                                          ),
                                        ),
                                        Text('Monthly target', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            child: CustomPaint(
                                              painter: CircleProgress(
                                                progress: _progress4,
                                                startColor: Colors.lightGreen,
                                                endColor: Colors.green,
                                                width: 4.0,
                                              ),
                                              child: Center(
                                                child: Text('${notifyController.tsoSummary!.qtyAch} LTR', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),),
                                            ),
                                          ),
                                        ),
                                        Text('Monthly achievement', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              BigText(text: 'Daily Shop visit :',size: 14 ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Shops', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.dtarget}', style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Visited', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('0', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Remaining', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.dtarget}', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Monthly Shop visit :',size: 14 ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Shops', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.mtarget}', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Visited', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.mshopvisit}', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Remaining', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.mtarget}', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /*SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Target :',size: 14 ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Daily', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('0 LTR', style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Monthly', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.mqty} LTR', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 70,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(1, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Remaining', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('${notifyController.tsoSummary!.mqty} LTR', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10,),*/
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: 'Today\'s visit :',size: 14 ),
                        Container(
                          height: 255,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),),
                          child: notifyController.tsoWiseDealerVisit.isEmpty
                            ? Center(child: const Text('Empty list', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),))
                            : ListView.builder(
                              itemCount: notifyController.tsoWiseDealerVisit.length,
                              itemBuilder: (context, index){
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(side: const BorderSide(color: AppColor.comColor,), borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BigText(text: notifyController.tsoWiseDealerVisit[index].dealer, size: 16,),
                                          SmallText(text: notifyController.tsoWiseDealerVisit[index].location),
                                        ],
                                      ),
                                      BigText(text: notifyController.tsoWiseDealerVisit[index].inTime, size: 15,),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                ),
              ],
            ),
          )),
        )
    );
  }
}


class CircleProgress extends CustomPainter {
  const CircleProgress({
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.width,
  })
      : assert(progress != null),
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
    final radius = min(size.width / 2.7, size.height / 2.7) - (width / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (progress / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
