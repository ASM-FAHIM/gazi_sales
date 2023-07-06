import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../report/attendance_report.dart';
import '../sales/constant/app_constants.dart';

class AttendanceField extends StatefulWidget {
  AttendanceField(
      {required this.xstaff, required this.xposition, required this.xsid});

  String xstaff;
  String xposition;
  dynamic xsid;

  @override
  _AttendanceFieldState createState() => _AttendanceFieldState();
}

class _AttendanceFieldState extends State<AttendanceField> {
  DateTime now = DateTime.now();
  String dropdownValue = 'Pick';
  String _fromDate = '';
  String _toDate = '';
  var initialDate;
  var firstDate;
  var lastDate;

  String intime = '';
  String outtime = '';
  bool pressAttention = false;
  bool pressAttention1 = false;
  late String _currentAddress = " ";
  late String _currentAddressout = " ";
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int datecount = 0;
  String AddressIN = '';
  String Addressdetails = '';
  String location = '';
  String AddressOUT = '';

  Future<Position> _getGeoLocationPosition() async {
    print("pressed");
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLongIN(Position position) async {
    print("Enter");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    // bool isMockLocation = false;
    //
    // isMockLocation = await TrustLocation.isMockLocation;
    //
    // print(isMockLocation);

    Placemark place = placemarks[0];

    AddressIN =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    Addressdetails = '$placemarks';
    setState(() {});
    //print(Address);

    var response = await http.post(
        Uri.parse('http://${AppConstants.baseurl}/ughcm/attendencetemp.php'),
        body: jsonEncode(<String, String>{
          "xposition": widget.xposition,
          "xtimein": intime,
          "xlocation": AddressIN,
        }));
    print(response.statusCode);
    print(response.body);
    print(AddressIN);
  }

  Future<void> GetAddressFromLatLongOUT(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    AddressOUT =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
    // print(Address);
    //
    // bool isMockLocation = await TrustLocation.isMockLocation;
    //
    // print(isMockLocation);

    var response = await http.post(
        Uri.parse('http://${AppConstants.baseurl}/ughcm/attendencetemp.php'),
        body: jsonEncode(<String, String>{
          "xposition": widget.xposition,
          "xtimein": outtime,
          "xlocation": AddressOUT,
        }));
    print(response.statusCode);
    print(response.body);
    print(AddressIN);
  }

  void _showFromDatePicker() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (context, child) => Theme(
        data: ThemeData(
            backgroundColor: Colors.blueAccent,
            colorScheme: ColorScheme.dark(
              primary: Colors.blueAccent,
              surface: Color(0xff064A76),
            )),
        child: child as Widget,
      ),
    );

    if (picked != null)
      setState(() => _fromDate =
          DateFormat("yyyy-MM-dd").format(DateTime.parse(picked.toString())));
    print('===================================$_fromDate');
  }

  void _showToDatePicker() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
      builder: (context, child) => Theme(
        data: ThemeData(
            backgroundColor: Colors.blueAccent,
            colorScheme: ColorScheme.dark(
              primary: Colors.blueAccent,
              surface: Color(0xff064A76),
            )),
        child: child as Widget,
      ),
    );

    if (picked != null)
      setState(() => _toDate =
          DateFormat("yyyy-MM-dd").format(DateTime.parse(picked.toString())));
    print('===================================$_toDate');
  }

