import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/textContainerForQRscreen.dart';
import '../../controller/qr_controller.dart';
import 'mrp_notification_screen.dart';

class QrScreen extends StatefulWidget {
  String xSid;
  String xCus;
  String tsoId;
  String mobileNum;
  QrScreen({
    required this.xSid,
    required this.xCus,
    required this.tsoId,
    required this.mobileNum,
    Key? key
  }) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  QrController qrController = Get.put(QrController());

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
              text: 'Qr Scanner',
              color: AppColor.defWhite,
              size: 25,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(()=> MRPNotificationScreen(tsoId: widget.tsoId,));
                },
                icon: const Icon(MdiIcons.bellAlert, size: 30,),)
            ],
          ),
          body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: (){
                      qrController.scanQRCode();
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/qr-code.png'), fit: BoxFit.cover)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() =>
                          qrController.isDataFetched.value
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
                            : Container(
                              margin: EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  TextContainer(scannedText: 'Dealer Id : ${widget.xCus}',),
                                  TextContainer(scannedText: 'Mechanic Id : ${widget.xSid}',),
                                  TextContainer(scannedText: 'Generated code : ${qrController.qrScannedCode}',),
                                  TextContainer(scannedText: 'SKU : ${qrController.sku}',),
                                  TextContainer(scannedText: 'Batch: ${qrController.batch}',),
                                ],
                              ),
                            )
                          ),
                        SizedBox(height: 20,),
                        Container(
                          height: Dimensions.height50,
                          width:  Dimensions.height150 - Dimensions.height20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey, //New
                                    blurRadius: 5,
                                    offset: Offset(0, 0)
                                )
                              ]
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.appBarColor,
                            ),
                            onPressed: () async{
                              qrController.totalValueCalculate(widget.xSid, widget.xCus, widget.tsoId, widget.mobileNum);
                            },
                            child: qrController.isValuePosted.value
                            ? CircularProgressIndicator(color: AppColor.defWhite,)
                            : BigText(text: 'Submit', color: AppColor.defWhite,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        )
    );
  }
}

//body part previous
/*Obx(() =>
qrController.isDataFetched.value
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
    : Container(
alignment: Alignment.center,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('Generated Code: ${qrController.qrScannedCode}'),
Text('SKU : ${qrController.sku}'),
Text('Batch: ${qrController.batch}'),
Container(
height: Dimensions.height50,
width:  Dimensions.height150 - Dimensions.height20,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(50),
boxShadow: const [
BoxShadow(
color: Colors.grey, //New
blurRadius: 5,
offset: Offset(0, 0)
)
]
),
clipBehavior: Clip.hardEdge,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
primary: AppColor.appBarColor,
),
onPressed: () async{
qrController.totalValueCalculate();
},
child: BigText(text: 'Ok', color: AppColor.defWhite,),
),
),
],
),
)
),*/
