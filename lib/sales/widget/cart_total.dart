import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/order_process/bill_screen.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../module/controller/cart_controller.dart';
import '../module/controller/login_controller.dart';
import 'big_text.dart';

class CartTotal extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  LoginController loginController = Get.find<LoginController>();
  String xCus;
  String xOrg;
  String xterritory;

  CartTotal({
    Key? key,
    required this.xCus,
    required this.xOrg,
    required this.xterritory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      if (cartController.addedProducts.isEmpty) {
        return Container();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: Dimensions.height50,
              width: Dimensions.height150 - Dimensions.height20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
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
                onPressed: cartController.addedProducts.isEmpty
                    ? null
                    : () {
                        Get.to(() => const BillDetailsScreen());
                      },
                child: cartController.isSync.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : BigText(
                        text: 'Process',
                        color: AppColor.defWhite,
                      ),
              ),
            ),
            /*Container(
                  padding: EdgeInsets.only(right: 30),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        MdiIcons.currencyBdt,
                        size: 22,
                        color: Colors.red,
                      ),
                      BigText(
                        text:
                            '${cartController.totalPrice.value.toStringAsFixed(2)}',
                        size: 22,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),*/
            /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Dimensions.height50,
                      width: Dimensions.height150 - Dimensions.height20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
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
                        onPressed: () async {
                          Get.to(() => BillDetailsScreen());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ReusableAlert(
                                  cartController: cartController,
                                  xCus: xCus,
                                  xOrg: xOrg,
                                );
                              });
                        },
                        child: cartController.isSync.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : BigText(
                                text: 'Place order',
                                color: AppColor.defWhite,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: Dimensions.height50,
                      width: Dimensions.height150 - Dimensions.height10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 5,
                                offset: Offset(0, 0))
                          ]),
                      clipBehavior: Clip.hardEdge,
                      child: ElevatedButton(
                        onPressed: () async {
                          //print('The xsp value from dealer table is: ${loginController.xsp.value}');
                          await cartController.saveOrder(xCus, xOrg, 'Open');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.appBarColor,
                        ),
                        child: cartController.isPlaced.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: 'Save order',
                                    color: AppColor.defWhite,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),*/
          ],
        );
      }
    });
  }
}
