import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/widget/small_text.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
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
          text: 'Discount',
          color: AppColor.defWhite,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Dimensions.height650 + Dimensions.height20,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  BigText(text: 'GAZI VERTICAL TANKS 1500 Ltr-GREEN'),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: 'General discount',
                                size: 14,
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: 'General discount amount',
                                size: 14,
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: 'Additional discount %',
                                size: 14,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(right: 10),
                                height: 48,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                        color: Colors.grey.withOpacity(0.5),
                                      )
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {},
                                        decoration: InputDecoration(
                                            hintText: "Enter discount",
                                            hintStyle: TextStyle(
                                                color: Colors.black12),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                text: 'Additional discount amount',
                                size: 14,
                              ),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SmallText(text: 'Trade price'),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(text: 'Line amount'),
                              Text(
                                '0.00',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: Dimensions.height50,
                  width: Dimensions.height150 - Dimensions.height20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, //New
                            blurRadius: 5,
                            offset: Offset(0, 0))
                      ]),
                  clipBehavior: Clip.hardEdge,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.appBarColor,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: BigText(
                      text: 'Done',
                      color: AppColor.defWhite,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
