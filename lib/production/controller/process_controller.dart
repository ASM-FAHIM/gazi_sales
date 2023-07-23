import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/login_controller.dart';
import 'package:get/get.dart';
import '../../sales/constant/app_constants.dart';
import '../../sales/databaseHelper/login_repo.dart';
import '../model/machine_model.dart';
import '../model/machine_name_model.dart';
import '../model/material_store_model.dart';
import '../model/shift_model.dart';
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

  //for machineNo
  //for entry operations
  RxString pXcode = ''.obs;
  RxString pXlong = ''.obs;
  RxString totalMachNo = 'Raw Material Store'.obs;
  RxBool isLoading3 = false.obs;
  final RxList<MachineModel> machineNoList = <MachineModel>[].obs;

  Future<void> getMachineNo() async {
    try {
      isLoading3(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/production/machineNo.php?zid=${pZid.value}"));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var machineList = machineModelFromJson(response.body);
          machineNoList.assignAll(machineList.map((e) => e));
          print('machine no are: $machineNoList');
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
      isLoading3(false);
    }
  }

  //for machine name
  RxString mXcode = ''.obs;
  RxString mXlong = ''.obs;
  RxString totalMachName = 'Raw Material Store'.obs;
  RxBool isLoading4 = false.obs;
  final RxList<MachineNameModel> machineNameList = <MachineNameModel>[].obs;

  Future<void> getMachineName() async {
    try {
      isLoading4(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/production/machineName.php?zid==${pZid.value}"));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var machineList = machineNameModelFromJson(response.body);
          machineNameList.assignAll(machineList.map((e) => e));
          print('machine no are: $machineNameList');
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
      isLoading4(false);
    }
  }

  //for shift
  RxString sXcode = ''.obs;
  RxString sXlong = ''.obs;
  RxString totalShift = 'Raw Material Store'.obs;
  RxBool isLoading5 = false.obs;
  final RxList<ShiftModel> shiftList = <ShiftModel>[].obs;

  Future<void> getShift() async {
    try {
      isLoading5(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/production/machineName.php?zid==${pZid.value}"));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var machineList = shiftModelFromJson(response.body);
          shiftList.assignAll(machineList.map((e) => e));
          print('machine no are: $shiftList');
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
      isLoading5(false);
    }
  }

  RxBool isFetched = false.obs;
  void fetchAllList() async{
    try{
      isFetched(true);
      await getMaterialStore();
      await getMachineNo();
      await getMachineName();
      await getShift();
    } catch (e) {
      print("Something went wrong $e");
      isFetched(false);
    }finally{
     isFetched(false);
    }
  }


  void clearList(){
    materialStoreList.value = [];
  }
}