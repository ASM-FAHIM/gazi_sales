import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/module/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';

class BillDetailsScreen extends StatefulWidget {
  String cartId;

  BillDetailsScreen({required this.cartId, Key? key}) : super(key: key);

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    cartController.getAddedProducts(widget.cartId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
              cartController.listOfAddedProducts.clear();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            ),
          ),
          title: BigText(
            text: 'Checkout',
            color: AppColor.defWhite,
            size: 25,
          ),
          actions: [],
        ),
        body: Obx(
          () => cartController.isValueLoaded.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        child: const CircularProgressIndicator(
                          color: AppColor.appBarColor,
                        ),
                      ),
                      const Text('Loading...'),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.height650 - Dimensions.height70,
                      child: ListView.builder(
                          itemCount: cartController.listOfAddedProducts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 130,
                              margin: EdgeInsets.all(8.0),
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColor.appBarColor.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${cartController.listOfAddedProducts[index]["xdesc"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    " ${cartController.listOfAddedProducts[index]["xqty"]} X ${cartController.listOfAddedProducts[index]["xrate"]} = ${cartController.listOfAddedProducts[index]["subTotal"]} Tk.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'General discount\n${cartController.listOfAddedProducts[index]["xdisc"]}',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'General discount amount\n${cartController.listOfAddedProducts[index]["xdiscamt"]}',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'Trade price\n${cartController.listOfAddedProducts[index]["xrate"]}',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'Line amount\n${cartController.listOfAddedProducts[index]["xlineamt"]}',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 30),
                              alignment: Alignment.centerRight,
                              child: BigText(
                                text:
                                    'Total amount = ${cartController.totalAmount} Tk.',
                                size: 22,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 30),
                              alignment: Alignment.centerRight,
                              child: BigText(
                                text:
                                    'Total discount = ${cartController.totalDiscount} %.',
                                size: 22,
                                color: Colors.red,
                              ),
                            ),
                            /*Container(
                      padding: EdgeInsets.only(right: 30),
                      alignment: Alignment.centerRight,
                      child: BigText(
                        text: 'Discount amount = 2500 Tk.',
                        size: 22,
                        color: Colors.red,
                      ),
                    ),*/
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: Dimensions.height50,
                                  width: Dimensions.height150 -
                                      Dimensions.height20,
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
                                      Get.back();
                                      /*showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ReusableAlert(
                                    cartController: cartController,
                                    xCus: xCus,
                                    xOrg: xOrg,
                                  );
                                });*/
                                    },
                                    child: BigText(
                                      text: 'Place order',
                                      color: AppColor.defWhite,
                                      size: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: Dimensions.height50,
                                  width: Dimensions.height150 -
                                      Dimensions.height10,
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
                                      // await cartController.saveOrder(xCus, xOrg, 'Open');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColor.appBarColor,
                                    ),
                                    child: BigText(
                                      text: 'Save order',
                                      color: AppColor.defWhite,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
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
          onPressed: () async {
            Navigator.pop(context);
            // await cartController.placeOrder(xCus, xOrg, context);
          },
        ),
      ],
    );
  }
}
