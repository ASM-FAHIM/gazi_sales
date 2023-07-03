import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/no_data_page.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../controller/report_controller.dart';

class PendingSoDetailsScreen extends StatefulWidget {
  String xCus;
  String cusName;
  String soNum;

  PendingSoDetailsScreen({required this.xCus,
    required this.cusName,
    required this.soNum,
    Key? key})
      : super(key: key);

  @override
  State<PendingSoDetailsScreen> createState() => _PendingSoDetailsScreenState();
}

class _PendingSoDetailsScreenState extends State<PendingSoDetailsScreen> {
  ReportController report = Get.find<ReportController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.fetchPendDelDetails(widget.xCus, widget.soNum);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    print('So number: ${widget.soNum}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          leading: GestureDetector(
              onTap: () {
                Get.back();
                report.pendDelDetails.clear();
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
        body: Obx(() =>
        report.fetDelDetail.value
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
              child: report.pendDelDetails.isEmpty
                  ? const NoDataPage(text: 'Sorry! no details available')
                  : ListView.builder(
                  itemCount: report.pendDelDetails.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: size.height / 4.8,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                            AppColor.appBarColor.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            report.pendDelDetails[index].xdesc,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          /*Text(
                                    " ${cartController.listOfAddedProducts[index]["xqty"]} X ${cartController.listOfAddedProducts[index]["xrate"]} = ${cartController.listOfAddedProducts[index]["xlineamt"]} Tk.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),*/
                          Text(
                            'item code: ${report.pendDelDetails[index].xitem}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: size.height / 22,
                                    child: Text(
                                      'So qty\n${report.pendDelDetails[index]
                                          .soQty}',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: size.height / 22,
                                    child: Text(
                                      'Dc qty\n${report.pendDelDetails[index]
                                          .dcQty}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: size.height / 22,
                                    child: Text(
                                      'Pending qty\n${report
                                          .pendDelDetails[index].xpendingqty}',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: size.height / 22,
                                    child: Text(
                                      'Preclose qty\n${report
                                          .pendDelDetails[index]
                                          .xpreclosedqty}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
