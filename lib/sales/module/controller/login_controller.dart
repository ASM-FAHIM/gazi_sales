import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/databaseHelper/deposit_repo.dart';
import 'package:gazi_sales_app/sales/module/model/bank_list_model.dart';
import 'package:gazi_sales_app/sales/module/model/ca_cus_disc_model.dart';
import 'package:gazi_sales_app/sales/module/model/payment_model_model.dart';
import 'package:gazi_sales_app/sales/module/model/gift_promo_model/promo_details_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../constant/app_constants.dart';
import '../../databaseHelper/gift_promo_repo.dart';
import '../../databaseHelper/login_repo.dart';
import '../model/login_model.dart';
import '../model/tsolist_model.dart';
import '../model/user_wise_business_model.dart';
import '../view/dashboard_screen.dart';

class LoginController extends GetxController {
  Box? box1;
  RxString selectedOption = 'Type'.obs;

  //ei 3 ta value home screen a dhukar por database theke value get kore eikhane diye dicci
  RxString xposition = ''.obs;
  RxString xsid = ''.obs;
  RxString xstaff = ''.obs;

  //getTso info te ami xsp and xterritory er value set kore rakhsi territory info theke paowa

  RxString xtso = ''.obs;
  RxString invType = ''
      .obs; //ei value ta dealer screen theke product screen a jaowar somoy save kortesi
  RxString xwh = ''.obs;
  RxString xrole = ''.obs;
  RxString xName = ''.obs;
  RxString xterritory = ''.obs;
  RxString xZone = ''.obs;
  RxString xZM = ''.obs;
  RxString xDivision = ''.obs;
  RxString xDM = ''.obs;
  RxString xPNature = ''.obs;

  //user wise business inserted into database
  RxBool isDataLoaded = false.obs;
  List<UserWiseBusinessModel> businessList = [];

  Future<void> insertBusinessTable(String zemail) async {
    try {
      isDataLoaded(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/zid_sales.php?zemail=$zemail'));
      businessList = userWiseBusinessModelFromJson(response.body);
      await LoginRepo().deleteBusinessTable();
      (json.decode(response.body) as List).map((businessInfo) {
        LoginRepo().insertToBusinessTable(
            UserWiseBusinessModel.fromJson(businessInfo));
      }).toList();
      print('Business information : $businessList');
      isDataLoaded(false);
    } catch (e) {
      isDataLoaded(false);
      print('Failed to insert business: $e');
    }
  }

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

  void clearBusinessList() {
    userWiseBusiness.clear();
  }

  //xterritory loginMethod a value save kore rakhtesi for further use
  AppConstants appConstants = AppConstants();
  RxBool isLoading1 = false.obs;
  List<TsoInfoListModel>? tsoInfoListModel;

  Future<void> loginMethod() async {
    try {
      isLoading1(true);
      /*DateTime now = DateTime.now();
      String month = DateFormat.M().format(now);
      String year = DateFormat.y().format(now);*/
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/MonthlyTarget.php?tso=${xstaff.value}'));
      if (response.statusCode == 404) {
        isLoading1(false);
        Get.snackbar('Error', 'Something went wrong',
            backgroundColor: Colors.red, duration: const Duration(seconds: 1));
      } else if (response.statusCode == 200) {
        tsoInfoListModel = tsoInfoListModelFromJson(response.body);
        await dropTsoInfoTable();
        (json.decode(response.body) as List).map((tsoInfoList) {
          LoginRepo()
              .insertToTsoInfoTable(TsoInfoListModel.fromJson(tsoInfoList));
        }).toList();
        print('Tso information inserted : $tsoInfoListModel');
        isLoading1(false);
      }
    } catch (e) {
      print('There is a issue occured when tesoInfo fetching: $e');
    }
  }

  //delete tso_info table first
  Future dropTsoInfoTable() async {
    LoginRepo().deleteFromtsoInfoTable();
    print('Table deleted successfully');
  }

  //get tso info
  List tsoInfoList = [];

  Future getTsoInfo(String xTso, String xTerritory, String zone, String zm,
      String division, String dm) async {
    try {
      xtso.value = xTso;
      xterritory.value = xTerritory;
      xZone.value = zone;
      xZM.value = zm;
      xDivision.value = division;
      xDM.value = dm;
    } catch (error) {
      print('There are some issue: $error');
    }
    Get.to(() => DashboardScreen());
  }

  // tsoList_fetch in loginScreen
  RxBool isFetched = false.obs;
  List<TerritoryListModel>? territoryListModel;

  Future<Object> fetchTerritoryList() async {
    try {
      isFetched(true);
      var responseTerritoryList = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/tso_id.php?xstaff=${xstaff.value}'));
      if (responseTerritoryList.statusCode == 200) {
        territoryListModel =
            territoryListModelFromJson(responseTerritoryList.body);
        await dropTerritoryTable();
        print("Territory List = ${responseTerritoryList.body}");
        (json.decode(responseTerritoryList.body) as List).map((territoryList) {
          LoginRepo().insertToTerritoryTable(
              TerritoryListModel.fromJson(territoryList));
        }).toList();
        //fetch tsoInfo from login method and additional data like gift and promo
        await loginMethod();
        await insertToBankTable();
        await insertToPaymentTable();
        /*await getGiftItems();
        await insertToPromoHeaderTable();
        await insertToPromoDetailsTable();
        await insertToCaCusDiscTable();*/
        isFetched(false);
        Get.snackbar('Success', 'Data Fetched successfully',
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 1));
        return 'Territory list fetched Successfully';
      } else {
        Get.snackbar('Error', 'Something went wrong',
            backgroundColor: Colors.red, duration: const Duration(seconds: 1));
        print('Error occurred: ${responseTerritoryList.statusCode}');
        isFetched(false);
        return 'Error in fetching data';
      }
    } catch (error) {
      print('There is a issue occured when territory fetching: $error');
      isFetched(false);
      return 'Error in the method';
    }
  }

