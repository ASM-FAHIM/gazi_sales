import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/notifications/deposit_notifications.dart';
import 'package:gazi_sales_app/sales/module/view/notifications/so_notifications.dart';
import 'package:gazi_sales_app/sales/module/view/notifications/weekly_deposite_summary.dart';
import 'package:gazi_sales_app/sales/module/view/notifications/weekly_so_summary.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/business_widget.dart';
import '../../../widget/small_text.dart';
import '../../controller/login_controller.dart';
import '../../controller/notify_controller.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({required this.zid, required this.zbusiness});

  String zid;
  String zbusiness;


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
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BusinessWidget(
                  businessName: 'SO Summary Last 30 Days',
                  imgPath: 'assets/images/so_report.png',
                  height: 70,
                  onPressed: () {
                    Get.to(() => WeeklySoSummary(zbusiness: widget.zbusiness, zid: widget.zid, xposition: loginController.xposition.toString(),));
                  },
                ),
                BusinessWidget(
                  businessName: 'Deposit Summary Last 30 Days',
                  imgPath: 'assets/images/insurance.png',
                  height: 70,
                  onPressed: () {
                    Get.to(() => WeeklyDepositSummary(zbusiness: widget.zbusiness, zid: widget.zid, xposition: loginController.xposition.toString(),));
                  },
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
