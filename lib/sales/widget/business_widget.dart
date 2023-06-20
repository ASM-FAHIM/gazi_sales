import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/colors.dart';

import 'big_text.dart';

class BusinessWidget extends StatelessWidget {
  String businessName;
  String imgPath;
  double? height;
  double? width;
  BoxFit? fit;
  VoidCallback onPressed;

  BusinessWidget({
    required this.businessName,
    required this.imgPath,
    this.height,
    this.width,
    this.fit,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.8,
      width: MediaQuery.of(context).size.width / 2.8,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.appBarColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imgPath),
              height: height,
              width: width,
              fit: fit,
            ),
            SizedBox(
              height: 10,
            ),
            BigText(
              text: businessName,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
