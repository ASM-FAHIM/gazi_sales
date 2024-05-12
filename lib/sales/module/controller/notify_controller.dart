import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../constant/app_constants.dart';
import '../model/depo_notification_model.dart';
import '../model/notification_model.dart';
import '../model/sroWiseTso_model.dart';
import '../model/tsoWise_dealerVisit_model.dart';
import '../model/tso_summary_model.dart';

class NotifyController extends GetxController {
  AppConstants appConstants = AppConstants();

  var notifyList = <NotificationModel>[].obs;
  RxBool isLoading = false.obs;

  void fetchSoNotification(String staff) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/salesforce/SO_notification.php?staff=$staff"));
      var notify = notificationModelFromJson(response.body);
      //print('So orders: ${response.body}');
      notifyList.assignAll(notify.map((e) => e));
    } finally {
      isLoading(false);
    }
  }

  void clearSoList() {
    notifyList.clear();
  }

  var depositNotifyList = <DepositNotificationModel>[].obs;
  RxBool isLoading1 = false.obs;

  void fetchDepositNotification(String staff, String zid) async {

    print("http://${AppConstants.baseurl}/gazi/deposit/depositNotification.php?staff=$staff&zid=$zid");
    try {
      isLoading1(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/gazi/deposit/depositNotification.php?staff=$staff&zid=$zid"));
      var depoNotify = depositNotificationModelFromJson(response.body);
      depositNotifyList.assignAll(depoNotify.map((e) => e));
    } finally {
      isLoading1(false);
    }
  }

  void clearDepositList() {
    depositNotifyList.clear();
  }

  //srowise tso list
  var sroWiseTSOList = <SroWiseTsoModel>[].obs;
  RxBool isTsoFetched = false.obs;

  void fetchSROWiseTSO(String zID, String xStaff) async {
    try {
      isTsoFetched(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/salesforce/SROwiseTSO.php?zid=$zID&staff=$xStaff"));
      var sroWiseTSO = sroWiseTsoModelFromJson(response.body);
      sroWiseTSOList.assignAll(sroWiseTSO.map((e) => e));
    } finally {
      isTsoFetched(false);
    }
  }

  //specific tso summary
  RxBool isDataFetched = false.obs;
  TsoSummaryModel? tsoSummary;

  Future<void> getTsoSummary(String zID, String tsoId) async {
    try {
      isDataFetched(true);
      DateTime now = DateTime.now();
      String month = DateFormat.M().format(now);
      String year = DateFormat.y().format(now);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/salesforce/SROwiseTSOdash.php?zid=$zID&tso=$tsoId&month_per=$month&xyear=$year'));
      tsoSummary = tsoSummaryModelFromJson(response.body);
      await fetchTSOWiseDealerVisit(tsoId);
      isDataFetched(false);
      print('Tso information : $tsoSummary');
    } catch (e) {
      isDataFetched(false);
      print('There is a issue occured when tso Summary fetching: $e');
      print('There is a issue occured when tso Summary fetching: $e');
    }
  }

  //specific tso dealer visit List
  var tsoWiseDealerVisit = <TsoWiseDealerVistListModel>[].obs;
  RxBool isDealerVisitFetched = true.obs;

  Future<void> fetchTSOWiseDealerVisit(String tsoID) async {
    try {
      isDealerVisitFetched(true);
      var response = await http.get(Uri.parse(
          "http://${AppConstants.baseurl}/salesforce/TSO_Dealer_visit.php?tso=$tsoID"));
      var tsoWiseDVisit = tsoWiseDealerVistListModelFromJson(response.body);
      tsoWiseDealerVisit.assignAll(tsoWiseDVisit.map((e) => e));
    } finally {
      isDealerVisitFetched(false);
      print('$tsoWiseDealerVisit');
    }
  }

  //switch case for color combination
  changeColor(String statusdemo) {
    switch (statusdemo) {
      case "Applied":
        return Colors.blueAccent;

      case "Approved":
        return Colors.green;

      case "Rejected":
        return Colors.red;

      case "Recommended":
        return Color(0xff5E9CF9);

      default:
        return Colors.purple;
    }
  }
}

/*
class NotificationAPI {
  Future<List<NotificationModel>> notifiGetAPI() async {
    var response =
    await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) debugPrint('--------------');
    log('Successfully fetched');
    debugPrint('--------------');
    return notificationModelFromJson(response.body);
  }
}*/
