import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/data_table_widget.dart';
import '../../../widget/table_title_widget.dart';
import '../../controller/report_controller.dart';

class MonthlySODetailsReport extends StatefulWidget {
  String xCus;
  String cusName;
  String soNum;

  MonthlySODetailsReport(
      {required this.xCus,
      required this.cusName,
      required this.soNum,
      Key? key})
      : super(key: key);

  @override
  State<MonthlySODetailsReport> createState() => _MonthlySODetailsReportState();
}

class _MonthlySODetailsReportState extends State<MonthlySODetailsReport> {
  ReportController report = Get.put(ReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchMonthlySoDetailsList(widget.xCus, widget.soNum);
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
                report.monthlySoDetailsList.clear();
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
        body: Obx(() {
          return report.soDelFetched.value
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
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Dimensions.height50,
                      alignment: Alignment.center,
                      child: Text(widget.soNum,
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            _tableTitle(context),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: report.monthlySoDetailsList.length,
                                itemBuilder: (context, index) {
                                  return _dataTable(index, context);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  Widget _dataTable(int index, BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20;
    return Column(
      children: [
        Row(
          children: [
            DataTableWidget(
              width / 5,
              report.monthlySoDetailsList[index].xitem,
              shouldColorTop: true,
            ),
            DataTableWidget(width / 2, report.monthlySoDetailsList[index].xdesc,
                shouldColorTop: true, shouldColorLeft: true),
            DataTableWidget(
                width / 6.5, report.monthlySoDetailsList[index].soQty,
                shouldColorTop: true, shouldColorLeft: true),
            DataTableWidget(
                width / 6.5, report.monthlySoDetailsList[index].dcQty,
                shouldColorTop: true, shouldColorLeft: true),
          ],
        )
      ],
    );
  }

  Widget _tableTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TableTitle(width / 5, 'Item code', shouldOffRight: false),
            TableTitle(width / 2, 'Item name'),
            TableTitle(width / 6.5, 'So qty'),
            TableTitle(width / 6.5, 'Dc qty'),
          ],
        )
      ],
    );
  }
}
