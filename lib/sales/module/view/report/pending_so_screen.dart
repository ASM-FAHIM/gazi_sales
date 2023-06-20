import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/report_controller.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import 'package:get/get.dart';

import '../../../widget/small_text.dart';

class PendingSOReport extends StatefulWidget {
  const PendingSOReport({Key? key}) : super(key: key);

  @override
  State<PendingSOReport> createState() => _PendingSOReportState();
}

class _PendingSOReportState extends State<PendingSOReport> {
  ReportController report = Get.put(ReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchPendingSoList();
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
            text: "Pending SO report",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Container(
            child: Obx(() => report.isLoading.value
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
                      report.pendingList.isEmpty
                          ? const NoDataPage(
                              text: 'Sorry! no pending SO available right now')
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: report.pendingList.length,
                                  itemBuilder: (context, index) {
                                    var pendinSO = report.pendingList[index];
                                    return Container(
                                      height: Dimensions.height150 +
                                          Dimensions.height50,
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
                                            decoration: const BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  topRight:
                                                      Radius.circular(20.0)),
                                            ),
                                            alignment: Alignment.center,
                                            child: BigText(
                                              text: pendinSO.xorg,
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      SmallText(
                                                        text: pendinSO.xdate,
                                                        size: 11,
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SmallText(
                                                            text:
                                                                'So No : ${pendinSO.xsonumber}',
                                                            size: 16),
                                                        SmallText(
                                                            text:
                                                                'Product desc : ${pendinSO.xdesc}',
                                                            size: 16),
                                                        SmallText(
                                                            text:
                                                                'So qty : ${pendinSO.soQty}',
                                                            size: 16),
                                                        SmallText(
                                                            text:
                                                                'DC qty : ${pendinSO.dcQty}',
                                                            size: 16),
                                                        SmallText(
                                                            text:
                                                                'Pending qty : ${pendinSO.xpendingqty}',
                                                            size: 16),
                                                        SmallText(
                                                            text:
                                                                'Preclose qty : ${pendinSO.xpendingqty}',
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

/*  Widget _dataTable(int index, BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return Column(
      children: [
        Row(
          children: [
            DataTableWidget(
              width / 5.5,
              '${report.pendingList[index].xdate}',
              shouldColorTop: true,
            ),
            DataTableWidget(width / 5, '${report.pendingList[index].xdate}',
                shouldColorTop: true, shouldColorLeft: true),
            DataTableWidget(width / 5.8, 'Value 2',
                shouldColorTop: true, shouldColorLeft: true),
            DataTableWidget(width / 4.5, 'Value 3',
                shouldColorTop: true, shouldColorLeft: true),
          ],
        )
      ],
    );
  }

  Widget _tableTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TableTitle(width / 5.5, 'SO number', shouldOffRight: false),
            TableTitle(width / 5, 'Date'),
            TableTitle(width / 5.8, 'Dealer name'),
            TableTitle(width / 4.5, 'Product name'),
            TableTitle(width / 4.5, 'So qty'),
            TableTitle(width / 4.5, 'DC qty'),
            TableTitle(width / 4.5, 'Pending qty'),
          ],
        )
      ],
    );
  }*/
}