/*  submitData(invalue, outvalue, inlocation, outlocation) async {
    print(invalue);
    print(outvalue);
    print(inlocation);
    print(outlocation);

    var response = await http.post(
        Uri.parse('http://103.150.48.235:2165/API/aygaz/HR/attendance/attendencetemp.php'),
        body: jsonEncode(<String, String>{
          "xposition": "2125",
          "xtimein": "2022-03-07 09:01:35.000",
          "xmodel": "B@N"
        }));
    var data = response.body;
    // print (data);
    print("ii" + response.body);
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    now;
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
            "Attendance",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // from date View
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Container(
                  //height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: ispressed ? Colors.white : Colors.grey,
                    //border: Border.all(color: Colors.grey),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (datecount == 0) ...[
                                TextButton(
                                  // minWidth:
                                  //     MediaQuery.of(context).size.width / 3,

                                  style: TextButton.styleFrom(
                                    backgroundColor: pressAttention
                                        ? Colors.green
                                        : Colors.white10,
                                  ),

                                  // color: pressAttention
                                  //     ? Colors.green
                                  //     : Colors.white10,
                                  onPressed: () async {
                                    //something will change
                                    Position position =
                                        await _getGeoLocationPosition();
                                    location =
                                        'Lat: ${position.latitude} , Long: ${position.longitude}';

                                    GetAddressFromLatLongIN(position);

                                    //GetAddressFromLatLong();

                                    setState(() {
                                      print('in count $datecount');
                                      datecount = datecount + 1;
                                      DateTime now = DateTime.now();
                                      date = now.toString();
                                      String Onlydate =
                                          DateFormat("yyyy-MM-dd h:mm:ssa")
                                              .format(now);
                                      intime = '$Onlydate';
                                      pressAttention = !pressAttention;
                                    });

                                    // var response = await http.post(
                                    //     Uri.parse(
                                    //         'http://$api/ughcm/attendencetemp.php'),
                                    //     body: jsonEncode(<String, String>{
                                    //       "xposition": widget.xposition,
                                    //       "xtimein": intime,
                                    //       "xlocation": AddressIN,
                                    //     }));
                                    // print(response.statusCode);
                                    // print(response.body);
                                    // print(AddressIN);

                                    print(intime);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "IN Time Saved",
                                        style: GoogleFonts.bakbakOne(
                                          fontSize: 18,
                                          //color: Color(0xff074974),
                                        ),
                                      ),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        "IN",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: pressAttention
                                              ? Colors.black
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "$intime",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.bakbakOne(
                                            fontSize: 15, color: Colors.black
                                            //color: Color(0xff074974),
                                            ),
                                      ),
                                      Text(
                                        AddressIN,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.bakbakOne(
                                            fontSize: 15, color: Colors.black
                                            //color: Color(0xff074974),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else ...[
                                Column(
                                  children: [
                                    Text(
                                      "IN",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: pressAttention
                                            ? Colors.black
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "$intime",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bakbakOne(
                                          fontSize: 15, color: Colors.black
                                          //color: Color(0xff074974),
                                          ),
                                    ),
                                    Text(
                                      AddressIN,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bakbakOne(
                                          fontSize: 15, color: Colors.black
                                          //color: Color(0xff074974),
                                          ),
                                    ),
                                  ],
                                )
                              ],
                              TextButton(
                                //minWidth: MediaQuery.of(context).size.width / 3,
                                style: TextButton.styleFrom(
                                  backgroundColor: pressAttention1
                                      ? Colors.red
                                      : Colors.white,
                                ),

                                onPressed: () async {
                                  print('out count $datecount');
                                  //something will change
                                  Position position =
                                      await _getGeoLocationPosition();
                                  location =
                                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                                  GetAddressFromLatLongOUT(position);
                                  setState(() {
                                    datecount = 0;
                                    print(datecount);
                                    DateTime now = DateTime.now();
                                    date = now.toString();
                                    String Onlydate =
                                        DateFormat("yyyy-MM-dd h:mm:ssa")
                                            .format(now);
                                    outtime = '$Onlydate';
                                    pressAttention1 = !pressAttention1;
                                    print(outtime);

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "OUT Time saved",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.bakbakOne(
                                          fontSize: 18,
                                          //color: Color(0xff074974),
                                        ),
                                      ),
                                    ));
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "OUT",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "$outtime",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bakbakOne(
                                          fontSize: 15, color: Colors.black
                                          //color: Color(0xff074974),
                                          ),
                                    ),
                                    Text(
                                      AddressOUT,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.bakbakOne(
                                          fontSize: 15, color: Colors.black
                                          //color: Color(0xff074974),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Divider(
                thickness: 2,
                color: Colors.black,
              ),

              Text(
                "Personal Attendance Info",
                style: GoogleFonts.bakbakOne(
                  fontSize: 18,
                  //color: Color(0xff074974),
                ),
              ),

              Divider(
                thickness: 2,
                color: Colors.black,
              ),

              Stack(
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xfffafafa)),
                    onPressed: () {
                      _showFromDatePicker();
                    },
                    //splashColor: Colors.white,
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                          child: Row(
                        children: [
                          // TextButton(
                          //   color: Color(0xfffafafa),
                          //   onPressed: () {
                          //     _showFromDatePicker();
                          //   },
                          //   child: Icon(Icons.calendar_today_sharp),
                          // ),

                          Icon(Icons.calendar_today_sharp,
                              color: Color(0xff074974)),

                          SizedBox(
                            width: 10,
                          ),

                          Text(
                            _fromDate,
                            style: GoogleFonts.bakbakOne(
                                fontSize: 18, color: Colors.black
                                //color: Color(0xff074974),
                                ),
                          ),
                        ],
                      )),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff074974), width: 1),
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      color: Color(0xfffafafa),
                      child: Text(
                        'Form Date',
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                          //color: Color(0xff074974),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //to date view
              Stack(
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xfffafafa)),
                    // splashColor: Colors.white,
                    //minWidth: double.infinity,
                    onPressed: () {
                      _showToDatePicker();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                          child: Row(
                        children: [
                          // TextButton(
                          //   color: Color(0xfffafafa),
                          //   onPressed: () {
                          //     _showToDatePicker();
                          //   },
                          //   child: Icon(Icons.calendar_today_sharp),
                          // ),

                          Icon(Icons.calendar_today_sharp,
                              color: Color(0xff074974)),

                          SizedBox(
                            width: 10,
                          ),

                          Text(
                            _toDate,
                            style: GoogleFonts.bakbakOne(
                                fontSize: 18, color: Colors.black
                                //color: Color(0xff074974),
                                ),
                          ),
                        ],
                      )),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff074974), width: 1),
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 12,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      color: Color(0xfffafafa),
                      child: Text(
                        'To Date',
                        style: GoogleFonts.bakbakOne(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //TextButton or TextButton Container
              Center(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    color: Color(0xff074974),
                    //border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
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
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xff074974)),
                    onPressed: () async {
                      //something will change
                      print("Tapped");
                      print("f" + _fromDate);
                      print("t" + _toDate);

                      if (_fromDate == "") {
                        Get.snackbar('Error', 'Please Select From Date',
                            backgroundColor: Color(0XFF8CA6DB),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM);
                      } else if (_toDate == "") {
                        Get.snackbar('Error', 'Please Select  to Date',
                            backgroundColor: Color(0XFF8CA6DB),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM);
                      } else if (_fromDate == "" || _toDate == "") {
                        Get.snackbar(
                            'Error', 'Please Select From Date and to Date',
                            backgroundColor: Color(0XFF8CA6DB),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM);
                      } else if (DateTime.parse(_toDate)
                          .isBefore(DateTime.parse(_fromDate))) {
                        Get.snackbar(
                            'Error', 'To date cannot be greater then From date',
                            backgroundColor: Color(0XFF8CA6DB),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Attendance_report(
                                      fromDate: _fromDate,
                                      toDate: _toDate,
                                      xstaff: widget.xstaff,
                                      xposition: widget.xposition,
                                      xsid: widget.xsid,
                                    )));
                      }
                    },
                    child: Text(
                      "View report",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bakbakOne(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
