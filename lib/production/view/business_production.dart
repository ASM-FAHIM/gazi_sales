import 'package:flutter/material.dart';
import 'package:gazi_sales_app/production/controller/process_controller.dart';
import 'package:get/get.dart';

import '../../sales/constant/colors.dart';
import '../../sales/constant/dimensions.dart';
import '../../sales/widget/big_text.dart';
import '../../sales/widget/business_widget.dart';

class BusinessProduction extends StatefulWidget {
  const BusinessProduction({Key? key}) : super(key: key);

  @override
  State<BusinessProduction> createState() => _BusinessProductionState();
}

class _BusinessProductionState extends State<BusinessProduction> {
  ProcessController processController = Get.put(ProcessController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processController.getBusinessList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    processController.dispose();
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
                text: 'Business',
                color: AppColor.defWhite,
                size: 25,
              ),
          ),
          body: Obx(() {
            return processController.isDone.value
                ? Center(
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
            )
                : Padding(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    // width / height: fixed for *all* items
                    childAspectRatio: 1.1,
                  ),
                  itemCount: processController.userWiseBusiness.length,
                  itemBuilder: (context, index) {
                    return processController.userWiseBusiness == []
                        ? Container()
                        : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: BusinessWidget(
                        businessName: processController.userWiseBusiness[index]["zorg"],
                        imgPath: processController.changeImage(
                            processController.userWiseBusiness[index]
                            ["zorg"]),
                        height: Dimensions.height30,
                        width: Dimensions.height70,
                        fit: BoxFit.fill,
                        onPressed: () {
                          print('${processController.userWiseBusiness[index]["zid"]}');
                          processController.saveInfo(processController.userWiseBusiness[index]["zid"]);
                        },
                      ),
                    );
                  }),
            );
          }),
        ));
  }
}
