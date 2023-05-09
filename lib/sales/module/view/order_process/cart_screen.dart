import 'package:flutter/material.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import 'package:get/get.dart';
import '../../../widget/big_text.dart';
import '../../../widget/cart_products.dart';
import '../../../widget/cart_total.dart';
import '../../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartController cartController = Get.find<CartController>();
  String xcus;
  String xOrg;
  String xterritory;

  CartScreen({
    Key? key,
    required this.xcus,
    required this.xOrg,
    required this.xterritory,
  }) : super(key: key);

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
            text: 'Your Cart',
            color: AppColor.defWhite,
            size: 25,
          ),
          actions: [

          ],
        ),
        body: SingleChildScrollView(
          child: cartController.addedProducts.isEmpty
              ? const Center(
                child: NoDataPage(
                  text: 'No products added yet !',
                ),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartProducts(),
                  CartTotal(
                    xCus: xcus,
                    xOrg: xOrg,
                    xterritory: xterritory,
                  )
                ],
          ),
        )
      ),
    );
  }
}
