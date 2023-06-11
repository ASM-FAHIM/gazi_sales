import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/history/deposit_history_screen.dart';
import 'package:gazi_sales_app/sales/module/view/history/order_history_screen.dart';
import 'package:get/get.dart';

import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/business_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
              )),
          title: BigText(
            text: "History",
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BusinessWidget(
                    businessName: 'Sales History',
                    imgPath: 'assets/images/sale.png',
                    height: 100,
                    onPressed: () {
                      Get.to(() => OrderHistoryScreen());
                    },
                  ),
                  BusinessWidget(
                    businessName: 'Deposit History',
                    imgPath: 'assets/images/bank.png',
                    height: 100,
                    onPressed: () {
                      Get.to(() => DepositHistoryScreen());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
