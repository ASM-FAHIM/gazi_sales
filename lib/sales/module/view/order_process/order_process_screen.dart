import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/order_process/product_list_screen.dart';
import 'package:gazi_sales_app/sales/module/view/order_process/product_type_selection_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/login_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  LoginController loginController = Get.find<LoginController>();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardController.getDealerList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
              onTap: () async {
                Get.back();
                await dashboardController.getDashboardValues();
                // await dashboardController.countDealerVisitTable();
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              )),
          title: BigText(
            text: "Dealers",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx(() {
          return dashboardController.isLoading1.value
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
                      const Text('Loading...')
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColor.appBarColor,
                            )),
                        onChanged: (value) =>
                            dashboardController.runFilter(value),
                      ),
                      Obx(() {
                        return Expanded(
                          child: dashboardController.isLoading5.value
                              ? Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10.0),
                                        child: const CircularProgressIndicator(
                                          color: AppColor.appBarColor,
                                        ),
                                      ),
                                      const Text('Loading...')
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: dashboardController
                                      .foundDealerList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Container(
                                        height: Dimensions.height70 +
                                            Dimensions.height20,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColor.appBarColor,
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Get.to(
                                                () => ProductTypeSelectScreen(
                                                      xCus: dashboardController
                                                              .foundDealerList[
                                                          index]['xcus'],
                                                      xOrg: dashboardController
                                                              .foundDealerList[
                                                          index]['xorg'],
                                                      xGcus: dashboardController
                                                              .foundDealerList[
                                                          index]['xgcus'],
                                                      xTerritory: dashboardController
                                                              .foundDealerList[
                                                          index]['xterritory'],
                                                      delDisc: dashboardController
                                                              .foundDealerList[
                                                          index]['xdisc'],
                                                    ));
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  BigText(
                                                    text: dashboardController
                                                            .foundDealerList[
                                                        index]['xorg'],
                                                    size: 16,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            MdiIcons.home,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            child: SmallText(
                                                              text: dashboardController
                                                                      .foundDealerList[
                                                                  index]['xmadd'],
                                                              size: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                MdiIcons
                                                                    .account,
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              SmallText(
                                                                text: dashboardController
                                                                        .foundDealerList[
                                                                    index]['xcus'],
                                                                size: 12,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                MdiIcons.phone,
                                                                size: 12,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              SmallText(
                                                                text: dashboardController
                                                                            .foundDealerList[
                                                                        index]
                                                                    ['xphone'],
                                                                size: 12,
                                                              ),
                                                            ],
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
                                  }),
                        );
                      })
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

/*Padding(
padding: const EdgeInsets.only(
top: 5, bottom: 5),
child: SizedBox(
height: Dimensions.height50 +
Dimensions.height20,
child: ListTile(
onTap: () {
Get.to(
() => ProductTypeSelectScreen(
xCus: dashboardController.foundDealerList[index]['xcus'],
xOrg: dashboardController.foundDealerList[index]['xorg'],
xGcus: dashboardController.foundDealerList[index]['xgcus'],
xTerritory: dashboardController.foundDealerList[index]['xterritory'],
delDisc: dashboardController.foundDealerList[index]['xdisc'],
));
},
tileColor: AppColor.appBarColor,
title: Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
BigText(
text: dashboardController
    .foundDealerList[index]
['xorg']
    .toString(),
size: 14,
color: AppColor.defWhite,
)
],
),
subtitle: Column(
children: [
Row(
mainAxisAlignment:
MainAxisAlignment
    .spaceBetween,
children: [
Column(
crossAxisAlignment:
CrossAxisAlignment
    .start,
children: [
SmallText(
text: dashboardController
    .foundDealerList[
index]['xcus'],
size: 12,
),
Container(
height: 50,
width: Dimensions
    .height150,
child: SmallText(
text: dashboardController
    .foundDealerList[
index]['xphone'],
size: 10,
),
)
],
),
Container(
height: 60,
width: Dimensions.height150,
child: SmallText(
text: dashboardController
    .foundDealerList[
index]['xmadd'],
size: 8,
),
)
],
),
],
),
),
),
)*/
