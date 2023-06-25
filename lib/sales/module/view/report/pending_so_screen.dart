import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/report_controller.dart';
import 'package:gazi_sales_app/sales/module/view/report/pending_so_details_screen.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import 'package:get/get.dart';

class PendingSOReport extends StatefulWidget {
  String xCus;
  String cusName;

  PendingSOReport({required this.xCus, required this.cusName, Key? key})
      : super(key: key);

  @override
  State<PendingSOReport> createState() => _PendingSOReportState();
}

class _PendingSOReportState extends State<PendingSOReport> {
  ReportController report = Get.find<ReportController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchPendingSoList(widget.xCus);
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.xCus}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
              onTap: () {
                report.pendingList.clear();
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              )),
          title: BigText(
            overflow: TextOverflow.ellipsis,
            text: widget.cusName,
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx(() => report.isLoading.value
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: report.pendingList.isEmpty
                        ? const NoDataPage(
                            text: 'Sorry! no pending SO available right now')
                        : ListView.builder(
                            itemCount: report.pendingList.length,
                            itemBuilder: (context, index) {
                              var penDelList = report.pendingList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Dimensions.height70,
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
                                              2) // changes position of shadow
                                          ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(() => PendingSoDetailsScreen(
                                          xCus: widget.xCus,
                                          cusName: widget.cusName,
                                          soNum: penDelList.xsonumber));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(penDelList.xsonumber),
                                        Text(penDelList.xdate),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                  )
                ],
              )),
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
