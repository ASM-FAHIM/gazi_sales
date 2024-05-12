import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../controller/report_controller.dart';

class CustomerLedgerScreen extends StatefulWidget {
  String xCus;
  String cusName;

  CustomerLedgerScreen({required this.xCus, required this.cusName, Key? key})
      : super(key: key);

  @override
  State<CustomerLedgerScreen> createState() => _CustomerLedgerScreenState();
}

class _CustomerLedgerScreenState extends State<CustomerLedgerScreen> {
  ReportController report = Get.put(ReportController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchLedgerReport(widget.xCus);
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
                report.cusLedList.clear();
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
        body: Obx(() => report.ledFetched.value
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
                    child: report.cusLedList.isEmpty
                        ? const NoDataPage(
                            text: 'Sorry! no pending SO available right now')
                        : ListView.builder(
                            itemCount: report.cusLedList.length,
                            itemBuilder: (context, index) {
                              var ledList = report.cusLedList[index];
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
                                          color: Colors.grey,
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0,
                                              2) // changes position of shadow
                                          ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(ledList.xpnature),
                                      Text(ledList.xbalance),
                                    ],
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
