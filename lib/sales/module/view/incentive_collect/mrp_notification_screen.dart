import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/qr_controller.dart';


class MRPNotificationScreen extends StatefulWidget {
  String tsoId;
  MRPNotificationScreen({required this.tsoId, Key? key}) : super(key: key);

  @override
  State<MRPNotificationScreen> createState() => _MRPNotificationScreenState();
}

class _MRPNotificationScreenState extends State<MRPNotificationScreen> {
  QrController qrController = Get.put(QrController());


  @override
  void initState() {
    // TODO: implement initState
    qrController.getMRPNotification(widget.tsoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          qrController.resetMrp();
          Get.back();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            leading: GestureDetector(
                onTap: () {
                  qrController.resetMrp();
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 25,
                )),
            title: BigText(
              text: "MIP List",
              color: AppColor.defWhite,
              size: 25,
            ),
          ),
          body: Obx((){
            return qrController.isMrpFetched.value
                ? Center(
                  child: Column(
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
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      qrController.mrpList.isEmpty
                          ?   BigText(text: 'No Data Found')
                          :   Expanded(
                        child: ListView.builder(
                            itemCount: qrController.mrpList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: SizedBox(
                                  height: Dimensions.height50 + Dimensions.height20,
                                  child: ListTile(
                                    // onTap: () {
                                    //   // go to Mechanic screen
                                    //   Get.to(() => IncentiveScreen(xcus: qrController.filteredDeals[index].xcus));
                                    //   //Get.to(() => QrScreen());
                                    // },
                                    tileColor: AppColor.appBarColor,
                                    title: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: 'Date: ${qrController.mrpList[index].xdate}',
                                          size: 14,
                                          color: AppColor.defWhite,
                                        )
                                      ],
                                    ),
                                    subtitle: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 20,
                                              width: Dimensions.height150,
                                              child: SmallText(
                                                text: 'Mechanic Name: ${qrController.mrpList[index].xname}',
                                                size: 10,
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: Dimensions.height150,
                                              child:  SmallText(
                                                text: 'Dealer name: ${qrController.mrpList[index].xnamem}',
                                                size: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 50,
                                          width: Dimensions.height150,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                text: 'Mechanic contact: ${qrController.mrpList[index].xmobile}',
                                                size: 10,
                                              ),
                                              BigText(
                                                text: 'Incentive: ${qrController.mrpList[index].xgtotal}',
                                                size: 14,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
