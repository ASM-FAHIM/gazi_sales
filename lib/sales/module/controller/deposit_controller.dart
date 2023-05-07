import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../databaseHelper/database_repo.dart';
import '../model/dealer_model.dart';
import 'login_controller.dart';

class DepositController extends GetxController{
  LoginController loginController = Get.find<LoginController>();

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


  //for entry operations
  RxString selectedOption = 'Invoice type'.obs;
  RxString paymentMod = 'Mode of payment'.obs;
  RxString bankSelection = 'Bank name'.obs;

  //date Controller for take date
  TextEditingController dateController = TextEditingController();
  final date = DateTime.now().toString().obs;
  updateDate(DateTime dateTime){
    date.value = dateTime.toString();
  }

}