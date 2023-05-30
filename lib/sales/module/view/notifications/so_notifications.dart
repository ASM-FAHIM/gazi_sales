import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/login_controller.dart';
import '../../controller/notify_controller.dart';

class SoNotificationScreen extends StatefulWidget {
  const SoNotificationScreen({Key? key}) : super(key: key);

  @override
  State<SoNotificationScreen> createState() => _SoNotificationScreenState();
}

class _SoNotificationScreenState extends State<SoNotificationScreen> {
  final NotifyController notifyController = Get.put(NotifyController());
  LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyController.fetchSoNotification(loginController.xstaff.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        leading: GestureDetector(
            onTap: () {
              notifyController.clearSoList();
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            )),
        title: BigText(
          text: "Sales order notification",
          color: AppColor.defWhite,
          size: 25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (notifyController.isLoading.value) {
                  return Center(
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
                  );
                } else {
                  return ListView.builder(
                      itemCount: notifyController.notifyList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: Dimensions.height150 + Dimensions.height30,
                          width: double.infinity,
                          margin: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: Dimensions.height50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: notifyController.changeColor(
                                      notifyController
                                          .notifyList[index].xstatusso),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                ),
                                alignment: Alignment.center,
                                child: BigText(
                                  text: notifyController
                                      .notifyList[index].xstatusso,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SmallText(
                                            text: notifyController
                                                .notifyList[index].xdate,
                                            size: 12,
                                            color: AppColor.defRed,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                            text: notifyController
                                                .notifyList[index].cusname,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                              text:
                                                  'So No : ${notifyController.notifyList[index].xsonumber}',
                                              size: 16),
                                          SmallText(
                                              text:
                                                  'Customer Id : ${notifyController.notifyList[index].xcus}',
                                              size: 16),
                                          SmallText(
                                            text:
                                                'Territory : ${notifyController.notifyList[index].xterritory}',
                                            size: 16,
                                            color: AppColor.defRed,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
