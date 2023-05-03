import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/colors.dart';
import '../../widget/big_text.dart';

class DepositEntryScreen extends StatefulWidget {
  const DepositEntryScreen({Key? key}) : super(key: key);

  @override
  State<DepositEntryScreen> createState() => _DepositEntryScreenState();
}

class _DepositEntryScreenState extends State<DepositEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Deposit entry",
          color: AppColor.defWhite,
          size: 25,
        ),
      ),
      body: Container(
        height: 400,
        width: 400,
      ),
    );
  }
}
