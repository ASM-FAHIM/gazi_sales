import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constant/app_constants.dart';
import '../model/dealer_model.dart';
import '../model/mechanic_list_model.dart';
import '../model/mrp_notification_model.dart';
import '../model/qr_return_model.dart';
import 'login_controller.dart';

class QrController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  RxString qrScannedCode = ''.obs;
  RxString firstChar = ' '.obs;
  RxString sku = ' '.obs;
  RxString batch = ' '.obs;
  RxString disc = ' '.obs;
  RxDouble result = 0.0.obs;

  //Dealer list fetching for mechanic and qr scanner
  ///dealer fetch and insert to local db
  RxBool isLoading1 = false.obs;
  final dealerList = <DealerModel>[].obs;
  void getDealerInfo(String xso) async{
    try{
      isLoading1(true);
      //new dealer api for petronas http://${AppConstants.baseurl}/salesforce/dealerinfo.php?user=1000
      var response = await http.get(Uri.parse('http://${AppConstants.baseurl}/salesforce/dealerinfo.php?xsp=$xso'));
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final dealers = <DealerModel>[];
        for(var dealersList in jsonData){
          dealers.add(DealerModel.fromJson(dealersList));
        }
        dealerList.assignAll(dealers);
        isLoading1(false);
        print('List of Dealers: $dealers');
      }else{
        isLoading1(false);
        print("There is an Error ${response.statusCode}");
      }
    }catch(e){
      print("Something went wrong $e");
    }
  }

  //search mechanism for any name
  RxString searchQuery = ''.obs;
  List<DealerModel> get filteredDeals {
    if (searchQuery.value.isEmpty) {
      return dealerList;
    } else {
      return dealerList.where((dealer) =>
          dealer.xorg.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }

  void search(String query) {
    searchQuery.value = query;
  }


  //Fetch Mechanic information
  var isLoading = false.obs;
  List<MechanicModel> mechanicList = [];
  Future fetchMechanicList(String xcus) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse("http://${AppConstants.baseurl}/salesforce/scanner/machanic_list.php?xcus=$xcus"));
      mechanicList = mechanicModelFromJson(response.body);
      print('MechanicList = $mechanicList');
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetMechanicList() async{
     mechanicList = [];
  }

  RxBool isDataFetched = false.obs;
  QrReturnModel? qrValues;
  Future<void> scanQRCode() async {
    try {
      isDataFetched(true);
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      // qrScannedCode.value = qrCode;
      // firstChar.value = qrCode[0];
      var response = await http.get(Uri.parse("http://${AppConstants.baseurl}/salesforce/scanner/QRcodeCheck.php?code=$qrCode&userId=${loginController.xposition.value}"));
      if(response.statusCode == 200){
        qrValues = qrReturnModelFromJson(response.body);
        qrScannedCode.value = qrValues!.xid;
        //firstChar.value = qrCode[0];
        sku.value = qrValues!.xbase;
        batch.value = qrValues!.xbatch;
        disc.value = qrValues!.xdisc;
        isDataFetched(false);
        print('=================${qrValues!.xid} =================');
      }else{
        isDataFetched(false);
        print('The qr code is: $qrCode');
        print('The qr code is: $qrCode');
        qrScannedCode.value = 'Invalid code';
        Get.snackbar(
            'Error',
            'Product already scanned',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 1)
        );
      }
    } on PlatformException {
      qrScannedCode.value = 'Failed to get platform version.';
    }
  }


  // for calculate total value
  RxBool isValuePosted = false.obs;
  Future totalValueCalculate(String xSID, String xCUS, String tsoID, String mobileNum) async{
    print('=================${qrScannedCode.value} =================');
    print('=================${firstChar.value}=================');
    try{
      isValuePosted(true);
      /*if(firstChar.value == 'A'){
        result.value = 1 * double.parse(sku.value);
        print('-----------------$result----------');
      }else if(firstChar.value == 'B'){
        result.value  = 2 * double.parse(sku.value);
        print('-----------------$result----------');
      }else if(firstChar.value == 'C'){
        result.value  = 5 * double.parse(sku.value);
        print('-----------------$result----------');
      }else if(firstChar.value == 'D'){
        result.value  = 18 * double.parse(sku.value);
        print('-----------------$result----------');
      }else if(firstChar.value == 'E'){
        result.value  = 25 * double.parse(sku.value);
        print('-----------------$result----------');
      }else{
        Get.snackbar('title', 'message');
      }
      isValuePosted(false);*/
      var response = await http.post(Uri.parse('http://${AppConstants.baseurl}/salesforce/scanner/QR_submit.php'),
          body: jsonEncode(<String, dynamic>{
            "zauserid": loginController.xposition.value,
            "zid": 300210,
            "xid": qrScannedCode.value,
            "xsid": xSID,
            "xcus": xCUS,
            "xtso": tsoID,
            "xmobile": mobileNum,
            "xdisc": disc.value,
            "xbase": sku.value
          })
      );
      if(response.statusCode == 200){
        isValuePosted(false);
        Get.snackbar(
            'Success',
            'Submitted successfully',
            backgroundColor: Colors.white,
            colorText: Colors.black,
            duration: const Duration(seconds: 1)
        );
        resetQrValues();
        print('------------${response.body}');
        print('Success: ${response.statusCode}');
      }else{
        isValuePosted(false);
        print('Something went wrong: ${response.statusCode}');
      }
    }catch(e){
      isValuePosted(false);
      print('Failed to post values due to: $e');
    }
  }

  void resetQrValues(){
    qrScannedCode.value = ' ';
    firstChar.value = ' ';
    sku.value = ' ';
    batch.value = ' ';
    disc.value = ' ';
  }

  //fetch mrp notification
  //Dealer list fetching for mechanic and qr scanner
  ///dealer fetch and insert to local db
  RxBool isMrpFetched = false.obs;
  final mrpList = <MrpNotificationListModel>[].obs;
  void getMRPNotification(String tsoId) async{
    try{
      isMrpFetched(true);
      //new dealer api for petronas http://${AppConstants.baseurl}/salesforce/dealerinfo.php?user=1000
      var response = await http.get(Uri.parse('http://172.20.20.69/salesforce/scanner/MIP_nitification.php?tso=$tsoId'));
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final mrpNotifyList = <MrpNotificationListModel>[];
        for(var mrpNotify in jsonData){
          mrpNotifyList.add(MrpNotificationListModel.fromJson(mrpNotify));
        }
        mrpList.assignAll(mrpNotifyList);
        isMrpFetched(false);
        print('List of incentives: $mrpNotifyList');
      }else{
        isMrpFetched(false);
        print("There is an Error ${response.statusCode}");
      }
    }catch(e){
      isMrpFetched(false);
      print("Something went wrong $e");
    }
  }
  void resetMrp(){
    mrpList.value = [];
  }
}
