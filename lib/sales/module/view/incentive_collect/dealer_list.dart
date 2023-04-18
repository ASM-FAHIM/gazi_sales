import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import '../../controller/login_controller.dart';
import '../../controller/qr_controller.dart';
import 'incentive_screen.dart';

class DealerListScreen extends StatefulWidget {
  const DealerListScreen({Key? key}) : super(key: key);

  @override
  State<DealerListScreen> createState() => _DealerListScreenState();
}

class _DealerListScreenState extends State<DealerListScreen> {
  LoginController loginController = Get.put(LoginController());
  QrController qrController = Get.put(QrController());
  TextEditingController name = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    qrController.getDealerInfo(loginController.xso.value);
    super.initState();
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
              text: "Dealers",
              color: AppColor.defWhite,
              size: 25,
            ),
          ),
          body: Obx((){
            return qrController.isLoading1.value
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
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                          hintText: 'Search by name',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search)
                      ),
                      onChanged: (value) => qrController.search(value),),
                  Expanded(
                    child: ListView.builder(
                        itemCount: qrController.filteredDeals.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SizedBox(
                              height: Dimensions.height50 + Dimensions.height20,
                              child: ListTile(
                                onTap: () {
                                  // go to Mechanic screen
                                   Get.to(() => IncentiveScreen(xcus: qrController.filteredDeals[index].xcus));
                                  //Get.to(() => QrScreen());
                                },
                                tileColor: AppColor.appBarColor,
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: qrController.filteredDeals[index].xorg,
                                      size: 14,
                                      color: AppColor.defWhite,
                                    )
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SmallText(
                                              text: qrController.filteredDeals[index].xcus,
                                              size: 10,
                                            ),
                                            Container(
                                              height: 50,
                                              width: Dimensions.height150,
                                              child:  SmallText(
                                                text: qrController.filteredDeals[index].xphone,
                                                size: 10,
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: 60,
                                          width: Dimensions.height150,
                                          child: SmallText(
                                            text: qrController.filteredDeals[index].xmadd,
                                            size: 10,
                                          ),
                                        )
                                      ],
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
    );
  }
}
