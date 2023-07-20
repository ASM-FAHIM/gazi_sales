import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home_page.dart';
import '../../sales/constant/colors.dart';
import '../../sales/widget/big_text.dart';

class ProductionProcessScreen extends StatefulWidget {
  const ProductionProcessScreen({Key? key}) : super(key: key);

  @override
  State<ProductionProcessScreen> createState() =>
      _ProductionProcessScreenState();
}

class _ProductionProcessScreenState extends State<ProductionProcessScreen> {
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
            text: 'Production Module',
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    home_page_buttons(
                      imageName: 'assets/images/production1.png',
                      buttonName: 'Production processing',
                      onPressed: () {

                      },
                    ),
                    /*home_page_buttons(
                      imageName: 'assets/images/attendance.png',
                      buttonName: 'Attendance',
                      onPressed: () {
                      },
                    ),*/
                  ],
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    home_page_buttons(
                      imageName: 'assets/images/notification.png',
                      buttonName: 'Production processing',
                      onPressed: () {

                      },
                    ),
                    home_page_buttons(
                      imageName: 'assets/images/attendance.png',
                      buttonName: 'Attendance',
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
