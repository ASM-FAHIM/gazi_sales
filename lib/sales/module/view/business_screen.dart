import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/module/view/tso_selection_screen.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../constant/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/business_widget.dart';
import '../controller/login_controller.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.getBusinessList();
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
          actions: [
            Obx(
              () => IconButton(
                onPressed: () {
                  loginController.fetchTerritoryList();
                },
                icon: loginController.isFetched.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.defWhite,
                        ),
                      )
                    : const Icon(
                        MdiIcons.syncIcon,
                        size: 30,
                      ),
              ),
            )
          ]),
      body: Obx(() {
        return loginController.isDone.value
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
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  // width / height: fixed for *all* items
                  childAspectRatio: 1.1,
                ),
                itemCount: loginController.userWiseBusiness.length,
                itemBuilder: (context, index) {
                  return loginController.userWiseBusiness == []
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: BusinessWidget(
                            businessName:
                                loginController.userWiseBusiness[index]["zorg"],
                            imgPath: loginController.changeImage(loginController
                                .userWiseBusiness[index]["zorg"]),
                            height: Dimensions.height70,
                            width: Dimensions.height150,
                            fit: BoxFit.fill,
                            onPressed: () {
                              Get.to(() => TsoSelectionScreen(
                                  zid: loginController.userWiseBusiness[index]
                                      ["zid"],
                                  businessSupeID: 'Need to Modify',
                                  xStaff: 'Need to modify'));
                            },
                          ),
                        );
                });
      }),
    ));
  }
}
