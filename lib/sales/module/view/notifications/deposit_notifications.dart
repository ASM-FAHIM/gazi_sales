import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/login_controller.dart';
import '../../controller/notify_controller.dart';

class DepositNotificationScreen extends StatefulWidget {
  const DepositNotificationScreen({Key? key}) : super(key: key);

  @override
  State<DepositNotificationScreen> createState() =>
      _DepositNotificationScreenState();
}

class _DepositNotificationScreenState extends State<DepositNotificationScreen> {
  final NotifyController notifyController = Get.put(NotifyController());
  LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    // TODO: implement initState
    notifyController.fetchDepositNotification(
        loginController.xstaff.value, loginController.zID.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        leading: GestureDetector(
            onTap: () {
              notifyController.clearDepositList();
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            )),
        title: BigText(
          text: "Deposit notification",
          color: AppColor.defWhite,
          size: 25,
        ),
      ),
      body: Obx(() {
        if (notifyController.isLoading1.value) {
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
              physics: BouncingScrollPhysics(),
              itemCount: notifyController.depositNotifyList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: Dimensions.height200 + Dimensions.height30,
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
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: Dimensions.height50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: notifyController.changeColor(notifyController
                              .depositNotifyList[index].xstatus),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                        ),
                        alignment: Alignment.center,
                        child: BigText(
                          text:
                              notifyController.depositNotifyList[index].xstatus,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BigText(
                                    text: notifyController
                                        .depositNotifyList[index].xdate,
                                    size: 12,
                                    color: AppColor.defRed,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: notifyController
                                        .depositNotifyList[index].cusname,
                                    size: 16,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SmallText(
                                        text:
                                            'Deposit No : ${notifyController.depositNotifyList[index].xdepositnum}',
                                        size: 14),
                                    SmallText(
                                        text:
                                            'Bank : ${notifyController.depositNotifyList[index].bankName}',
                                        size: 14),
                                    SmallText(
                                        text:
                                            'Branch : ${notifyController.depositNotifyList[index].xbranch}',
                                        size: 14),
                                    SmallText(
                                        text:
                                            'Check/Ref : ${notifyController.depositNotifyList[index].xdepositref}',
                                        size: 14),
                                    SmallText(
                                      text:
                                          'Amount : ${notifyController.depositNotifyList[index].xamount} Tk.',
                                      size: 16,
                                      color: AppColor.defRed,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*SizedBox(height: 15,),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: notifyController.changeColor(notifyController.depositNotifyList[index].xstatus),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)
                            ),
                          ),
                          alignment: Alignment.center,
                          child: BigText(text: notifyController.depositNotifyList[index].xstatus, color: Colors.white,),
                        ),
                      ),*/
                    ],
                  ),
                );
              });
        }
      }),
    );
  }
}

/*
Card(
color: notifyController.changeColor(notifyController.depositNotifyList[index].xstatus),
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
BigText(text: notifyController.depositNotifyList[index].xstatus, color: Colors.white,),
],
),
),
),
*/
