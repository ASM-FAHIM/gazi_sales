import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gazi_sales_app/sales/module/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../data_model/loginModel.dart';
import '../data_model/offline_login_model.dart';
import '../home_page.dart';
import '../sales/constant/app_constants.dart';
import '../sales/constant/colors.dart';
import '../sales/databaseHelper/database_helper.dart';
import '../sales/databaseHelper/login_repo.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  LoginController loginController = Get.put(LoginController());
  AppConstants appConstants = AppConstants();
  late String zemail;
  String xpassword = "";
  bool _obsecureText = true;
  bool isLoading = false;

  void toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  //Hive Database for remember me.
  bool isChecked = false;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late Box _box;
  late LoginModel data;

  submitData(String zemail, String xpassword) async {
    var response = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/loginapi.php?zemail=$zemail&xpassword=$xpassword'));
    //print('response body : ${response.body}');
    if (response.statusCode == 404) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text(
                "Warning",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffC85E2D),
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Wrong Username or Password",
                style: TextStyle(
                    // color:Color(0xffE75A29)
                    ),
              ),
              scrollable: true,
            );
          });
    }

    data = loginModelFromJson(response.body);
    //print(response.body);
    if (response.statusCode == 200 && data.xpassword != xpassword) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Warning",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffC85E2D),
                    fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Wrong Password",
                style: TextStyle(
                    // color:Color(0xffE75A29)
                    ),
              ),
              scrollable: true,
            );
          });
    }
    if (response.statusCode == 200 && data.xpassword == xpassword) {
      setState(() {
        isLoading = false;
      });
      saveLoginData(zemail, xpassword).whenComplete(() => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Homepage(
                  isConnected: isConnected, zemail: userController.text))));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => Homepage(isConnected: isConnected, zemail: userController.text)));
    }
  }

  //save login data to login table
  saveLoginData(String zemail, String xpassword) async {
    await LoginRepo().updateLoginStatus();
    var response = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/loginapi_offline.php?zemail=$zemail&xpassword=$xpassword'));
    return (json.decode(response.body) as List).map((user) {
      //print('Inserting $user');
      LoginRepo().insertToLoginTable(OfflineLoginModel.fromJson(user));
      setState(() {
        isLoading = false;
      });
    }).toList();
  }

  //login repo
  String loginState = '';

  Future loginStatus() async {
    loginState = await LoginRepo().getLoginStatus();
    //print('=============$loginState');
  }

  //internet Connection Check
  bool isConnected = true;

  Future<void> internetCheck() async {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(
    //           "Warning",
    //           style: TextStyle(
    //               fontSize: 20,
    //               color: Color(0xffC85E2D),
    //               fontWeight: FontWeight.bold),
    //         ),
    //         content: Text(
    //           "Wrong Username or Password",
    //           style: TextStyle(
    //             // color:Color(0xffE75A29)
    //           ),
    //         ),
    //         scrollable: true,
    //       );
    //     });

    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              isConnected = true;
            });
            //Navigator.pop(context);
            //print("Conn Status" + isConnected.toString());
            break;
          case InternetConnectionStatus.disconnected:
            setState(() {
              isConnected = false;
            });
            //Navigator.pop(context);
            //print("Conn Status" + isConnected.toString());
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 5));
    await listener.cancel();
  }

  //login route
  loginFunction() {
    if (loginState == 'Null' || isConnected == true) {
      setState(() {
        isLoading = false;
      });
      submitData(userController.text, passController.text);
    } else if (isConnected == false) {
      setState(() {
        isLoading = false;
      });
      offline_go_homepage();
    }
  }

  //offline route
  offline_go_homepage() async {
    //print("offline");

    final conn = DBHelper.dbHelper;
    var dbclient = await conn.db;
    List<Map> result = await dbclient!.rawQuery(
        "SELECT * FROM ${DBHelper.loginTable} where zemail = ${userController.text} LIMIT 1");
    // await dbclient.close();
    //print('===========$result');
    Map firstRow = result[0];

    //print('all' + firstRow.toString());
    //print('zemail' + firstRow['zemail']);

    if (firstRow['zemail'] == userController.text &&
        firstRow['xpassword'] == passController.text) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Homepage(
                    isConnected: isConnected,
                    zemail: userController.text,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Wrong Username/Password ",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  Future<List<LoginModel>>? futurePost;

  @override
  void initState() {
    super.initState();
    createBox();
    internetCheck();
    loginStatus();
  }

  //hive createBox function
  void createBox() async {
    _box = await Hive.openBox("RememberMe");
    getData();
  }

  //save hive data
  getData() {
    if (_box.get('user') != null) {
      userController.text = _box.get('user');
    }
    if (_box.get('password') != null) {
      passController.text = _box.get('password');
    }
  }

  //Login button e press korle userID and password ta niye nibe
  void login() {
    if (isChecked) {
      _box.put('user', userController.text);
      _box.put('password', passController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xffFFFFFF),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo/background_image.jpeg"),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo/gazi_logo.jpeg',
                          width: MediaQuery.of(context).size.width / 1.2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: AppColor.appBarColor, width: 2)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: userController,
                              style: GoogleFonts.bakbakOne(
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              onChanged: (input) {
                                zemail = input;
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.person),
                                  hintText: "Enter user id",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: AppColor.appBarColor, width: 2)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: passController,
                              style: GoogleFonts.bakbakOne(
                                //fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              obscureText: _obsecureText,
                              onChanged: (input) {
                                xpassword = input;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter password",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  // add padding to adjust icon
                                  child: IconButton(
                                    icon: Icon(
                                      _obsecureText
                                          ? FontAwesomeIcons.solidEye
                                          : FontAwesomeIcons.solidEyeSlash,
                                    ),
                                    onPressed: () {
                                      toggle();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(
                              () {
                                isChecked = value!;
                              },
                            );
                          },
                        ),
                        Text(
                          "Remember Me",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bakbakOne(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 55.0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      /*gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ],
                      ),*/
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.appBarColor,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            isLoading = true;
                          },
                        );
                        Future.delayed(Duration(seconds: 3), () {
                          if (userController.text == '' ||
                              passController.text == '') {
                            Get.snackbar('Error', 'User Invalid',
                                backgroundColor: Color(0XFF8CA6DB),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            loginFunction();
                            login();
                            // submitData(userController.text, passController.text);
                          }
                        });
                      },
                      child: isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.bakbakOne(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Powered By ",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/Business.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
