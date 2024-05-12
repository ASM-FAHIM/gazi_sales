import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/report/monthly_so_details_report.dart';
import 'package:get/get.dart';
import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../controller/report_controller.dart';

class MonthlySoReport extends StatefulWidget {
  String xCus;
  String cusName;

  MonthlySoReport({required this.xCus, required this.cusName, Key? key})
      : super(key: key);

  @override
  State<MonthlySoReport> createState() => _MonthlySoReportState();
}

class _MonthlySoReportState extends State<MonthlySoReport> {
  ReportController report = Get.put(ReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchMonthlySoList(widget.xCus);
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
                report.monthlySoList.clear();
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
        body: Obx(() => report.isLoading1.value
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
                    child: report.monthlySoList.isEmpty
                        ? const NoDataPage(
                            text: 'Sorry! no pending SO available right now')
                        : ListView.builder(
                            itemCount: report.monthlySoList.length,
                            itemBuilder: (context, index) {
                              var monSoList = report.monthlySoList[index];
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
                                      Get.to(() => MonthlySODetailsReport(
                                          xCus: widget.xCus,
                                          cusName: widget.cusName,
                                          soNum: monSoList.xsonumber));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(monSoList.xsonumber),
                                        Text(monSoList.xdate),
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
}
