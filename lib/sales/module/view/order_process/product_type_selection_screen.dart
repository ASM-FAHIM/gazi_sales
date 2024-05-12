import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/dashboard_controller.dart';
import 'package:gazi_sales_app/sales/module/view/order_process/product_list_screen.dart';
import 'package:get/get.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';

class ProductTypeSelectScreen extends StatefulWidget {
  String xCus;
  String xOrg;
  String xTerritory;
  String xGcus;
  String delDisc;
  String zbusiness;
  ProductTypeSelectScreen(
      {required this.xCus,
      required this.xOrg,
      required this.xTerritory,
      required this.xGcus,
      required this.delDisc,
        required this.zbusiness,
      Key? key})
      : super(key: key);

  @override
  State<ProductTypeSelectScreen> createState() =>
      _ProductTypeSelectScreenState();
}

class _ProductTypeSelectScreenState extends State<ProductTypeSelectScreen> {
  DashboardController dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardController.getPNatureList();
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
              /*await dashboardController.getVisitedDealerList();
                  await dashboardController.countDealerVisitTable();*/
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            )),
        title: BigText(
          text: "Product type",
          color: AppColor.defWhite,
          size: 25,
        ),

        actions: [
          BigText(
            text: "${widget.zbusiness}",
            color: AppColor.defWhite,
            size: 15,
          ),
          SizedBox(width: 10,)
        ],

      ),
      body: Obx(() {
        return dashboardController.isPNatureloaded.value
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
                    Text('Loading...')
                  ],
                ),
              )
            : Container(
                child: dashboardController.productNatureList.isEmpty
                    ? const Center(
                        child: NoDataPage(
                          text: 'No product nature found yet !',
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0,
                                childAspectRatio: 1.4),
                        itemCount: dashboardController.productNatureList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                //go to next page by saving product nature

                                Get.to(() => ProductsScreen(
                                      xcus: widget.xCus,
                                      xOrg: widget.xOrg,
                                      xterritory: widget.xTerritory,
                                      xgcus: widget.xGcus,
                                      delDisc: widget.delDisc,
                                      xPNature: dashboardController
                                          .productNatureList[index]["xcode"],
                                      zbusiness: widget.zbusiness,
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(),
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.dstATop),
                                      image: const AssetImage(
                                        'assets/images/user.png',
                                      ),
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                      text: dashboardController
                                          .productNatureList[index]["xcode"],
                                      size: 25,
                                      color: AppColor.defWhite,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              );
      }),
    ));
  }
}
