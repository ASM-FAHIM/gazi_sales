import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/sro_summary/tso_summary_screen.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/login_controller.dart';
import '../../controller/notify_controller.dart';

class SROScreen extends StatefulWidget {
  const SROScreen({Key? key}) : super(key: key);

  @override
  State<SROScreen> createState() => _SROScreenState();
}

class _SROScreenState extends State<SROScreen> {
  NotifyController notifyController = Get.put(NotifyController());
  LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    // TODO: implement initState
    notifyController.fetchSROWiseTSO(loginController.zID.value, loginController.xstaff.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('The ZID: ${loginController.zID.value} and xStaff ID : ${loginController.xstaff.value}');
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 25,
                )),
            // centerTitle: true,
            title: BigText(
              text: "TSO List",
              color: AppColor.defWhite,
              size: 25,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            child: Column(
              children: [
                /*Container(
                  height: 50,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: BigText(text: 'Total selling: 24500 LTR', size: 20, color: AppColor.defWhite,),
                ),
                SizedBox(height: 10,),*/
                Expanded(
                  child: Obx(() {
                    if (notifyController.isTsoFetched.value) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(color: AppColor.appBarColor,),
                            ),
                            const Text('Loading...'),
                          ],
                        ),
                      );
                    }
                    else {
                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                              childAspectRatio: 1.30),
                          itemCount: notifyController.sroWiseTSOList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=> TSOSummaryScreen(
                                  zID: loginController.zID.value,
                                  name: notifyController.sroWiseTSOList[index].name,
                                  tsoID: notifyController.sroWiseTSOList[index].xso,
                                  )
                                );
                              },
                              child: Card(
                                elevation: 3,
                                color: AppColor.comColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 2
                                  ),
                                    borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: notifyController.sroWiseTSOList[index].name, size: 18, color: AppColor.defWhite,),
                                    SmallText(text: notifyController.sroWiseTSOList[index].xterritory,color: AppColor.defWhite),
                                    SmallText(text: notifyController.sroWiseTSOList[index].xso,color: AppColor.defWhite),
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
        )
    );
  }
}
