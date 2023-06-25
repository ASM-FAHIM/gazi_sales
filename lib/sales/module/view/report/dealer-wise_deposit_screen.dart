import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/report_controller.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';

class DealerDepositScreen extends StatefulWidget {
  String xCus;

  DealerDepositScreen({required this.xCus, Key? key}) : super(key: key);

  @override
  State<DealerDepositScreen> createState() => _DealerDepositScreenState();
}

class _DealerDepositScreenState extends State<DealerDepositScreen> {
  ReportController report = Get.find<ReportController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report.dealerWiseDepo(widget.xCus);
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
          text: "Deposit report",
          color: AppColor.defWhite,
          size: 25,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Obx(() => report.isDepoFetched.value
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
            : ListView.builder(
                itemCount: report.dlrWiseDepo.length,
                itemBuilder: (context, index) {
                  var openDepo = report.dlrWiseDepo[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: Dimensions.height50 + Dimensions.height20,
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            decoration: const BoxDecoration(
                                color: Color(0xff14AAA2),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${openDepo.xdepositnum}',
                                  //overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                /*IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ReusableAlert(
                                            depositController:
                                            depositController,
                                            depoID: openDepo["depositID"],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    MdiIcons.deleteCircle,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                )*/
                                /*SmallText(
                                    text: '${openDepo['xamount']} Tk.',
                                    size: 18,
                                    color: AppColor.defWhite,
                                  ),*/
                              ],
                            ),
                          ),
                          Container(
                            height: Dimensions.height120 + Dimensions.height30,
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(openDepo.xdate,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(openDepo.cusname,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    BigText(
                                      text: '${openDepo.xamount} Tk.',
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                Text('CUS ID: ${openDepo.xcus}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                Text('Invoice type: ${openDepo.xarnature}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                Text('Bank name: ${openDepo.bankName}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                Text(
                                    'Mode of payment: ${openDepo.xpaymenttype}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    ));
  }
}
