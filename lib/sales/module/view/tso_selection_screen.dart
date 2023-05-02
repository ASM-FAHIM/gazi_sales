import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/colors.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/login_controller.dart';

class TsoSelectionScreen extends StatefulWidget {
  String zid;
  String businessSupeID;
  String xStaff;
  TsoSelectionScreen({
    required this.zid,
    required this.xStaff,
    required this.businessSupeID,
    Key? key
  }) : super(key: key);

  @override
  State<TsoSelectionScreen> createState() => _TsoSelectionScreenState();
}

class _TsoSelectionScreenState extends State<TsoSelectionScreen> {
  final GlobalKey<FormState> loginKey = GlobalKey();
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    loginController.getTerritory(widget.zid,widget.businessSupeID);
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
              loginController.clearTerritoryList();
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            ),
          ),
          title: BigText(
            text: 'Territory List',
            color: AppColor.defWhite,
            size: 25,
          ),
            /*actions: [
              Obx(() => IconButton(
                onPressed: () {
                  loginController.fetchTerritoryList(widget.zid,widget.businessSupeID);
                  //dashboardController.getProductInfo();
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
            ]*/
        ),
        body: Obx((){
         return  loginController.territoryFetched.value
          ? Center(
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
           )
          : GridView.builder(
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 2.0,
                 mainAxisSpacing: 2.0,
                 childAspectRatio: 1.4),
              itemCount: loginController.territoryList.length,
              itemBuilder: (context, index) {
                return loginController.territoryList == []
                    ? Container()
                    : Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: (){
                          loginController.getTsoInfo(
                              '${loginController.territoryList[index]["xtso"]}',
                              '${loginController.territoryList[index]["xterritory"]}',
                              '${loginController.territoryList[index]["xzone"]}',
                              '${loginController.territoryList[index]["xzm"]}',
                              '${loginController.territoryList[index]["xdivision"]}',
                              '${loginController.territoryList[index]["xdm"]}'
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(),
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xff7c94b6),
                            image:  DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                                image:  const AssetImage('assets/images/user.png',),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(
                                text: loginController.territoryList[index]["xterritory"],
                                size: 25,
                                color:
                                AppColor.defWhite,
                              ),
                              SmallText(
                                text: loginController.territoryList[index]["xtso"],
                                size: 12,
                                color:
                                AppColor.defWhite,
                              ),
                            ],
                          ),
                        ),
                ),
                    );
              });
        }),
      ),
    );
  }
}

/*Padding(
padding: const EdgeInsets.all(10.0),
child: SizedBox(
height: Dimensions.height50 + Dimensions.height20,
child: ListTile(
onTap: () {
//some value saved in this method such as xsp and xso
loginController.getTsoInfo(
'${loginController.territoryList[index]["xso"]}',
'${loginController.territoryList[index]["xterritory"]}',
'${loginController.territoryList[index]["xsp"]}',
'${loginController.territoryList[index]["xrole"]}'
);
},
tileColor: AppColor.appBarColor,
title: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
BigText(
text: loginController.territoryList[index]["xterritory"],
size: 20,
color:
AppColor.defWhite,
),
SmallText(
text: loginController.territoryList[index]["xsp"],
size: 12,
color:
AppColor.defWhite,
),
],
),
),
),
)*/