  //delete territory table first
  Future dropTerritoryTable() async {
    LoginRepo().deleteFromTerritoryTable();
    print('Table deleted successfully');
  }

/*  //delete cuc wise product first
  Future deleteDealerVisitTable() async{
    LoginRepo().deleteFromDealerVisitTable();
    print('Table deleted successfully');
  }*/

  //get territory list
  //for territory screen and go on
  RxString zID = ''.obs;
  List territoryList = [];
  RxBool territoryFetched = false.obs;

  Future getTerritory(String zid, String businessSupID) async {
    try {
      territoryFetched(true);
      zID.value = zid;
      xsid.value = businessSupID;
      print('Business superior ID after entering business: $xsid');
      territoryList = await LoginRepo().getTerritoryList(zid);
      print('------Territory List : $territoryList');
      territoryFetched(false);
    } catch (error) {
      territoryFetched(false);
      print('There are some issue: $error');
    }
  }

  void clearTerritoryList() {
    territoryList = [];
    zID.value = ' ';
    xsid.value = ' ';
  }

  //For obscure text
  var obscureText = true.obs;

  void toggle() {
    obscureText.value = !obscureText.value;
  }

  RxDouble curntLong = 0.0.obs;
  RxDouble curntLat = 0.0.obs;
  double? distance;
  Position? position;

  Future<void> periodicallyLocationTracking() async {
    await getGeoLocationPosition();
    await getAddressFromLatLong();
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    curntLat.value = position!.latitude;
    curntLong.value = position!.longitude;
    print('Actual position is : $position');
    print('Actual Current Latitude is : ${curntLat.value}');
    print('Actual Current Longitude is : ${curntLong.value}');
    return position!;
  }

  RxString addressInOut = ''.obs;

