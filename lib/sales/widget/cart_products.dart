import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/sales/module/view/order_process/cart_accessories_screen.dart';
import 'package:gazi_sales_app/sales/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../base/no_data_page.dart';
import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../module/controller/cart_controller.dart';
import 'big_text.dart';

class CartProducts extends StatelessWidget {
  final CartController controller = Get.find();

  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a map to store the text editing controllers
    final Map<String, TextEditingController> qtyControllers = {};

    // Populate the map with controllers for each item
    for (var item in controller.addedProducts) {
      final itemName = item[0];
      qtyControllers[itemName] = TextEditingController(text: item[1]);
    }
    return GetBuilder<CartController>(builder: (controller) {
      return Container(
        height: Dimensions.height650 + Dimensions.height20,
        child: controller.addedProducts.isEmpty
            ? const Center(
                child: NoDataPage(
                  text: 'No products added yet !',
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.addedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartProductsCard(
                    controller: controller,
                    index: index,
                    xItem: controller.addedProducts[index][0],
                    qty: qtyControllers[controller.addedProducts[index][0]]!,
                    pDesc: controller.addedProducts[index][2],
                    pPrice: controller.addedProducts[index][3],
                    xUnit: controller.addedProducts[index][4],
                    xDisc: controller.addedProducts[index][5],
                  );
                }),
      );
    });
  }
}

class CartProductsCard extends StatelessWidget {
  final CartController controller;
  final int index;
  final String xItem;
  final TextEditingController qty;
  final String pDesc;
  final String xDisc;
  final String pPrice;
  final String xUnit;

  const CartProductsCard({
    Key? key,
    required this.controller,
    required this.index,
    required this.xItem,
    required this.qty,
    required this.pDesc,
    required this.xDisc,
    required this.pPrice,
    required this.xUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: Dimensions.height120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //color: Colors.green,
          boxShadow: const [
            BoxShadow(
              // color: Colors.greenAccent[200],
              offset: Offset(
                0.01,
                0.01,
              ),
              blurRadius: 1.10,
              spreadRadius: .05,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Dimensions.height70 + Dimensions.height05,
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            pDesc,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SmallText(
                            text: "Unit: $xUnit",
                            size: 12,
                            color: Colors.red,
                          ),
                          /*SmallText(
                            text: "Discount: $xDisc % ?? 0.0",
                            size: 12,
                            color: Colors.red,
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: Dimensions.height120,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.decrement(xItem);
                            final qtyValue = controller.addedProducts
                                .firstWhereOrNull(
                                    (item) => item[0] == xItem)?[1];
                            if (qtyValue == null) {
                              qty.text = '1';
                            } else {
                              qty.text = qtyValue;
                            }
                          },
                          alignment: Alignment.center,
                          icon: const Icon(
                            MdiIcons.minusCircle,
                            size: 30,
                            color: AppColor.appBarColor,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height50,
                          width: Dimensions.height70,
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'^0')),
                              FilteringTextInputFormatter.deny(RegExp(r'-')),
                              FilteringTextInputFormatter.deny(RegExp(r'\.')),
                              FilteringTextInputFormatter.deny(RegExp(r',')),
                              FilteringTextInputFormatter.deny(RegExp(r'\+')),
                              FilteringTextInputFormatter.deny(RegExp(r'\*')),
                              FilteringTextInputFormatter.deny(RegExp(r'/')),
                              FilteringTextInputFormatter.deny(RegExp(r'=')),
                              FilteringTextInputFormatter.deny(RegExp(r'%')),
                              FilteringTextInputFormatter.deny(RegExp(r' ')),
                            ],
                            controller: qty,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                  color: Colors.green,
                                ),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                              //border: OutlineInputBorder(),
                              hintText: qty.text,
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            onSubmitted: (value) {
                              if (value.isEmpty) {
                                qty.text = '1';
                                controller.updateQuantity(
                                    xItem, int.parse(value));
                              } else {
                                controller.updateQuantity(
                                    xItem, int.parse(value));
                              }
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.increment(xItem);
                            qty.text = controller.addedProducts
                                .firstWhere((item) => item[0] == xItem)[1];
                          },
                          icon: const Icon(
                            MdiIcons.plusCircle,
                            size: 30,
                            color: AppColor.appBarColor,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: Dimensions.height35,
                      width: Dimensions.height120 - Dimensions.height20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 1,
                                offset: Offset(0, 0))
                          ]),
                      clipBehavior: Clip.hardEdge,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.disColor,
                        ),
                        onPressed: () async {
                          //Route to next page
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ReusableAlert(
                                  cartController: controller,
                                  index: index,
                                  itemCode: xItem,
                                  xorg: pDesc,
                                );
                              });
                          //Get.to(() => const DiscountScreen());
                        },
                        child: BigText(
                          text: 'Discount',
                          color: AppColor.defWhite,
                          size: 14,
                        ),
                      ),
                    ),
                    Container(
                      height: Dimensions.height35,
                      width: Dimensions.height120 - Dimensions.height20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 1,
                                offset: Offset(0, 0))
                          ]),
                      clipBehavior: Clip.hardEdge,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.comColor,
                        ),
                        onPressed: () async {
                          //Route to next page
                          Get.to(() => CartAccessoriesScreen(
                                productCode: xItem,
                              ));
                        },
                        child: BigText(
                          text: 'Accessories',
                          color: AppColor.defWhite,
                          size: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableAlert extends StatelessWidget {
  ReusableAlert({
    Key? key,
    required this.cartController,
    required this.index,
    required this.xorg,
    required this.itemCode,
  }) : super(key: key);

  final CartController cartController;
  final int index;
  final String xorg;
  final String itemCode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Additional discount',
        style: GoogleFonts.urbanist(
            fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black54),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              itemCode,
              style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54),
            ),
            Text(
              xorg,
              style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 45,
                width: 100,
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'-')),
                    FilteringTextInputFormatter.deny(RegExp(r'\.')),
                    FilteringTextInputFormatter.deny(RegExp(r',')),
                    FilteringTextInputFormatter.deny(RegExp(r'\+')),
                    FilteringTextInputFormatter.deny(RegExp(r'\*')),
                    FilteringTextInputFormatter.deny(RegExp(r'/')),
                    FilteringTextInputFormatter.deny(RegExp(r'=')),
                    FilteringTextInputFormatter.deny(RegExp(r'%')),
                    FilteringTextInputFormatter.deny(RegExp(r' ')),
                  ],
                  textAlign: TextAlign.center,
                  controller: cartController.discount,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) async {
                    if (cartController.discount.text.isEmpty) {
                      Navigator.pop(context);
                    } else {
                      //await cartController.updateItemWiseCartDetails(itemCode, cartController.quantity.text, price, zID);
                      Navigator.pop(context);
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                    border: OutlineInputBorder(),
                    hintText: "Additional discount %",
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                )),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Cancel',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text(
            'Add',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async {
              if (cartController.discount.text.isEmpty) {
              Navigator.pop(context);
              } else {
              cartController.updateDiscount(index, cartController.discount.text); // Update the discount
              Navigator.pop(context);
              }
              cartController.discount.clear();
              print(
                  'The updated selected products are: ${cartController.addedProducts}');
              Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
