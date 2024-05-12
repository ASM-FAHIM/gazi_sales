import 'package:flutter/material.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import 'package:get/get.dart';
import '../../../widget/big_text.dart';
import '../../../widget/cart_products.dart';
import '../../../widget/cart_total.dart';
import '../../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final CartController _cartController = Get.find();
  final String xcus;
  final String xOrg;
  final String xterritory;
  final String delDisc;

  CartScreen({
    Key? key,
    required this.xcus,
    required this.xOrg,
    required this.xterritory,
    required this.delDisc,
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
              text: 'Selected Products',
              color: AppColor.defWhite,
              size: 25,
            ),
            actions: [],
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
                        delDisc: delDisc,
                      )
                    ],
                  ),
          )),
    );
  }
}