  Future<void> getAddressFromLatLong() async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    curntLat.value = position!.latitude;
    curntLong.value = position!.longitude;
    Placemark place = placeMarks[1];
    addressInOut.value = '${place.name}, ${place.locality}, ${place.country}';
    print('My exact location is : $addressInOut');
  }

  //Bank list inserted into database
  RxBool isBankFetched = false.obs;
  List<BankListModel> bankList = [];

  Future<void> insertToBankTable() async {
    try {
      isBankFetched(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/deposit/bankList.php'));
      print('list of banks: ${response.body}');
      if (response.statusCode == 200) {
        bankList = bankListModelFromJson(response.body);
        print('list of banks: ${response.body}');
        await Future.wait(bankList.map((bank) {
          return DepositRepo().insertIntoBankTable(bank);
        }).toList());
        isBankFetched(false);
        print('Bank names: $bankList');
      } else {
        isBankFetched(false);
        print("There is an Error getting banks: ${response.statusCode}");
      }
    } catch (e) {
      isBankFetched(false);
      print('Failed to insert banks: $e');
    }
  }

  //payment method inserted into database
  RxBool isPaymentFetched = false.obs;
  List<PaymentModeModel> paymentList = [];

  Future<void> insertToPaymentTable() async {
    try {
      isBankFetched(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/deposit/paymentMode.php'));
      print('list of payment methods: ${response.body}');
      if (response.statusCode == 200) {
        paymentList = paymentModeModelFromJson(response.body);
        print('list of payment methods: ${response.body}');
        await Future.wait(paymentList.map((modOfPayment) {
          return DepositRepo().insertIntoPaymentTable(modOfPayment);
        }).toList());
        isBankFetched(false);
        print('Payment modes : $paymentList');
      } else {
        isBankFetched(false);
        print("There is an Error getting banks: ${response.statusCode}");
      }
    } catch (e) {
      isBankFetched(false);
      print('Failed to insert banks: $e');
    }
  }

/*  //Insert promo header into promoHeader Table
  RxBool pHeader = false.obs;
  List<PromoHeaderModel> promoHeaderList = [];

  Future<void> insertToPromoHeaderTable() async {
    try {
      pHeader(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/promotionHeader.php'));
      if (response.statusCode == 200) {
        promoHeaderList = promoHeaderModelFromJson(response.body);
        print('list of promoHeaderList: ${response.body}');
        await Future.wait(promoHeaderList.map((pHeader) {
          return GiftPromoRepo().insertIntoPromoHeaderTable(pHeader);
        }).toList());
        pHeader(false);
        print('promo header: $promoHeaderList');
      } else {
        pHeader(false);
        print("There is an Error getting promo header: ${response.statusCode}");
      }
    } catch (e) {
      pHeader(false);
      print('Failed to insert promo header: $e');
    }
  }

  //Insert promo header into promoHeader Table
  RxBool pDetails = false.obs;
  List<PromoDetailsrModel> promoDetailsList = [];

  Future<void> insertToPromoDetailsTable() async {
    try {
      pDetails(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/promotionDetails.php'));
      if (response.statusCode == 200) {
        promoDetailsList = promoDetailsrModelFromJson(response.body);
        print('list of promoDetailsList: ${response.body}');
        await Future.wait(promoDetailsList.map((pDetails) {
          return GiftPromoRepo().insertIntoPromoDetailsTable(pDetails);
        }).toList());
        pDetails(false);
        print('Promo details: $promoDetailsList');
      } else {
        pDetails(false);
        print("There is an Error getting pro details: ${response.statusCode}");
      }
    } catch (e) {
      pDetails(false);
      print('Failed to insert promo details : $e');
    }
  }

  //Insert into cacusdisc Table
  RxBool caCusDisInserted = false.obs;
  List<CaCusDiscModel> caCusDisList = [];

  Future<void> insertToCaCusDiscTable() async {
    try {
      caCusDisInserted(true);
      var response = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/caCusDisc.php'));
      if (response.statusCode == 200) {
        caCusDisList = caCusDiscModelFromJson(response.body);
        print('list of caCusDisList: ${response.body}');
        await Future.wait(caCusDisList.map((cacusdisc) {
          return GiftPromoRepo().insertIntoCaCusDiscTable(cacusdisc);
        }).toList());
        caCusDisInserted(false);
        print('caCusDisList: $caCusDisList');
      } else {
        caCusDisInserted(false);
        print("There is an Error getting caCusDisList: ${response.statusCode}");
      }
    } catch (e) {
      caCusDisInserted(false);
      print('Failed to insert caCusDisTable : $e');
    }
  }*/

/*  //insert to gift item table
  ///git and promo items
  RxBool isLoading6 = false.obs;
  List<GiftModel> addGiftList = [];

  Future<Object> getGiftItems() async {
    try {
      isLoading6(true);
      var responseGiftItems = await http.get(Uri.parse(
          'http://${AppConstants.baseurl}/gazi/salesforce/giftitem.php'));
      if (responseGiftItems.statusCode == 200) {
        addGiftList = giftModelFromJson(responseGiftItems.body);
        print('gift List : $addGiftList');
        await Future.wait(addGiftList.map((gifts) {
          return GiftPromoRepo().insertIntoGiftItem(gifts);
        }).toList());
        isLoading6(false);
        return 'Gift Item fetched Successfully';
      } else {
        isLoading6(false);
        print(
            "The model has no value to insert : ${responseGiftItems.statusCode}");
        return responseGiftItems.statusCode;
      }
    } catch (e) {
      print("Something went wrong $e");
      return isLoading6(false);
    }
  }*/

  /// for production purpose
  RxString zId = ''.obs;

}
