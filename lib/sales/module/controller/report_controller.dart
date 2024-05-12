import 'package:gazi_sales_app/sales/module/controller/login_controller.dart';
import 'package:get/get.dart';
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
import '../model/report_model/cus_ledger_model.dart';
import '../model/report_model/dealer-wise_deposit_model.dart';
import '../model/report_model/monthly_so_report_nodel.dart';
import '../model/report_model/pending_so_details.dart';
import '../model/report_model/pending_so_report_model.dart';
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
              .contains(searchQuery.value.toLowerCase()) ||
          dealer["xcus"].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          dealer["xphone"].toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void search(String query) {
    searchQuery.value = query;
  }

  void clearDealerList() {
    print("Clear dealer list before back to deposit entry screen : $dealerList");
    dealerList.clear();
    print("Clear dealer list after back to deposit entry screen : $dealerList");
  }

  //pending SO
  var pendingList = <PendingSoModel>[].obs;
  RxBool isLoading = false.obs;

  void fetchPendingSoList(String xCus) async {
    try {
      isLoading(true);
      print("http://${AppConstants.baseurl}/gazi/salesforce/reports/soSelect.php?zid=${loginController.zID.value}&xcus=$xCus");
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/soSelect.php?zid=${loginController.zID.value}&xcus=$xCus"));
      var soList = pendingSoModelFromJson(response.body);
      pendingList.assignAll(soList.map((e) => e));
    } finally {
      isLoading(false);
    }
  }

  //pending SO(delivery) details
  var pendDelDetails = <PendingSoDetailsModel>[].obs;

  RxBool fetDelDetail = false.obs;

  void fetchPendDelDetails(String xCus, String soNum) async {
    try {
      fetDelDetail(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/soqtyreport.php?zid=${loginController.zID.value}&xsonumber=$soNum"));
      var soDelList = pendingSoDetailsModelFromJson(response.body);
      pendDelDetails.assignAll(soDelList.map((e) => e));
      print('del details: $pendDelDetails');
    } finally {
      fetDelDetail(false);
    }
  }

  //clear list
  void clearList() {
    pendingList.clear();
    pendDelDetails.clear();
  }

  //value monthly report/last 5 order report
  var monthlySoList = <MonthlySoModel>[].obs;
  RxBool isLoading1 = false.obs;

  void fetchMonthlySoList(String xCus) async {
    try {
      isLoading1(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/salesOrderReport.php?zid=${loginController.zID.value}&xcus=$xCus"));
      var monSoList = monthlySoModelFromJson(response.body);
      monthlySoList.assignAll(monSoList.map((e) => e));
    } finally {
      isLoading1(false);
    }
  }

  //value monthly so details report
  var monthlySoDetailsList = <PendingSoDetailsModel>[].obs;
  RxBool soDelFetched = false.obs;

  void fetchMonthlySoDetailsList(String xCus, String soNum) async {
    try {
      soDelFetched(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/dailySODetails.php?zid=${loginController.zID.value}&xsonumber=$soNum"));
      var monSoList = pendingSoDetailsModelFromJson(response.body);
      monthlySoDetailsList.assignAll(monSoList.map((e) => e));
    } finally {
      soDelFetched(false);
    }
  }

  //customer ledger report

  //value
  var cusLedList = <CusLedgerListModel>[].obs;
  RxBool ledFetched = false.obs;

  void fetchLedgerReport(String xCus) async {
    try {
      ledFetched(true);

      print("http://${AppConstants.baseurl}/gazi/salesforce/reports/arHeadreport.php?zid=${loginController.zID.value}&xcus=$xCus");

      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/arHeadreport.php?zid=${loginController.zID.value}&xcus=$xCus"));
      var monSoList = cusLedgerListModelFromJson(response.body);
      cusLedList.assignAll(monSoList.map((e) => e));
    } finally {
      ledFetched(false);
    }
  }

/*//creating dropdown value
  //Bank list inserted into database
  RxBool soFetched = false.obs;
  List<BankListModel> bankList = [];

  Future<void> insertToBankTable() async {
    try {
      soFetched(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/deposit/bankList.php'));
      var monSoList = bankListModelFromJson(response.body);
      bankList.assignAll(monSoList.map((e) => e));
    } finally {
      soFetched(false);
    }
  }*/

  //value
  var dlrWiseDepo = <DealerWiseDepoModel>[].obs;
  RxBool isDepoFetched = false.obs;

  void dealerWiseDepo(String xCus) async {
    try {

      //print("http://${AppConstants.baseurl}/gazi/salesforce/reports/depositNotification.php?zid=${loginController.zID.value}&xcus=$xCus");
      isDepoFetched(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/reports/depositNotification.php?zid=${loginController.zID.value}&xcus=$xCus"));
      var depoList = dealerWiseDepoModelFromJson(response.body);
      dlrWiseDepo.assignAll(depoList.map((e) => e));
      print('Deposit list dealer wise');
    } finally {
      isDepoFetched(false);
    }
  }
}
