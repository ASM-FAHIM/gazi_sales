import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/model/bank_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
import '../model/deposit_number_model.dart';
import '../model/payment_model_model.dart';
import 'login_controller.dart';

class DepositController extends GetxController{
  LoginController loginController = Get.find<LoginController>();
  RxString dropDownValue = ''.obs;
  List<Map<String, dynamic>> dealerList = [];
  RxBool isLoading = false.obs;
  Future getDealerList() async {
    try {
      isLoading(true);
      List<dynamic> dealers = await DatabaseRepo().getDealer(loginController.xterritory.value, loginController.zID.value);
      // convert dealers to List<Map<String, dynamic>>
      dealerList = dealers.map((dealer) => dealer as Map<String, dynamic>).toList();
      print('Dealers list: $dealerList');
      isLoading(false);
    } catch(e) {
      isLoading(false);
      print('There is an error occurred getting dealer List from local DB: $e');
    }
  }

  //search mechanism for any name
  RxString searchQuery = ''.obs;
  List<Map<String, dynamic>> get filteredDeals {
    if (searchQuery.value.isEmpty) {
      return dealerList;
    } else {
      return dealerList.where((dealer) =>
          dealer["xorg"].toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }

  void search(String query) {
    searchQuery.value = query;
  }

  void clearDealerList(){
    print("Clear dealer list before back to deposit entry screen : $dealerList");
    dealerList.clear();
    print("Clear dealer list after back to deposit entry screen : $dealerList");
  }

  RxBool isAllLoaded = false.obs;
  Future<void> fetchAll() async{
    try{
      isAllLoaded(true);
      await getBankNames();
      await getPaymentType();
      isAllLoaded(false);
    }catch(e){
      isAllLoaded(false);
      print('There is an error occured fetching all data: $e');
    }

  }


  /// bank lists
  RxString bankSelection = 'Bank name'.obs;
  RxBool isLoading1 = false.obs;
  final bankList = <BankListModel>[].obs;
  Future<void> getBankNames() async{
    try{
      isLoading1(true);
      //new dealer api for petronas http://${AppConstants.baseurl}/salesforce/dealerinfo.php?user=1000
      var response = await http.get(Uri.parse('http://${AppConstants.baseurl}/gazi/deposit/bankList.php?zid=${loginController.zID.value}'));
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final bankNames = <BankListModel>[];
        for(var bankList in jsonData){
          bankNames.add(BankListModel.fromJson(bankList));
        }
        bankList.assignAll(bankNames);
        isLoading1(false);
        print('List of banks: $bankList');
      }else{
        isLoading1(false);
        print("There is an Error ${response.statusCode}");
      }
    }catch(e){
      print("Something went wrong in bank list $e");
    }
  }

  /// bank lists
  RxString paymentMod = 'Mode of payment'.obs;
  RxBool isLoading2 = false.obs;
  final paymentList = <PaymentModeModel>[].obs;
  Future<void> getPaymentType() async{
    try{
      isLoading2(true);
      var response = await http.get(Uri.parse('http://${AppConstants.baseurl}/gazi/deposit/paymentMode.php?zid=${loginController.zID.value}'));
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final payments = <PaymentModeModel>[];
        for(var paymentList in jsonData){
          payments.add(PaymentModeModel.fromJson(paymentList));
        }
        paymentList.assignAll(payments);
        isLoading2(false);
        print('List of payment types: $paymentList');
      }else{
        isLoading2(false);
        print("There is an Error ${response.statusCode}");
      }
    }catch(e){
      print("Something went wrong in payment types $e");
    }
  }


  //for entry operations
  RxString selectedOption = 'Type'.obs;

  //date Controller for take date
  TextEditingController dateController = TextEditingController();
  final date = DateTime.now().toString().obs;
  updateDate(DateTime dateTime){
    date.value = dateTime.toString();
  }

  //for submit operation
  TextEditingController amount = TextEditingController();
  TextEditingController depositBranch = TextEditingController();
  TextEditingController cusBank = TextEditingController();
  TextEditingController chkRefNo = TextEditingController();
  TextEditingController note = TextEditingController();

  //generate random deposit number
  // Define the custom ID string
  RxString depositNumber = ''.obs;
  Future<void> generateDPNumber() async{
    var response = await http.get(Uri.parse('http://${AppConstants.baseurl}/gazi/deposit/getDPnum.php?zid=${loginController.zID.value}'));
    if(response.statusCode == 200) {
      DepositNumModel? data = depositNumModelFromJson(response.body);
      print('Deposit number : ${data.dPnum}');

      // Define the regular expression for the custom ID format
      final RegExp idFormat = RegExp(r'^DP--[0-9]{2}[0-9]{4,}$');

      // Define a function to generate the custom ID
      // Get the current date
      var now = DateTime.now();

      // Get the year and month as two digits each
      var year = now.year.toString().substring(2, 4);
     // var month = now.month.toString().padLeft(2, '0');

      // Assemble the custom ID string
      depositNumber.value = 'DP--$year${data.dPnum}';
      print('Actual DP number is : ${depositNumber.value}');

      // Validate the custom ID using the regular expression
      if (!idFormat.hasMatch(depositNumber.value)) {
        throw Exception(
            'Generated custom ID does not match the required format');
      }
    }
  }


  RxBool isSubmitted = false.obs;
  Future<void> depositSubmission(String cusId,String bankName,String paymentNature,String paymentType) async{
    try{
      if(amount.text.isEmpty || bankName == 'Bank name' || paymentType == 'Mode of Payment' || selectedOption.value == 'Type'){
        isSubmitted(false);
        Get.snackbar(
            'Warning!',
            'Please fill up amount or bank name or payment type or customer bank or chck no or invoice type',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3)
        );
      }else{
        isSubmitted(true);
        await generateDPNumber();
        var response = await http.post(
            Uri.parse('http://${AppConstants.baseurl}/gazi/deposit/depositInsert.php'),
            body: jsonEncode(<String, dynamic>{
              "zid": loginController.zID.value,
              "zauserid": loginController.xposition.value,
              "xdepositnum": depositNumber.value,
              "xcus": cusId,
              "xtso": loginController.xtso.value,
              "xdivision": loginController.xDivision.value,
              "xamount": int.parse(amount.text),
              "xbank": bankName,
              "xbranch": depositBranch.text,
              "xnote": note.text,
              "xpreparer": loginController.xstaff.value,
              "xdm": loginController.xDM.value,
              "xterritory": loginController.xterritory.value,
              "xzm": loginController.xZM.value,
              "xzone": loginController.xZone.value,
              "xarnature": paymentNature,
              "xpaymenttype": paymentType,
              "xcusbank": cusBank.text,
              "xchequeno": chkRefNo.text
            })
        );
        if(response.statusCode == 200){
          isSubmitted(false);
          clearFields();
          Get.snackbar(
              'Successful',
              'Deposit submitted successfylly',
              backgroundColor: Colors.white,
              duration: const Duration(seconds: 2));
          print('successfully depositted');
        }else{
          isSubmitted(false);
          Get.snackbar(
              'Warning!',
              'There are some issue occurred',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 1)
          );
          print("There is an Error ${response.statusCode}");
       }
      }
    }catch(e){
      isSubmitted(false);
      Get.snackbar(
          'Warning!',
          'Something went wrong while submit data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 1)
      );
      print("Something went wrong while submit data $e");
    }
  }
  void clearFields(){
    amount.clear();
    depositBranch.clear();
    paymentMod.value = 'Mode of payment';
    bankSelection.value = 'Bank name';
    cusBank.clear();
    chkRefNo.clear();
    note.clear();
  }
}