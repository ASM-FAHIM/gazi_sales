import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/data_table_widget.dart';
import '../../../widget/table_title_widget.dart';
import '../../controller/report_controller.dart';

class MonthlySOReport extends StatefulWidget {
  const MonthlySOReport({Key? key}) : super(key: key);

  @override
  State<MonthlySOReport> createState() => _MonthlySOReportState();
}

class _MonthlySOReportState extends State<MonthlySOReport> {
  ReportController report = Get.put(ReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchMonthlySoList();
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
            text: "Monthly SO report",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx(() {
          return report.isLoading1.value
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
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      _tableTitle(context),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: report.monthlySoList.length,
                          itemBuilder: (context, index) {
                            return _dataTable(index, context);
                          }),
                    ],
                  ),
                );
        }),
      ),
    );
  }

  Widget _dataTable(int index, BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    return Column(
      children: [
        Row(
          children: [
            DataTableWidget(
              width / 4.5,
              report.monthlySoList[index].xcus,
              shouldColorTop: true,
            ),
            DataTableWidget(width / 4.5, report.monthlySoList[index].dealerName,
                shouldColorTop: true, shouldColorLeft: true),
            DataTableWidget(width / 4.5, report.monthlySoList[index].xpnature,
                shouldColorTop: true, shouldColorLeft: true),
            DataTableWidget(width / 4.5, report.monthlySoList[index].xbalance,
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
            TableTitle(width / 4.5, 'Cus id', shouldOffRight: false),
            TableTitle(width / 4.5, 'Dealer name'),
            TableTitle(width / 4.5, 'Product type'),
            TableTitle(width / 4.5, 'Balance'),
          ],
        )
      ],
    );
  }
}
