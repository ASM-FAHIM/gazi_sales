import 'package:get/get.dart';
import '../../constant/app_constants.dart';
import '../model/monthly_so_report.dart';
import '../model/pending_so_report_model.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  AppConstants appConstants = AppConstants();

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
