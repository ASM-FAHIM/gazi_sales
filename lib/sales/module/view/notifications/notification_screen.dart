import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/notifications/deposit_notifications.dart';
import 'package:gazi_sales_app/sales/module/view/notifications/so_notifications.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/business_widget.dart';
import '../../../widget/small_text.dart';
import '../../controller/login_controller.dart';
import '../../controller/notify_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotifyController notifyController = Get.put(NotifyController());
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: "Notifications",
          color: AppColor.defWhite,
          size: 25,
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BusinessWidget(
                  businessName: 'Sales Notification',
                  imgPath: 'assets/images/sale.png',
                  height: 70,
                  onPressed: () {
                    Get.to(() => SoNotificationScreen());
                  },
                ),
                BusinessWidget(
                  businessName: 'Deposit Notification',
                  imgPath: 'assets/images/bank.png',
                  height: 70,
                  onPressed: () {
                    Get.to(() => DepositNotificationScreen());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
