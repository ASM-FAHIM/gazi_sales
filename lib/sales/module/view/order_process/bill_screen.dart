import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/module/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';

class BillDetailsScreen extends StatefulWidget {
  String soNum;
  String tsoId;
  String zID;
  String cartId;
  String xOrg;
  String xCus;

  BillDetailsScreen(
      {required this.soNum,
      required this.tsoId,
      required this.cartId,
      required this.zID,
      required this.xOrg,
      required this.xCus,
      Key? key})
      : super(key: key);

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    cartController.getAddedProducts(widget.zID, widget.soNum);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      height: size.height / 1.35,
                      child: ListView.builder(
                          itemCount: cartController.listOfAddedProducts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: size.height / 4.8,
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColor.appBarColor.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    cartController
                                        .listOfAddedProducts[index].itemName,
                                    style: const TextStyle(
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
                                    'Quantity Ordered: ${cartController.listOfAddedProducts[index].xqtyreq}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if ('${cartController.listOfAddedProducts[index].xpartno}' ==
                                      'No') ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: size.height / 22,
                                              child: Text(
                                                'Discount Rate\n${cartController.listOfAddedProducts[index].xdisc} %',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: size.height / 22,
                                              child: Text(
                                                'Discount\n${cartController.listOfAddedProducts[index].xdiscamt}',
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
                                              height: size.height / 22,
                                              child: Text(
                                                'Additional Discount\n${cartController.listOfAddedProducts[index].xdiscad} %',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: size.height / 22,
                                              child: Text(
                                                'Additional Discount Amount\n${cartController.listOfAddedProducts[index].xdiscadamt}',
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
                                              height: size.height / 22,
                                              child: Text(
                                                'Rate\n${cartController.listOfAddedProducts[index].xrate}',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: size.height / 22,
                                              child: Text(
                                                'Line Amount\n${cartController.listOfAddedProducts[index].xlineamt}',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ] else ...[
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.maxFinite,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Accessories of',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.appBarColor),
                                            ),
                                            Text(
                                              '${cartController.listOfAddedProducts[index].masterItemName}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.appBarColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /*Obx(() {
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
                                  }),*/
                                  BigText(
                                    text:
                                        'Total = ${cartController.totalAmount} Tk.',
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                              soNum: widget.soNum,
                                              zid: widget.zID,
                                              tsoId: widget.tsoId,
                                            );
                                          });
                                    },
                                    child: cartController.isConfirmed.value
                                        ? const CircularProgressIndicator(
                                            color: AppColor.defWhite,
                                          )
                                        : BigText(
                                            text: 'Confirm',
                                            color: AppColor.defWhite,
                                            size: 14,
                                          ),
                                  ),
                                ),
                                /*SizedBox(
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
                                ),*/
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
    required this.soNum,
    required this.zid,
    required this.tsoId,
  }) : super(key: key);

  final CartController cartController;
  final String xOrg;
  final String xCus;
  final String soNum;
  final String zid;
  final String tsoId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm order',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Do you want to confirm order?',
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
            await cartController.confirmOrder(zid, soNum, tsoId);
          },
        ),
      ],
    );
  }
}
