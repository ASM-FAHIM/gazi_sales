import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/model/bank_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
import '../../databaseHelper/deposit_repo.dart';
import '../model/deposit_number_model.dart';
import '../model/payment_model_model.dart';
import 'login_controller.dart';

class DepositController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  RxString dropDownValue = ''.obs;
  List<Map<String, dynamic>> dealerList = [];
  RxBool isLoading = false.obs;

  Future getDealerList() async {
    try {
      isLoading(true);
      List<dynamic> dealers = await DatabaseRepo().getDealer(
          loginController.xterritory.value, loginController.zID.value);
      // convert dealers to List<Map<String, dynamic>>
      dealerList =
          dealers.map((dealer) => dealer as Map<String, dynamic>).toList();
      print('Dealers list: $dealerList');
      isLoading(false);
    } catch (e) {
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

  RxBool isAllLoaded = false.obs;

  Future<void> fetchAll() async {
    try {
      isAllLoaded(true);
      print('=================${isAllLoaded.value}=================');
      await getInvoiceType();
      await getBankNames();
      await getPaymentType();
      isAllLoaded(false);
      print('=================${isAllLoaded.value}=================');
    } catch (e) {
      isAllLoaded(false);
      print('There is an error occured fetching all data: $e');
    }
  }

  /// bank lists
  RxString bankSelection = 'Bank name'.obs;
  RxString bankCode = ''.obs;
  RxBool bankLoaded = false.obs;
  List bankList = [];

  Future<void> getBankNames() async {
    try {
      bankLoaded(true);
      bankList =
          await DepositRepo().getFromBankTable(loginController.zID.value);
      print('bank name List : ${bankList}');
      bankLoaded(false);
    } catch (error) {
      bankLoaded(false);
      print('There are some issue: $error');
    }
  }

  /// bank lists
  RxString paymentMod = 'Mode of payment'.obs;
  RxBool isLoading2 = false.obs;
  List paymentList = [];

  Future<void> getPaymentType() async {
    try {
      isLoading2(true);
      paymentList =
          await DepositRepo().getFromPaymentTable(loginController.zID.value);
      print('bank name List : ${paymentList.length}');
      isLoading2(false);
      print('List of payment types: $paymentList');
    } catch (e) {
      print("Something went wrong in payment types $e");
    }
  }

  //for entry operations
  RxString invoiceType = 'Invoice type'.obs;
  RxBool isLoading3 = false.obs;
  List invoiceList = [];

  Future<void> getInvoiceType() async {
    try {
      isLoading3(true);
      invoiceList =
          await DatabaseRepo().getProductNature(loginController.zID.value);
      print('Invoice type : ${invoiceList.length}');
      isLoading3(false);
      print('Invoice type: $invoiceList');
    } catch (e) {
      print("Something went wrong in Invoice type: $e");
    }
  }

  //date Controller for take date
  TextEditingController dateController = TextEditingController();
  final date = DateTime.now().toString().obs;

  updateDate(DateTime dateTime) {
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

  Future<void> generateDPNumber() async {
    var response = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/deposit/getDPnum.php?zid=${loginController.zID.value}'));
    if (response.statusCode == 200) {
      DepositNumModel? data = depositNumModelFromJson(response.body);
      print('Deposit number : ${data.dPnum}');

      // Define the regular expression for the custom ID format
      final RegExp idFormat = RegExp(r'^DP--[0-9]{2}[0-9]{6,}$');

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

  //For Inserting to DepositTable
  RxBool saving = false.obs;
  RxBool isEmptyField = false.obs;
  RxInt depositTableMax = 0.obs;

  Future<void> insertToDeposit(
      String cusId,
      String xOrg,
      String status,
      String invoiceType,
      String bankName,
      String bankCode,
      String paymentType) async {
    try {
      if (amount.text.isEmpty ||
          bankName == 'Bank name' ||
          paymentType == 'Mode of Payment' ||
          invoiceType == 'Type') {
        saving(false);
        isEmptyField(true);
        Get.snackbar('Warning!',
            'Please fill up amount or bank name or payment type or customer bank or chck no or invoice type',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3));
      } else {
        saving(true);
        /*depositTableMax.value = await DepositRepo().getDepositID();
        var depositID = 'DP-00${(depositTableMax + 1)}';
        Map<String, dynamic> depositInsert = {
          "zid": loginController.zID.value,
          "depositID": depositID,
          "zauserid": loginController.xposition.value,
          "xcus": cusId,
          "xcusname": xOrg,
          "xtso": loginController.xtso.value,
          "xdivision": loginController.xDivision.value,
          "xamount": int.parse(amount.text),
          "xbank": bankName,
          "bankCode": bankCode,
          "xbranch": depositBranch.text,
          "xnote": note.text,
          "xpreparer": loginController.xstaff.value,
          "xdm": loginController.xDM.value,
          "xterritory": loginController.xterritory.value,
          "xzm": loginController.xZM.value,
          "xzone": loginController.xZone.value,
          "xarnature": invoiceType,
          "xpaymenttype": paymentMod.value,
          "xcusbank": cusBank.text,
          "xchequeno": chkRefNo.text,
          "xdate": date.value,
          "xstatus": status,
        };

        await DepositRepo().depositInsert(depositInsert);
        clearFields();
        print('Deposit added Successfully');
        Get.snackbar('Successful', 'Deposit added successfully',
            backgroundColor: Colors.white,
            duration: const Duration(seconds: 2));*/
        await generateDPNumber();
        var response = await http.post(
            Uri.parse(
                'http://${AppConstants.baseurl}/gazi/deposit/depositInsert.php'),
            body: jsonEncode(<String, dynamic>{
              "zid": loginController.zID.value,
              "zauserid": loginController.xstaff.value,
              "xdepositnum": depositNumber.value,
              "xcus": cusId,
              "xtso": loginController.xtso.value,
              "xdivision": loginController.xDivision.value,
              "xamount": amount.text,
              "xbank": bankCode,
              "xbranch": depositBranch.text,
              "xnote": note.text,
              "xpreparer": loginController.xstaff.value,
              "xdm": loginController.xDM.value,
              "xterritory": loginController.xterritory.value,
              "xzm": loginController.xZM.value,
              "xzone": loginController.xZone.value,
              "xarnature": invoiceType,
              "xpaymenttype": paymentType,
              "xcusbank": cusBank.text,
              "xchequeno": chkRefNo.text
            }));

        if (response.statusCode == 200) {
          Get.snackbar('Successful', 'Deposit submitted successfylly',
              backgroundColor: Colors.white,
              duration: const Duration(seconds: 2));
          clearFields();
          saving(false);
          isEmptyField(false);
          print('successfully depositted');
        } else {
          Get.snackbar('Warning!', 'There are some issue occurred',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 1));
          saving(false);
          isEmptyField(false);
          print("There is an Error ${response.statusCode}");
        }
      }
    } catch (e) {
      saving(false);
      isEmptyField(false);
      Get.snackbar('Warning!', 'Something went wrong while submit data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 1));
      print("Something went wrong while submit data $e");
    }
  }

  RxBool isSubmitted = false.obs;

  Future<void> depositSubmission() async {
    try {
      isSubmitted(true);
      for (int i = 0; i < openDeposit.length; i++) {
        await generateDPNumber();
        var response = await http.post(
            Uri.parse(
                'http://${AppConstants.baseurl}/gazi/deposit/depositInsert.php'),
            body: jsonEncode(<String, dynamic>{
              "zid": openDeposit[i]["zid"],
              "zauserid": openDeposit[i]["zauserid"],
              "xdepositnum": depositNumber.value,
              "xcus": openDeposit[i]["xcus"],
              "xtso": openDeposit[i]["xtso"],
              "xdivision": openDeposit[i]["xdivision"],
              "xamount": openDeposit[i]["xamount"],
              "xbank": openDeposit[i]["bankCode"],
              "xbranch": openDeposit[i]["xbranch"],
              "xnote": openDeposit[i]["xnote"],
              "xpreparer": openDeposit[i]["xpreparer"],
              "xdm": openDeposit[i]["xdm"],
              "xterritory": openDeposit[i]["xterritory"],
              "xzm": openDeposit[i]["xzm"],
              "xzone": openDeposit[i]["xzone"],
              "xarnature": openDeposit[i]["xarnature"],
              "xpaymenttype": openDeposit[i]["xpaymenttype"],
              "xcusbank": openDeposit[i]["xcusbank"],
              "xchequeno": openDeposit[i]["xchequeno"]
            }));

        if (response.statusCode == 200) {
          DepositRepo().updateDepositStatus(openDeposit[i]["depositID"]);
          print('successfully depositted');
        } else {
          Get.snackbar('Warning!', 'There are some issue occurred',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              duration: const Duration(seconds: 1));
          print("There is an Error ${response.statusCode}");
        }
      }
      await getOpenDeposit();
      Get.snackbar('Successful', 'Deposit submitted successfylly',
          backgroundColor: Colors.white, duration: const Duration(seconds: 2));
      isSubmitted(false);
    } catch (e) {
      isSubmitted(false);
      Get.snackbar('Warning!', 'Something went wrong while submit data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 1));
      print("Something went wrong while submit data $e");
    }
  }

  //For getting Open deposit from DepositTable
  RxBool isLoading4 = false.obs;
  List openDeposit = [];

  Future<void> getOpenDeposit() async {
    try {
      isLoading4(true);
      openDeposit =
          await DepositRepo().getOpenDeposit(loginController.zID.value);
      print('Open deposit: ${openDeposit.length}');
      isLoading4(false);
      print('List of payment types: $openDeposit');
    } catch (e) {
      print("Something went wrong in payment types $e");
    }
  }

  //For delete single deposit item
  Future<void> deleteFromDeposit(String depoID) async {
    try {
      await DepositRepo().singleDepositDelete(depoID);
      await getOpenDeposit();
      print('List of payment types: $openDeposit');
    } catch (e) {
      print("Something went wrong in payment types $e");
    }
  }

  void clearFields() {
    amount.clear();
    depositBranch.clear();
    invoiceType.value = 'Invoice type';
    paymentMod.value = 'Mode of payment';
    bankSelection.value = 'Bank name';
    cusBank.clear();
    chkRefNo.clear();
    note.clear();
  }
}
