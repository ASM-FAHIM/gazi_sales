import 'dart:io' show Platform, exit;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/sales/constant/colors.dart';
import 'package:gazi_sales_app/sales/databaseHelper/database_helper.dart';
import 'package:gazi_sales_app/sales/module/controller/login_controller.dart';
import 'package:gazi_sales_app/sales/module/view/business_screen.dart';
import 'package:gazi_sales_app/screen/login_page.dart';
import 'package:gazi_sales_app/screen/zid_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'data_model/promotion.dart';
import 'data_model/xyearperdate.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  bool isConnected;
  String zemail;

  Homepage({required this.isConnected, required this.zemail});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  LoginController loginController = Get.put(LoginController());
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  DateTime now = DateTime.now();
  DateTime notificationTime = DateTime.now();
  String intime = '';
  String outtime = '';
  bool pressAttention = false;
  bool pressAttention1 = false;
  late String _currentAddress = " ";
  late String _currentAddressout = " ";

  bool isLoading = false;

  //get all user data from table
  late String xname;
  late String xstaff;
  late String xdeptname;
  late String xposition;
  late String xempbank;
  late String xacc;
  late String xsex;
  late String xempcategory;
  late String xrole;
  late String zemail;
  late String xpassword;
  late String xdesignation;
  late String xsid;
  late String supname;

  getUserdata()async{
    setState(() {
      isLoading = true;
    });
    final conn = DBHelper.dbHelper;
    var dbclient = await conn.db;
    List<Map> result = await dbclient!.rawQuery("SELECT * FROM ${DBHelper.loginTable} where zemail = ${widget.zemail} LIMIT 1");
    // await dbclient.close();
    print('===========$result');
    Map firstRow = result[0];

    setState(() {
      xname= firstRow['xname'];
      xstaff= firstRow['xstaff'];
      xdeptname= firstRow['xdeptname'];
      xposition= firstRow['xposition'];
      zemail= firstRow['zemail'];
      xpassword= firstRow['xpassword'];
      xdesignation= firstRow['xdesignation'];
      xsid= firstRow['xsid'];
      xempbank= firstRow['xempbank'];
      xacc= firstRow['xacc'];
      xsex= firstRow['xsex'];
      xempcategory= firstRow['xempcategory'];
      supname= firstRow['supname'];
      xrole= firstRow['xrole'];
      isLoading = false;
    });

    loginController.xposition.value = xposition;
    loginController.xName.value = xname;
    loginController.xstaff.value = xstaff;

    print('all'+ firstRow.toString());
    print('zemail'+ firstRow['zemail']);
    print(xposition);
  }

  Future<List<PromotionModel>>? futurePost;
  Future<void> getLocationin() async {
    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(
        () {
          _currentAddress =
              "${place.locality}, ${place.postalCode}, ${place.country}";
        },
      );
    } catch (e) {
      print(e);
    }
  }

  late XbalanceModel leave_remain1;
  String xbalance = " ";

  Future<void> getLocationout() async {
    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude);
    print(position.longitude);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddressout =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  //for exit the app
  Future<bool?> showWarningContext(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Do you want to exit app?",
            style: TextStyle(color: Color(0xff074974)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                "No",
                style: TextStyle(
                  color: Color(0xff074974),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Color(0xff074974),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      getUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          onWillPop: () async {
            final shouldPop = await showWarningContext(context);
            return shouldPop ?? false;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: const Text(""),
              title: Center(
                child: Image.asset(
                  'assets/images/logo/100000.png',
                  fit: BoxFit.cover,
                  height: 50,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () async{
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          const Login_page()), (Route<dynamic> route) => false);},
                    icon: const Icon(
                      Icons.logout,
                      color: Color(0xff074974),
                    ),
                  ),
                ),
              ],
            ),
            body: isLoading
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const CircularProgressIndicator(color: AppColor.appBarColor,),
                      ),
                      const Text('Loading...'),
                    ],
                  ),
                )
                :SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (xsex == 'Male') ...[
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/male.png'),
                          ),
                        ] else if (xsex == 'Female') ...[
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/female.png'),
                          ),
                        ] else ...[
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/images/male.png'),
                          ),
                        ],
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "${xname}",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 20,
                                    color: const Color(0xff074974),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  "${xposition}",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 20,
                                    color: const Color(0xff074974),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  " ${xdesignation}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 15,
                                    color: const Color(0xff074974),
                                  ),
                                ),
                              ),
                              Text(
                                " ${xempcategory}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.bakbakOne(
                                  // //fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: const Color(0xff074974),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                    child: Container(
                      //height: MediaQuery.of(context).size.width/2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextButton(
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(20.0),
                            // ),
                            onPressed: () async {
                              setState(
                                () {
                                  notificationTime = DateTime.now();
                                },
                              );
                              print(notificationTime);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Get_zid(
                                      zemail: zemail,
                                      xposition: xposition,
                                      xrole: xrole,
                                  )
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/notification.png'),
                                      height: 60,
                                      width: 60,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Notification",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bakbakOne(
                                        fontSize: 15,
                                        color: const Color(0xff074974),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                const Offset(0, 3), // changes position of shadow
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
                                      builder: (context) => const BusinessScreen()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/payslip.png'),
                                  height: 60,
                                  width: 60,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Sales",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 15,
                                    color: const Color(0xff074974),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        /*Container(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey),
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
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttendanceField(
                                        xstaff: xstaff90,
                                        xposition:
                                        xposition,
                                        xsid: xsid,
                                      )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(FontAwesomeIcons.clipboardCheck,
                                //   size: 60,
                                //   color: Color(0xff4AA0EC),
                                // ),

                                const Image(
                                  image: AssetImage('assets/images/attendance.png'),
                                  height: 60,
                                  width: 60,
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  "Attendance",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 15,
                                    color: Color(0xff074974),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey),
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
                                      builder: (context) => BusinessScreen()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(FontAwesomeIcons.fileAlt,
                                //   size: 60,
                                //   color: Color(0xff4AA0EC),
                                // ),

                                Image(
                                  image: AssetImage('assets/images/payslip.png'),
                                  height: 60,
                                  width: 60,
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  "Sales",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 15,
                                    color: Color(0xff074974),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        *//*Container(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey),
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
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Leave_page(
                                            xposition:
                                                xposition,
                                            xstaff: xstaff,
                                            xsid: xsid,
                                            xbalance: xbalance,
                                            xname: xname,
                                            supname: supname,
                                          )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(FontAwesomeIcons.calendarPlus,
                                //   size: 60,
                                //   color: Color(0xff4AA0EC),
                                // ),

                                Image(
                                  image: AssetImage('assets/images/leavetour.png'),
                                  height: 60,
                                  width: 60,
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  "Leave and Tour",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 15,
                                    color: Color(0xff074974),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),*//*
                        //absence approval part
                        // Container(
                        //   height: MediaQuery.of(context).size.width / 2.5,
                        //   width: MediaQuery.of(context).size.width / 2.65,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     //border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 1,
                        //         blurRadius: 5,
                        //         offset:
                        //             Offset(0, 3), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   child: TextButton(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20.0)),
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   AbsentApproval_page()));
                        //     },
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         // const Icon(FontAwesomeIcons.calendarMinus,
                        //         //   size: 60,
                        //         //   color: Color(0xff4AA0EC),
                        //         // ),
                        //
                        //         Image(
                        //           image: AssetImage('assets/images/absent.png'),
                        //           height: 60,
                        //           width: 60,
                        //         ),
                        //
                        //         SizedBox(
                        //           height: 10,
                        //         ),
                        //
                        //         Text(
                        //           "Absence Approval",
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.bakbakOne(
                        //             fontSize: 15,
                        //             color: Colors.grey,
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        //data sync part
                        // Container(
                        //   height: MediaQuery.of(context).size.width / 2.5,
                        //   width: MediaQuery.of(context).size.width / 2.65,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     //border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 1,
                        //         blurRadius: 5,
                        //         offset:
                        //             Offset(0, 3), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   child: TextButton(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20.0)),
                        //     onPressed: () {
                        //       //Navigator.push(context, MaterialPageRoute(builder: (context)=>Looptry(xstaff: xstaff, xposition: xposition, xsid: xsid)));
                        //     },
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         // const Icon(Icons.sync,
                        //         //   size: 50,
                        //         //   color: Color(0xff4AA0EC),
                        //         // ),
                        //
                        //         Image(
                        //           image: AssetImage('assets/images/sync.png'),
                        //           height: 60,
                        //           width: 60,
                        //         ),
                        //
                        //         SizedBox(
                        //           height: 20,
                        //         ),
                        //
                        //         Text(
                        //           "Data Sync",
                        //           textAlign: TextAlign.center,
                        //           style: GoogleFonts.bakbakOne(
                        //             fontSize: 15,
                        //             color: Colors.grey,
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        *//*Container(
                          height: MediaQuery.of(context).size.width / 2.5,
                          width: MediaQuery.of(context).size.width / 2.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey),
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
                                      builder: (context) => Payslip_page(
                                            xname: xname,
                                            xempbank:
                                                xempbank,
                                            xacc: xacc,
                                            xstaff: xstaff,
                                            xdesignation:
                                                xdesignation,
                                          )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // const Icon(FontAwesomeIcons.fileAlt,
                                //   size: 60,
                                //   color: Color(0xff4AA0EC),
                                // ),

                                Image(
                                  image: AssetImage('assets/images/payslip.png'),
                                  height: 60,
                                  width: 60,
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                Text(
                                  "Pay Slip",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.bakbakOne(
                                    fontSize: 15,
                                    color: Color(0xff074974),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),*//*
                      ],
                    ),
                  ),*/

                  /*Container(
                    height: MediaQuery.of(context).size.width / 2.5,
                    width: MediaQuery.of(context).size.width / 2.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(color: Colors.grey),
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
                                builder: (context) => TsoSelectionScreen()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Icon(FontAwesomeIcons.fileAlt,
                          //   size: 60,
                          //   color: Color(0xff4AA0EC),
                          // ),

                          Image(
                            image: AssetImage('assets/images/payslip.png'),
                            height: 60,
                            width: 60,
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Text(
                            "Sales",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bakbakOne(
                              fontSize: 15,
                              color: Color(0xff074974),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),*/


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


