import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/login_controller.dart';
import 'package:get/get.dart';
import '../../sales/constant/app_constants.dart';
import '../../sales/databaseHelper/login_repo.dart';
import '../model/material_store_model.dart';
import '../view/production_processing_screen.dart';
import 'package:http/http.dart' as http;

class ProcessController extends GetxController{
  LoginController loginController = Get.find<LoginController>();
  RxBool isDone = false.obs;
  List userWiseBusiness = [];

  Future<void> getBusinessList() async {
    try {
      isDone(true);
      userWiseBusiness = await LoginRepo().getFromBusinessTable();
      isDone(false);
      print('------user wise business List : $userWiseBusiness');
    } catch (error) {
      isDone(false);
      print('There are some issue: $error');
    }
  }

  //change image by business
  changeImage(String statusdemo) {
    switch (statusdemo) {
      case "Gazi Group":
        return "assets/images/logo/100000.png";

      case "GAZI SINKS":
        return "assets/images/logo/400060.png";

      case "GAZI DOORS":
        return "assets/images/logo/400070.png";

      case "GAZI TANKS":
        return "assets/images/logo/400080.png";

      case "GAZI PIPES":
        return "assets/images/logo/400090.png";

      default:
        return "assets/images/logo/100000.png";
    }
  }


  //for person information
  RxString pZid = ''.obs;
  void saveInfo(String zid){
    pZid.value = zid;
    Get.to(()=> ProductionProcessScreen());
  }

  //for entry operations
  RxString pXLong = ''.obs;
  RxString pXwh = '0'.obs;
  RxString totalMatSt = 'Raw Material Store'.obs;
  RxBool isLoading2 = false.obs;
  final RxList<MaterialStoreList> materialStoreList = <MaterialStoreList>[].obs;

  Future<void> getMaterialStore() async {
    try {
      isLoading2(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/production/MaterialStore.php?zid=${pZid.value}&xposition=${loginController.xposition.value}"));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var matStoreList = materialStoreListFromJson(response.body);
          materialStoreList.assignAll(matStoreList.map((e) => e));
          print('material stores are: $materialStoreList');
        } else {
          print('Response body is empty');
        }
      } else {
        print(
            'Error happens fetching dp numbers: ${response.statusCode}');
      }
    } catch (e) {
      print('Please check again: $e');
    } finally {
      isLoading2(false);
    }
  }

  void clearList(){
    materialStoreList.value = [];
  }
}