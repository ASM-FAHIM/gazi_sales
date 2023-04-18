import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../constant/colors.dart';
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
          title: BigText(text: "Gift & Promo", color: AppColor.defWhite, size: 25,),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Container(
            child: Obx(() =>
                dashboardController.listFetched.value
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(color: AppColor.appBarColor,),
                            ),
                            Text('Loading...'),
                          ],
                        ),
                      )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dashboardController.listGiftPromo.isEmpty
                            ?   const NoDataPage(text: 'Sorry! no gift available right now')
                            :   Expanded(
                            child: ListView.builder(
                                itemCount: dashboardController.listGiftPromo.length,
                                itemBuilder: (context, index) {
                                  var giftPromo = dashboardController.listGiftPromo[index];
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              BigText(text: '${giftPromo['itemName']}', size: 16,),
                                              BigText(text: '${giftPromo['type']}', size: 15,),
                                              SmallText(text: '${giftPromo['giftName']}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            )
                        ),
                      ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
