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
        height:
        Dimensions.height320 + Dimensions.height200 + Dimensions.height70,
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
              // final itemName = controller.addedProducts[index][0];
              return CartProductsCard(
                controller: controller,
                xItem: controller.addedProducts[index][0],
                qty: qtyControllers[controller.addedProducts[index][0]]!,
                pDesc: controller.addedProducts[index][2],
                pPrice: controller.addedProducts[index][3],
                xUnit: controller.addedProducts[index][4],
              );
            }),
      );
    });
  }
}

class CartProductsCard extends StatelessWidget {
  final CartController controller;
  final String xItem;
  final TextEditingController qty;
  final String pDesc;
  final String pPrice;
  final String xUnit;

  const CartProductsCard(
      {Key? key,
        required this.controller,
        required this.xItem,
        required this.qty,
        required this.pDesc,
        required this.pPrice,
        required this.xUnit,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: Dimensions.height120,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //color: Colors.green,
          boxShadow: const [
            BoxShadow(
              // color: Colors.greenAccent[200],
              offset: Offset(0.01,0.01,),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      pDesc,
                      style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SmallText(text: "Unit: $xUnit", size: 12, color: Colors.red,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(

                          onPressed: (){
                            controller.decrement(xItem);
                            final qtyValue = controller.addedProducts
                                .firstWhere((item) => item[0] == xItem)[1];
                            if (qtyValue.isEmpty) {
                              qty.text = '1';
                            } else {
                              qty.text = qtyValue;
                            }
                          },
                          alignment: Alignment.center,
                          icon: const Icon(
                            MdiIcons.minusCircle,
                            size: 35,
                            color: AppColor.appBarColor,
                          ),
                        ),
                        SizedBox(width: 20,),
                        SizedBox(
                          height: 50,
                          width: 70,
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
                                borderSide: BorderSide(width: 1.5, color: Colors.green,),
                                borderRadius: BorderRadius.circular(5.5),
                              ),
                              border: OutlineInputBorder(),
                              hintText: qty.text,
                              hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
                            ),
                            onSubmitted: (value) {
                              if(value.isEmpty){
                                qty.text = '1';
                                controller.updateQuantity(xItem, int.parse(value));
                              }else{
                                controller.updateQuantity(xItem, int.parse(value));
                              }
                            },
                          ),
                        ),
                        // Text('${qty}',
                        //   style: TextStyle(
                        //       fontFamily: GoogleFonts.poppins().fontFamily,
                        //       fontSize: 20),
                        // ),
                        SizedBox(width: 20,),
                        IconButton(
                          onPressed: (){
                            controller.increment(xItem);
                            qty.text = controller.addedProducts
                                .firstWhere((item) => item[0] == xItem)[1];
                          },
                          icon: const Icon(
                            MdiIcons.plusCircle,
                            size: 35,
                            color: AppColor.appBarColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: Dimensions.height120,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.currencyBdt, size: 15, color: Colors.red,),
                      SmallText(text: pPrice, size: 16, color: Colors.red,),
                      SizedBox(width: 10,),
                    ],
                  ),

                  Container(
                    height: Dimensions.height30,
                    width:  Dimensions.height120 - Dimensions.height20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 1,
                              offset: Offset(0, 0)
                          )
                        ]
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0.5),
                      ),
                      onPressed: () async{
                        //Route to next page
                        Get.to(()=> CartAccessoriesScreen(productCode: xItem,));
                      },
                      child: BigText(text: 'Accessories', color: AppColor.defWhite, size: 14,),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}