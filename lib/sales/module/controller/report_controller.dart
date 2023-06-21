import 'package:gazi_sales_app/sales/module/controller/login_controller.dart';
import 'package:get/get.dart';
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
import '../model/monthly_so_report.dart';
import '../model/pending_so_report_model.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  AppConstants appConstants = AppConstants();

  List<Map<String, dynamic>> dealerList = [];
  RxBool isLoading3 = false.obs;

  Future getDealerList() async {
    try {
      isLoading3(true);
      List<dynamic> dealers = await DatabaseRepo().getDealer(
          loginController.xterritory.value, loginController.zID.value);
      // convert dealers to List<Map<String, dynamic>>
      dealerList =
          dealers.map((dealer) => dealer as Map<String, dynamic>).toList();
      print('Dealers list: $dealerList');
      isLoading3(false);
    } catch (e) {
      isLoading3(false);
      print('There is an error occurred getting dealer List from local DB: $e');
    }
  }

  //search mechanism for any name
  RxString searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredDeals {
    if (searchQuery.value.isEmpty) {
      return dealerList;
    } else {
      return dealerList
          .where((dealer) => dealer["xorg"]
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void search(String query) {
    searchQuery.value = query;
  }

  void clearDealerList() {
    print(
        "Clear dealer list before back to deposit entry screen : $dealerList");
    dealerList.clear();
    print("Clear dealer list after back to deposit entry screen : $dealerList");
  }

  //pending SO
  var pendingList = <PendingSoModel>[].obs;
  RxBool isLoading = false.obs;

  void fetchPendingSoList() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/soQtyreport.php?zid=400080"));
      var soList = pendingSoModelFromJson(response.body);
      pendingList.assignAll(soList.map((e) => e));
    } finally {
      isLoading(false);
    }
  }

  //value
  var monthlySoList = <MonthlySoModel>[].obs;
  RxBool isLoading1 = false.obs;

  void fetchMonthlySoList() async {
    try {
      isLoading1(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/arHeadreport.php?zid=400080"));
      var monSoList = monthlySoModelFromJson(response.body);
      monthlySoList.assignAll(monSoList.map((e) => e));
    } finally {
      isLoading1(false);
    }
  }
}
