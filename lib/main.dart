import 'package:flutter/material.dart';
import 'package:gazi_sales_app/screen/splash_screen.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gazi_Sales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splashpage(),
    );
  }
}
