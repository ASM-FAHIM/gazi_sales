import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../constant/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/cus_drawer.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../widget/small_text.dart';
import '../controller/dashboard_controller.dart';
import '../controller/login_controller.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  LoginController loginController = Get.find<LoginController>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  // uploading image
  File? pickedFile;
  String authImage = '';
  ImagePicker imagePicker = ImagePicker();
/*
  Future postUploadImg(File imageFile) async {
    final request = http.MultipartRequest('POST',
        Uri.parse("http://172.20.20.69/salesforce/image.php"))
      ..files.add(await http.MultipartFile.fromPath('photo', imageFile.path));

    //for test
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print("image uploaded");
      } else {
        print("uploaded failed: ${response.statusCode}");
      }
    } catch (e) {
      print('my exception: $e');
    }
  }*/

  double _progress1 = 30;
  double _progress2 = 70;
  double _progress3 = 100;
  double _progress4 = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     // dashboardController.getVisitedDealerList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: CusDrawer(),
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: const Icon(
              Icons.menu_outlined,
              size: 40,
            ),
          ),
          centerTitle: true,
          title: BigText(
            text: "Gazi Sales",
            color: AppColor.defWhite,
            size: 25,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (){
                    Get.to(() => const NotificationScreen());
                  },
                  icon: const Icon(MdiIcons.bellRing,),),
                Obx(() => IconButton(
                  onPressed: () {
                    dashboardController.asyncFunction();
                    //dashboardController.getProductInfo();
                  },
                  icon: dashboardController.isLoading7.value
                      ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.defWhite,
                        ),
                      )
                      : const Icon(
                      MdiIcons.syncIcon,
                    size: 30,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Obx(() =>
              dashboardController.isVisitDealerFound.value
              ? CircularProgressIndicator()
              : Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Center(
                  child: Column(
                    children: [
                     /* Obx(() => Container(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () async{
                            // dashboardController.checkFunction();
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return bottomSheet(context);
                                });
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.green, elevation: 5),
                          child: dashboardController.givingAtt.value
                              ? Center(child: CircularProgressIndicator(color: Colors.white,),)
                              : const Text('Check In'),
                        ),
                      ),
                      ),
                      SizedBox(height: 20,),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 150.0,
                                    height: 130.0,
                                    child: CustomPaint(
                                      painter: CircleProgress(
                                        progress: _progress3,
                                        startColor: Colors.lightBlueAccent,
                                        endColor: Colors.lightBlue,
                                        width: 8.0,
                                      ),
                                      child: Center(child: Text('5000 LTR', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text('Monthly target', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 150.0,
                                    height: 130.0,
                                    child: CustomPaint(
                                      painter: CircleProgress(
                                        progress: _progress4,
                                        startColor: Colors.lightGreen,
                                        endColor: Colors.green,
                                        width: 8.0,
                                      ),
                                      child: Center(
                                          child: Text('25000 LTR', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),),),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text('Monthly achievement', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),),
                              ],
                            ),
                          ),
                        ],
                      ),
                 /*     SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Monthly Sales Chart : '),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width:  MediaQuery.of(context).size.width / 1.10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        child: charts.BarChart(
                          series,
                          animate: true,
                        ),
                      )
                    ],
                  ),*/
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Daily Shop visit :',size: 14 ),
                              SizedBox(height: 20,),
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
                                        Text('150', style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
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
                                        Text('70', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
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
                                        Text('80', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Monthly Shop visit :',size: 14 ),
                              SizedBox(height: 20,),
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
                                        Text('700', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
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
                                  SizedBox(width: 20,),
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
                                        Text('700', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /*SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: 'Target :',size: 14 ),
                              SizedBox(height: 20,),
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
                                        Text('Daily', style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),),
                                        Text('20 LTR', style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
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
                                        Text('${loginController.tsoInfoList[0]["mshopvisit"]} LTR', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20,),
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
                                        Text('${loginController.tsoInfoList[0]["mshopvisit"]} LTR', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),*/
                          SizedBox(height: 20,),
                          BigText(text: 'Today\'s visit :',size: 14 ),
                          Container(
                            height: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: dashboardController.visitedDealer.isEmpty
                                ? Center(child: const Text('Empty list', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),))
                                : ListView.builder(
                              itemCount: dashboardController.visitedDealer.length,
                              itemBuilder: (context, index){
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BigText(text: '${dashboardController.visitedDealer[index]["dealerName"]}', size: 16,),
                                            SmallText(text: '${dashboardController.visitedDealer[index]["location"]}'),
                                          ],
                                        ),
                                        BigText(text: '${dashboardController.visitedDealer[index]["xdate"]}', size: 12,),
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
                ),
              )
          ),
        ),
        /*floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: const Icon(MdiIcons.bellRing, size: 30,),
          onPressed: (){
            Get.to(() => const NotificationScreen());
          },
        ),*/
      ),
    );
  }


/*  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.maxFinite,
      height: size.height * .2,
      decoration: const BoxDecoration(
        color: AppColor.appBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Choose profile photo",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              *//*GestureDetector(
                onTap: () {
                  debugPrint('Image clicked');
                  takePhoto(ImageSource.gallery);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 40,
                    ),
                    Text(
                      'Gallery',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),*//*
              GestureDetector(
                onTap: () {
                  debugPrint('Image clicked');
                  takePhoto(ImageSource.camera);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 40,
                    ),
                    Text(
                      'Camera',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedImage =
    await imagePicker.pickImage(source: source, imageQuality: 100);
    pickedFile = File(pickedImage!.path);
    authImage = pickedFile!.path.split('/').last;
    dashboardController.setAuthImagePath(pickedFile!.path);
    postUploadImg(pickedFile!);
    dashboardController.checkFunction(authImage);
    print('================${pickedFile}');
    print('================${authImage}');
  }*/

}

class LeadOpContainer extends StatelessWidget {
  String name;
  String loNumber;
  Color? color;
  LeadOpContainer({
    Key? key,
    this.color = Colors.deepOrangeAccent,
    required this.name,
    required this.loNumber
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
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
          Text(name, style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
          Text(loNumber, style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
        ],
      ),
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
    final radius = min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (progress / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/*Obx(() => Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// DateContainer(),
*//*dashboardController.isTargetFetched.value
                          ? Container()
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LeadOpContainer(name: "Target", loNumber: dashboardController.targetModel!.xtargetamt,),
                          SizedBox(width: 20,),
                          LeadOpContainer(name: "Achievement", loNumber: "0", color: Colors.green,),
                        ],
                      ),*//*
SizedBox(height: 20,),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
BigText(text: 'Daily Shop visit :'),
SizedBox(height: 20,),
Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
color: Colors.deepOrangeAccent,
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
Text('Shops', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
Text(' ', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
],
),
),
SizedBox(width: 20,),
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
color: Colors.green,
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
Text('Visited', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
Text(' ', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
],
),
),
SizedBox(width: 20,),
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
color: Colors.blueAccent,
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
Text('Remaining', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
Text(' ', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
],
),
),
],
),
],
),
SizedBox(height: 20,),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
BigText(text: 'Monthly Shop visit :'),
SizedBox(height: 20,),
Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
color: Colors.deepOrangeAccent,
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
Text('Shops', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
Text(' ', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
],
),
),
SizedBox(width: 20,),
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
color: Colors.green,
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
Text('Visited', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
Text(' ', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
],
),
),
SizedBox(width: 20,),
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20.0),
color: Colors.blueAccent,
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
Text('Remaining', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
Text(' ', style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
],
),
),
],
),
],
),


],
)),*/
