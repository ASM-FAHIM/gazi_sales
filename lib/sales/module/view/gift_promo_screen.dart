import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/dashboard_controller.dart';

class GiftAndPromoScreen extends StatefulWidget {
  const GiftAndPromoScreen({Key? key}) : super(key: key);

  @override
  State<GiftAndPromoScreen> createState() => _GiftAndPromoScreenState();
}

class _GiftAndPromoScreenState extends State<GiftAndPromoScreen> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    dashboardController.getGiftPromoList();
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
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              )),
          title: BigText(
            text: "Gift & Promo",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Container(
            child: Obx(() => dashboardController.listFetched.value
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(
                            color: AppColor.appBarColor,
                          ),
                        ),
                        Text('Loading...'),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dashboardController.listGiftPromo.isEmpty
                          ? const NoDataPage(
                              text: 'Sorry! no gift available right now')
                          : Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      dashboardController.listGiftPromo.length,
                                  itemBuilder: (context, index) {
                                    var giftPromo = dashboardController
                                        .listGiftPromo[index];
                                    return Container(
                                      height: Dimensions.height150,
                                      width: double.infinity,
                                      margin: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: Offset(2,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: Dimensions.height50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  topRight:
                                                      Radius.circular(20.0)),
                                            ),
                                            alignment: Alignment.center,
                                            child: BigText(
                                              text: giftPromo.xtrnnum,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  /*Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      BigText(
                                                        text:
                                                            '${giftPromo["xstype"]}',
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),*/
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        /* SmallText(
                                                            text:
                                                                'Stype : ${giftPromo["xstype"]}',
                                                            size: 16),*/
                                                        SmallText(
                                                            text:
                                                                'Color : ${giftPromo.xcolor}',
                                                            size: 16),
                                                        Row(
                                                          children: [
                                                            SmallText(
                                                                text: 'Slab : ',
                                                                size: 16),
                                                            SmallText(
                                                              text:
                                                                  '(${giftPromo.xfslab} to ',
                                                              size: 16,
                                                              color: AppColor
                                                                  .appBarColor,
                                                            ),
                                                            SmallText(
                                                              text:
                                                                  '${giftPromo.xtslab}) Ltr',
                                                              size: 16,
                                                              color: AppColor
                                                                  .appBarColor,
                                                            ),
                                                          ],
                                                        ),
                                                        SmallText(
                                                            text:
                                                                'Amount : ${giftPromo.xamount} Tk.',
                                                            size: 16),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                    ],
                  )),
          ),
        ),
      ),
    );
  }
}
