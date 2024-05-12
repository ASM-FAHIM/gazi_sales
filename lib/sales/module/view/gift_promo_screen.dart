import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/dashboard_controller.dart';
import '../model/gift_promo_model/promotion_model.dart';

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
            ),
          ),
          title: BigText(
            text: "Promotions",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Obx(() {
            if (dashboardController.listFetched.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColor.appBarColor,
                    ),
                    SizedBox(height: 10),
                    Text('Loading...'),
                  ],
                ),
              );
            } else if (dashboardController.listGiftPromo.isEmpty) {
              return NoDataPage(text: 'Sorry! no gift available right now');
            } else {
              // Group the list by xtrnnum
              Map<String, List<ListPromotionModel>> groupedData =
              groupByXtrnnum(dashboardController.listGiftPromo);

              return SingleChildScrollView(
                child: Column(
                  children: groupedData.entries.map((entry) {
                    String xtrnnum = entry.key;
                    List<ListPromotionModel> dataList = entry.value;
                    String xstype = dataList.first.xstype;

                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Custom header with xtrnnum and date range
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.grey.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$xstype',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'From: ${dataList.first.xfdate} To ${dataList.first.xtdate}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // DataTable for this xtrnnum

                          /*DataTable(
                            columnSpacing: 8, // Adjust column spacing to make it smaller
                            columns: [
                              DataColumn(
                                label: Text('From Slab'),
                                numeric: true, // Set numeric attribute to true for Discount %
                              ),
                              DataColumn(
                                label: Text('To Slab'),
                                numeric: true, // Set numeric attribute to true for Discount %
                              ),
                              // DataColumn(
                              //   label: SizedBox.shrink(), // Empty label for the spacer cell
                              // ),
                              DataColumn(label: Text('Type')),
                              DataColumn(
                                label: Text('Discount %'),
                                numeric: true, // Set numeric attribute to true for Discount %
                              ),
                            ],
                            rows: dataList.map((giftPromo) => DataRow(cells: [
                              DataCell(Text(giftPromo.xfslab)),
                              DataCell(Text(giftPromo.xtslab)),
                              // DataCell(SizedBox.shrink()), // Empty DataCell for spacer
                              DataCell(Text(giftPromo.xcolor)),
                              DataCell(Text(giftPromo.xamount)),
                            ])).toList(),
                          ),*/

                          DataTable(
                            columnSpacing: 8, // Adjust column spacing to make it smaller
                            columns: [
                              DataColumn(
                                label: Text('From Slab'),
                                numeric: true, // Set numeric attribute to true for Discount %
                              ),
                              DataColumn(
                                label: Text('To Slab'),
                                numeric: true, // Set numeric attribute to true for Discount %
                              ),
                              DataColumn(label: Text('Type')),
                              DataColumn(
                                label: Text('Discount %'),
                                numeric: true, // Set numeric attribute to true for Discount %
                              ),
                            ],
                            rows: dataList.asMap().entries.map((entry) {
                              final index = entry.key;
                              final giftPromo = entry.value;
                              final isEvenRow = index.isEven;
                              final rowColor = isEvenRow ? Colors.grey.withOpacity(0.1) : Colors.white;

                              return DataRow(
                                color: MaterialStateProperty.resolveWith<Color>((_) => rowColor),
                                cells: [
                                  DataCell(Text(giftPromo.xfslab)),
                                  DataCell(Text(giftPromo.xtslab)),
                                  DataCell(Text(giftPromo.xcolor)),
                                  DataCell(Text(giftPromo.xamount)),
                                ],
                              );
                            }).toList(),
                          ),





                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  // Function to group data by xtrnnum
  Map<String, List<ListPromotionModel>> groupByXtrnnum(
      List<ListPromotionModel> dataList) {
    Map<String, List<ListPromotionModel>> groupedData = {};
    for (var data in dataList) {
      if (!groupedData.containsKey(data.xtrnnum)) {
        groupedData[data.xtrnnum] = [];
      }
      groupedData[data.xtrnnum]!.add(data);
    }
    return groupedData;
  }
}
