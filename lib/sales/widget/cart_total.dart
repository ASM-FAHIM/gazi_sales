import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/widget/small_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    print('=======${cartController.addedProducts.length}');
    print('=======${cartController.addedProducts}');
    return SingleChildScrollView(
      child: Obx(() =>
      cartController.addedProducts.isEmpty
          ? Container()
          : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(MdiIcons.currencyBdt, size: 22, color: Colors.red,),
                    BigText(text: '${cartController.totalPrice.value.toStringAsFixed(2)}', size: 22, color: Colors.red,),
                  ],
                ),
              ),
              SizedBox(height:  20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: Dimensions.height50,
                    width:  Dimensions.height150 - Dimensions.height20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 5,
                              offset: Offset(0, 0)
                          )
                        ]
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.appBarColor,
                      ),
                      onPressed: () async{
                        print('The xsp value from dealer table is: ${loginController.xsp.value}');
                        showDialog(context: context, builder: (BuildContext context){
                          return ReusableAlert(cartController: cartController, xCus: xCus, xOrg: xOrg,);
                        });
                      },
                      child:  cartController.isSync.value
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,),
                      )
                          : BigText(text: 'Place order', color: AppColor.defWhite,),
                    ),
                  ),
                  SizedBox(width: 20,),

                  Container(
                    height: Dimensions.height50,
                    width:  Dimensions.height150 - Dimensions.height10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 5,
                              offset: Offset(0, 0)
                          )
                        ]
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ElevatedButton(
                      onPressed: () async{
                        //print('The xsp value from dealer table is: ${loginController.xsp.value}');
                        await cartController.saveOrder(xCus, xOrg, 'Open');
                      },
                      style: ElevatedButton.styleFrom(primary: AppColor.appBarColor,),
                      child: cartController.isPlaced.value
                          ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,),
                          )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(text: 'Save order', color: AppColor.defWhite,),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),),
    );
  }
}

class ReusableAlert extends StatelessWidget {
  const ReusableAlert({
    Key? key,
    required this.cartController,
    required this.xOrg,
    required this.xCus,
  }) : super(key: key);

  final CartController cartController;
  final String xOrg;
  final String xCus;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Instant upload',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Do you want to upload order now?',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'No',
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
            'Yes',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async{
            Navigator.pop(context);
            await cartController.placeOrder(xCus, xOrg, context);
          },
        ),
      ],
    );
  }
}