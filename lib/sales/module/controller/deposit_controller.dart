import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gazi_sales_app/sales/module/model/bank_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
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
  RxString selectedOption = 'Invoice type'.obs;

  //date Controller for take date
  TextEditingController dateController = TextEditingController();
  final date = DateTime.now().toString().obs;
  updateDate(DateTime dateTime){
    date.value = dateTime.toString();
  }


}