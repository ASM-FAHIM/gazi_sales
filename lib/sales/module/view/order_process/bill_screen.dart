import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/module/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';

class BillDetailsScreen extends StatefulWidget {
  String cartId;
  String xOrg;
  String xCus;

  BillDetailsScreen(
      {required this.cartId, required this.xOrg, required this.xCus, Key? key})
      : super(key: key);

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
                      height: Dimensions.height650 - Dimensions.height50,
                      child: ListView.builder(
                          itemCount: cartController.listOfAddedProducts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 170,
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
                                        fontSize: 13),
                                  ),
                                  /*Text(
                                    " ${cartController.listOfAddedProducts[index]["xqty"]} X ${cartController.listOfAddedProducts[index]["xrate"]} = ${cartController.listOfAddedProducts[index]["xlineamt"]} Tk.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),*/
                                  Text(
                                    'Quantity Ordered: ${cartController.listOfAddedProducts[index]["xqty"]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 8,
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
                                              'Discount Rate\n${cartController.listOfAddedProducts[index]["xdisc"]} %',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'Discount\n${cartController.listOfAddedProducts[index]["xdiscamt"]}',
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
                                              'Additional Discount\n${cartController.listOfAddedProducts[index]["xdiscad"]} %',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'Additional Discount Amount\n${cartController.listOfAddedProducts[index]["xdiscadamt"]}',
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
                                              'Rate\n${cartController.listOfAddedProducts[index]["xrate"]}',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 35,
                                            child: Text(
                                              'Line Amount\n${cartController.listOfAddedProducts[index]["xlineamt"]}',
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
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    return Row(
                                      children: [
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  Colors.black),
                                          child: Checkbox(
                                            value:
                                                cartController.isChecked.value,
                                            activeColor: AppColor.appBarColor,
                                            checkColor: AppColor.defWhite,
                                            onChanged: (value) {
                                              if (value != null) {
                                                cartController.isChecked.value =
                                                    value;
                                                cartController.incentive.value =
                                                    value ? 'Yes' : 'No';
                                              }
                                              print(
                                                  'Incentive applicable: ${cartController.incentive.value}');
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Incentive applicable",
                                          style: GoogleFonts.urbanist(
                                            // color: mainBlackColor,
                                            fontSize: Dimensions.fontBigS16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  BigText(
                                    text: '${cartController.totalAmount} Tk.',
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ReusableAlert(
                                              cartController: cartController,
                                              xCus: widget.xCus,
                                              xOrg: widget.xOrg,
                                            );
                                          });
                                    },
                                    child: cartController.isSync.value
                                        ? const CircularProgressIndicator(
                                            color: AppColor.defWhite,
                                          )
                                        : BigText(
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
                                      await cartController
                                          .saveOrder(widget.cartId);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColor.appBarColor,
                                    ),
                                    child: cartController.isPlaced.value
                                        ? const CircularProgressIndicator(
                                            color: AppColor.defWhite,
                                          )
                                        : BigText(
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
            await cartController.placeOrder(xCus, xOrg, context);
          },
        ),
      ],
    );
  }
}
