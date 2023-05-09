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
    notifyController.fetchSoNotification(loginController.xstaff.value);
    super.initState();
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
        title: BigText(text: "Sales order notification", color: AppColor.defWhite, size: 25,),

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
                          child: CircularProgressIndicator(color: AppColor.appBarColor,),
                        ),
                        Text('Loading...'),
                      ],
                    ),
                  );
                }
                else {
                  return ListView.builder(
                      itemCount: notifyController.notifyList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: notifyController.notifyList[index].cusname, size: 16,),
                                    SmallText(text: notifyController.notifyList[index].xsonumber),
                                    SmallText(text: notifyController.notifyList[index].xcus,),
                                    BigText(text: notifyController.notifyList[index].xdate, size: 15, color: AppColor.defRed,),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Card(
                                    color: notifyController.changeColor(notifyController.notifyList[index].xstatusso),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    elevation: 5,
                                    child: Container(
                                      height: Dimensions.height45,
                                      width: Dimensions.height60 + Dimensions.height45,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BigText(text: '${notifyController.notifyList[index].xstatusso}', color: Colors.white,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
