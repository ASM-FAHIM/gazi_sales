import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/module/controller/deposit_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/cart_controller.dart';

class DepositHistoryScreen extends StatefulWidget {
  const DepositHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DepositHistoryScreen> createState() => _DepositHistoryScreenState();
}

class _DepositHistoryScreenState extends State<DepositHistoryScreen> {
  //CartController cartController = Get.put(CartController());
  DepositController depositController = Get.put(DepositController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    depositController.getOpenDeposit();
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
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              )),
          title: BigText(
            text: "Deposit History",
            color: AppColor.defWhite,
            size: 25,
          ),
          actions: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  depositController.depositSubmission();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: depositController.isSubmitted.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.defWhite,
                          ),
                        )
                      : const Icon(
                          MdiIcons.upload,
                          size: 30,
                        ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Obx(() => depositController.isLoading4.value
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
              : ListView.builder(
                  itemCount: depositController.openDeposit.length,
                  itemBuilder: (context, index) {
                    var openDepo = depositController.openDeposit[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: Dimensions.height50,
                              width: double.maxFinite,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              decoration: const BoxDecoration(
                                  color: Color(0xff14AAA2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Deposit no : ${openDepo["id"]}',
                                    //overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ReusableAlert(
                                              depositController:
                                                  depositController,
                                              depoID: openDepo["depositID"],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      MdiIcons.deleteCircle,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                  /*SmallText(
                                    text: '${openDepo['xamount']} Tk.',
                                    size: 18,
                                    color: AppColor.defWhite,
                                  ),*/
                                ],
                              ),
                            ),
                            Container(
                              height: Dimensions.height120,
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          DateFormat('yMd').format(
                                              DateTime.parse(
                                                  openDepo['xdate'])),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${openDepo['xcusname']}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                      BigText(
                                        text: '${openDepo['xamount']} Tk.',
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  Text('CUS ID: ${openDepo['xcus']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                  Text('Invoice type: ${openDepo['xarnature']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  Text('Bank name: ${openDepo['xbank']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  Text(
                                      'Mode of payment: ${openDepo['xpaymenttype']}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            // Container(
                            //   height: 50,
                            //   width: double.maxFinite,
                            //   padding:
                            //       const EdgeInsets.only(left: 10, right: 10),
                            //   decoration: const BoxDecoration(
                            //       borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(20.0),
                            //     bottomRight: Radius.circular(20.0),
                            //   )),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceAround,
                            //     children: [
                            //       ElevatedButton(
                            //         style: ElevatedButton.styleFrom(
                            //           primary: AppColor.defRed,
                            //         ),
                            //         onPressed: () {
                            //           showDialog(
                            //               context: context,
                            //               builder: (BuildContext context) {
                            //                 return ReusableAlert(
                            //                   cartController: cartController,
                            //                   cartID: cartHeader['cartID'],
                            //                 );
                            //               });
                            //         },
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           children: [
                            //             SmallText(
                            //               text: 'Delete',
                            //               size: 15,
                            //               color: Colors.white,
                            //             ),
                            //             const Icon(
                            //               MdiIcons.delete,
                            //               color: Colors.white,
                            //               size: 20,
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //       ElevatedButton(
                            //         style: ElevatedButton.styleFrom(
                            //           primary: Colors.teal,
                            //         ),
                            //         onPressed: () {
                            //           // cartController.getCartHeaderDetailsList(
                            //           //     '${cartHeader['cartID']}');
                            //           // Get.to(() => HistoryDetails(
                            //           //     cartId: '${cartHeader['cartID']}'));
                            //         },
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           children: [
                            //             SmallText(
                            //               text: 'Details',
                            //               size: 15,
                            //               color: Colors.white,
                            //             ),
                            //             const Icon(
                            //               MdiIcons.arrowRightBold,
                            //               color: Colors.white,
                            //               size: 20,
                            //             )
                            //           ],
                            //         ),
                            //       ),
                            //       ElevatedButton(
                            //         style: ElevatedButton.styleFrom(
                            //           primary: Colors.lightBlue,
                            //         ),
                            //         onPressed: () {
                            //           showDialog(
                            //               context: context,
                            //               builder: (BuildContext context) {
                            //                 return UploadSingleCartAlert(
                            //                   cartController: cartController,
                            //                   cartID: cartHeader['cartID'],
                            //                 );
                            //               });
                            //         },
                            //         child: cartController.isLoading.value
                            //             ? const Center(
                            //                 child: CircularProgressIndicator(
                            //                   color: Colors.white,
                            //                 ),
                            //               )
                            //             : Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   SmallText(
                            //                     text: 'Upload',
                            //                     size: 15,
                            //                     color: Colors.white,
                            //                   ),
                            //                   const Icon(
                            //                     MdiIcons.upload,
                            //                     color: Colors.white,
                            //                     size: 20,
                            //                   )
                            //                 ],
                            //               ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  })),
        ),
      ),
    );
  }
}

//for delete alert
class ReusableAlert extends StatelessWidget {
  const ReusableAlert({
    Key? key,
    required this.depositController,
    required this.depoID,
  }) : super(key: key);

  final DepositController depositController;
  final String depoID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete cart',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Do you want to delete this deposit?',
              style: GoogleFonts.roboto(
                fontSize: 15,
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
            await depositController.deleteFromDeposit(depoID);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

/*//for upload single cart alert
class UploadSingleCartAlert extends StatelessWidget {
  const UploadSingleCartAlert({
    Key? key,
    required this.cartController,
    required this.cartID,
  }) : super(key: key);

  final CartController cartController;
  final String cartID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Upload cart',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Do you want to upload this cart?',
              style: GoogleFonts.roboto(
                fontSize: 15,
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
            await cartController.singleCartUpload(cartID);
          },
        ),
      ],
    );
  }
}*/
