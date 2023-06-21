import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/report_controller.dart';
import 'package:gazi_sales_app/sales/module/view/report/report_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';

class DealerReportScreen extends StatefulWidget {
  const DealerReportScreen({Key? key}) : super(key: key);

  @override
  State<DealerReportScreen> createState() => _DealerReportScreenState();
}

class _DealerReportScreenState extends State<DealerReportScreen> {
  ReportController report = Get.put(ReportController());
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    report.getDealerList();
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
            text: "Dealer",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx(() {
          return report.isLoading3.value
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
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: 'Search by name',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.search)),
                        onChanged: (value) => report.search(value),
                      ),
                      Obx(() {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: report.filteredDeals.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Container(
                                    height: Dimensions.height70 +
                                        Dimensions.height45,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
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
                                        // go to Mechanic screen
                                        Get.to(() => ReportScreen());
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
                                                text:
                                                    report.filteredDeals[index]
                                                        ['xorg'],
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
                                                    CrossAxisAlignment.start,
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
                                                          text: report
                                                                  .filteredDeals[
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
                                                            MdiIcons.account,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          SmallText(
                                                            text: report
                                                                    .filteredDeals[
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
                                                            text: report
                                                                    .filteredDeals[
                                                                index]['xphone'],
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
