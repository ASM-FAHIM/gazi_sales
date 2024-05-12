import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                return Column(
                  children: [

                    if(notifyController.depositNotifyList[index].xstatus == 'Rejected')...[
                      Container(
                        height: Dimensions.height200 + Dimensions.height150,
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
                              height: Dimensions.height45,
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
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        BigText(
                                          text: notifyController.depositNotifyList[index].xdate,
                                          size: 12,
                                          color: AppColor.defRed,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: notifyController.depositNotifyList[index].cusname,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _commonExpansionTileWidget('Deposit No', '${notifyController.depositNotifyList[index].xdepositnum}'),
                                          _commonExpansionTileWidget('Bank', '${notifyController.depositNotifyList[index].bankName}'),
                                          _commonExpansionTileWidget('Branch', '${notifyController.depositNotifyList[index].xbranch}'),
                                          _commonExpansionTileWidget('Type', '${notifyController.depositNotifyList[index].xarnature}'),
                                          _commonExpansionTileWidget('Check/Ref', '${notifyController.depositNotifyList[index].xdepositref}'),
                                          _commonExpansionTileWidget('Amount', '${notifyController.depositNotifyList[index].xamount} Tk.'),
                                          _commonExpansionTileWidget('Approver', '${notifyController.depositNotifyList[index].xidsup}, ${notifyController.depositNotifyList[index].sup_name}'),

                                          if(notifyController.depositNotifyList[index].xstatus == 'Rejected')...[
                                            _commonExpansionTileWidget('Reject Note', '${notifyController.depositNotifyList[index].reject_note}'),
                                          ]else...[

                                          ]

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
                      )
                    ]else...[
                      Container(
                        height: Dimensions.height200 + Dimensions.height100,
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
                              height: Dimensions.height45,
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
                                padding: const EdgeInsets.all(9.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        BigText(
                                          text: notifyController.depositNotifyList[index].xdate,
                                          size: 12,
                                          color: AppColor.defRed,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: notifyController.depositNotifyList[index].cusname,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _commonExpansionTileWidget('Deposit No', '${notifyController.depositNotifyList[index].xdepositnum}'),
                                          _commonExpansionTileWidget('Bank', '${notifyController.depositNotifyList[index].bankName}'),
                                          _commonExpansionTileWidget('Branch', '${notifyController.depositNotifyList[index].xbranch}'),
                                          _commonExpansionTileWidget('Type', '${notifyController.depositNotifyList[index].xarnature}'),
                                          _commonExpansionTileWidget('Check/Ref', '${notifyController.depositNotifyList[index].xdepositref}'),
                                          _commonExpansionTileWidget('Amount', '${notifyController.depositNotifyList[index].xamount} Tk.'),
                                          _commonExpansionTileWidget('Approver', '${notifyController.depositNotifyList[index].xidsup}, ${notifyController.depositNotifyList[index].sup_name}'),

                                          // if(notifyController.depositNotifyList[index].xstatus == 'Rejected')...[
                                          //   _commonExpansionTileWidget('Reject Note', '${notifyController.depositNotifyList[index].reject_note}'),
                                          // ]else...[
                                          //
                                          // ]

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
                      )
                    ]



                  ],
                );
              });
        }
      }),
    );
  }
  Widget _commonExpansionTileWidget(String tileName, String tileValue){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tileName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    //color: Color(0xff074974),
                  ),
                ),
                Text(':',style: GoogleFonts.poppins(
                  fontSize: 12,
                  //color: Color(0xff074974),
                ),),
              ],
            ),
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Text(tileValue,style: GoogleFonts.poppins(
              fontSize: 12,
              //color: Color(0xff074974),
            ),),
          )
        ],
      ),
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
