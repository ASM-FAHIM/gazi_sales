import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:gazi_sales_app/sales/databaseHelper/syncTime.dart';
import 'package:gazi_sales_app/sales/module/view/tso_selection_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  String datetime = '';

  String synctime = '';
  String synctimeTemp = '';


  String length = '';
  String lengthTemp = '';

  Future<void> getLastSyncTime() async {
    Map<String, dynamic> result = await SyncTime().getLastSyncTime("Business");

    synctimeTemp = result['value'] ?? '';
    lengthTemp = result['length'].toString();



    setState(() {
      length = lengthTemp;
      if(length == '0'){
        synctime = 'Not Sync';
      }else{
        final DateFormat formatter = DateFormat(' hh:mm a, dd MMMM, yyyy');
        final String formattedDateTime = formatter.format(DateTime.parse(synctimeTemp));
        synctime = "Last Sync: $formattedDateTime";
      }


    });




  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.getBusinessList();
    datetime = DateTime.now().toString();
    getLastSyncTime();
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

                  if(length == '0'){
                    SyncTime().insertSyncTime('$datetime', 'Business');
                  }else{
                    SyncTime().updatelastSyncTime('$datetime', 'Business');
                  }


                  loginController.fetchTerritoryList().whenComplete(() => getLastSyncTime());
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
            : Column(
              children: [

                SizedBox(height: 20,),

                // if(length == '0')...[
                //   Center(
                //     child: Container(
                //       height: 50,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10.0),
                //         // color: Colors.blueAccent,
                //         gradient: const LinearGradient(
                //             begin: Alignment.topCenter,
                //             end: Alignment.bottomCenter,
                //             colors: [
                //               Color(0xff0AB8CE),
                //               Color(0xff4E6B9E),
                //             ]),
                //       ),
                //       child: Center(
                //         child: BigText(
                //           text: "Not Sync",
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ]else...[
                //   Center(
                //     child: Container(
                //       height: 50,
                //       width: MediaQuery.of(context).size.width / 1.2,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10.0),
                //         // color: Colors.blueAccent,
                //         gradient: const LinearGradient(
                //             begin: Alignment.topCenter,
                //             end: Alignment.bottomCenter,
                //             colors: [
                //               Color(0xff0AB8CE),
                //               Color(0xff4E6B9E),
                //             ]),
                //       ),
                //       child: Center(
                //         child: BigText(
                //           text: synctime,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ],

                Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // color: Colors.blueAccent,
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff0AB8CE),
                            Color(0xff4E6B9E),
                          ]),
                    ),
                    child: Center(
                      child: Text(synctime,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  height: 500,
                  child: Padding(
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
                          itemCount: loginController.userWiseBusiness.length,
                          itemBuilder: (context, index) {
                            return loginController.userWiseBusiness == []
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: BusinessWidget(
                                      businessName: loginController
                                          .userWiseBusiness[index]["zorg"],
                                      imgPath: loginController.changeImage(
                                          loginController.userWiseBusiness[index]
                                              ["zid"]),
                                      height: Dimensions.height30,
                                      width: Dimensions.height80,
                                      fit: BoxFit.fill,
                                      onPressed: () {
                                        Get.to(() => TsoSelectionScreen(
                                            zid: loginController
                                                .userWiseBusiness[index]["zid"],
                                            businessSupeID: 'Need to Modify',
                                            xStaff: 'Need to modify',
                                          business_name: loginController
                                              .userWiseBusiness[index]["zorg"],
                                        ));
                                      },
                                    ),
                                  );
                          }),
                    ),
                ),
              ],
            );
      }),
    ));
  }
}
