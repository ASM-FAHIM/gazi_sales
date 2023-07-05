import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/deposit_controller.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/small_text.dart';
import 'entry_form.dart';

class DepositEntryScreen extends StatefulWidget {
  const DepositEntryScreen({Key? key}) : super(key: key);

  @override
  State<DepositEntryScreen> createState() => _DepositEntryScreenState();
}

class _DepositEntryScreenState extends State<DepositEntryScreen> {
  DepositController depositController = Get.put(DepositController());
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    depositController.getDealerList();
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
            ),
          ),
          title: BigText(
            text: "Deposit entry",
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
        body: Obx(() {
          return depositController.isLoading.value
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
                            suffixIcon: Icon(Icons.search)),
                        onChanged: (value) => depositController.search(value),
                      ),
                      Obx(() {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: depositController.filteredDeals.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Container(
                                    height: Dimensions.height70 +
                                        Dimensions.height45,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColor.appBarColor,
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // go to Mechanic screen
                                        Get.to(() => DepositFormScreen(
                                              tso: depositController
                                                  .filteredDeals[index]["xtso"],
                                              cusId: depositController
                                                  .filteredDeals[index]["xcus"],
                                              cusName: depositController
                                                  .filteredDeals[index]["xorg"],
                                              territory: depositController
                                                      .filteredDeals[index]
                                                  ["xterritory"],
                                              zone: depositController
                                                          .filteredDeals[index]
                                                      ["xzone"] ??
                                                  ' ',
                                              zm: depositController
                                                          .filteredDeals[index]
                                                      ["xzm"] ??
                                                  ' ',
                                              division: depositController
                                                          .filteredDeals[index]
                                                      ["xdivision"] ??
                                                  ' ',
                                              dm: depositController
                                                          .filteredDeals[index]
                                                      ["dm"] ??
                                                  ' ',
                                            ));
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BigText(
                                                text: depositController
                                                        .filteredDeals[index]
                                                    ['xorg'],
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        MdiIcons.home,
                                                        size: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: SmallText(
                                                          text: depositController
                                                                  .filteredDeals[
                                                              index]['xmadd'],
                                                          size: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            MdiIcons.account,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          SmallText(
                                                            text: depositController
                                                                    .filteredDeals[
                                                                index]['xcus'],
                                                            size: 12,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            MdiIcons.phone,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          SmallText(
                                                            text: depositController
                                                                    .filteredDeals[
                                                                index]['xphone'],
                                                            size: 12,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      })
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
