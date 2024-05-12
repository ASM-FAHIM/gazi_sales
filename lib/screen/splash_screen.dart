import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'login_page.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({Key? key}) : super(key: key);

  @override
  _SplashpageState createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {

  // bool isConnected = true;
  // Future<void> internetCheck() async {
  //
  //   final StreamSubscription<InternetConnectionStatus> listener =
  //   InternetConnectionChecker().onStatusChange.listen(
  //         (InternetConnectionStatus status) async {
  //       switch (status) {
  //         case InternetConnectionStatus.connected:
  //           setState(() {
  //             isConnected = true;
  //           });
  //           print("Conn Status"+ isConnected.toString());
  //           break;
  //         case InternetConnectionStatus.disconnected:
  //           setState(() {
  //             isConnected = false;
  //           });
  //           print("Conn Status"+ isConnected.toString());
  //           break;
  //       }
  //     },
  //   );
  //
  //   // close listener after 30 seconds, so the program doesn't run forever
  //   await Future<void>.delayed(const Duration(seconds: 30));
  //   await listener.cancel();
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   internetCheck();
  //   print("spla");
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: AnimatedSplashScreen(
        duration: 1000,
        splash: Image.asset(
          "assets/images/loading.gif",
        ),
        splashIconSize: double.infinity,
        nextScreen: const Login_page(),
        backgroundColor: Colors.white,
      )),
    );
  }
}
