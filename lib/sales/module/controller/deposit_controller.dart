import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../constant/app_constants.dart';
import '../../databaseHelper/database_repo.dart';
import '../../databaseHelper/deposit_repo.dart';
import '../model/deposit_number_model.dart';
import 'login_controller.dart';

class DepositController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  RxString dropDownValue = ''.obs;
  List<Map<String, dynamic>> dealerList = [];
  RxBool isLoading = false.obs;

  RxString paymentMode = 'Cash'.obs; // Set the default value to 'Cash'

  // Define TextEditingController instances
  TextEditingController chkRefNoController = TextEditingController();
  TextEditingController cusBankController = TextEditingController();
  // deposit_controller.dart
  final RxBool isPaymentFieldsEmpty = RxBool(false);

  final RxBool isChkRefNoEmpty = false.obs;
  final RxBool isCusBankEmpty = false.obs;
  final isChkRefNoRequired = false.obs;
  final isCusBankRequired = false.obs;

  final isDateRequired = false.obs;

  void updatePaymentFields(String paymentMode, {String chkRefNo = '', String customerBank = ''}) {
    // Reset the required flags when "Cash" is selected
    isChkRefNoRequired.value = paymentMode != 'Cash';
    isCusBankRequired.value = paymentMode != 'Cash';

    // Update any other necessary fields or logic based on the provided values
    chkRefNoController.text = chkRefNo; // Use the TextEditingController instance
    cusBankController.text = customerBank; // Use the TextEditingController instance

    // Validate payment fields whenever payment mode is changed
    validatePaymentFields();

    if (paymentMode == 'Cash') {
      isChkRefNoRequired.value = false;
      isCusBankRequired.value = false;
    } else {
      // Update the required flags based on the field values
      isChkRefNoRequired.value = (chkRefNo.isEmpty);
      isCusBankRequired.value = (customerBank.isEmpty);
    }

    // Validate payment fields after updating each field individually
    validatePaymentFields();
  }





  @override
  void dispose() {
    chkRefNoController.dispose();
    cusBankController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    // Set the initial value of invoiceType to 'Cash'
    paymentMod.value = 'Cash';
  }



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
          .where((dealer) => dealer["xorg"].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          dealer["xcus"].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          dealer["xphone"].toLowerCase().contains(searchQuery.value.toLowerCase()))
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

  var isPaymentCash = true.obs;


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

  //Reference mantatory for MR
  final RxBool isReferenceRequired = false.obs;

  void partpayment_value(String value) {
    partpayment.value = value;
    if (value == 'Yes') {
      isReferenceRequired.value = true;
    } else {
      isReferenceRequired.value = false;
    }
  }

  // //Reference mantatory for MR
  // final RxBool isModeRequired = false.obs;
  //
  // void modepayment_value(String value) {
  //   cusBank.text = value;
  //   if (value != 'Cash') {
  //     isModeRequired.value = true;
  //   } else {
  //     isModeRequired.value = false;
  //   }
  // }


  // deposit_controller.dart
  bool validatePaymentFields() {
    if (paymentMod.value != 'Cash') {
      if (( chkRefNo.text.isEmpty) ||
          (cusBank.text.isEmpty) ||
          date.value.isEmpty) {
        isPaymentFieldsEmpty.value = true;
        return false;
      }
    }
    isPaymentFieldsEmpty.value = false;
    return true;
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

  var incentiveApplicableMonthly = 'Yes'.obs; // Default value is 'Yes'

  void setSelectedValueMonthly(String value) {
    incentiveApplicableMonthly.value = value;
  }


  var incentiveApplicableYearly = 'Yes'.obs;
  var partpayment = 'No'.obs;
  // Default value is 'Yes'

  void setSelectedValueYearly(String value) {
    incentiveApplicableYearly.value = value;
  }

  bool validateReferenceField() {
    final isReferenceEmpty = reference.text.isEmpty;
    final isAmountEmpty = amount.text.isEmpty;
    print(paymentMod.value != 'Cash' && depositBranch.text.isEmpty);
    if ((isReferenceRequired.value && partpayment.value == 'Yes' && isReferenceEmpty) ||
        isAmountEmpty ||
        (!isPaymentCash.value && cusBank.text.isEmpty) ||
        (!isPaymentCash.value && chkRefNo.text.isEmpty) ||
        (!isPaymentCash.value && date.value.isEmpty)) {
      isEmptyField.value = true;
      return false;
    } else {
      isEmptyField.value = false;
      return true;
    }
  }

  // bool validateCusBankField() {
  //   final isCusBankEmpty = cusBank.text.isEmpty;
  //   final ischkRefNoEmpty = chkRefNo.text.isEmpty;
  //   final isDepoDateEmpty = date.value.toString().isEmpty;
  //   print(paymentMod.value != 'Cash' && depositBranch.text.isEmpty);
  //   if ((isModeRequired.value && cusBank.text != 'Cash' && isCusBankEmpty) ||
  //       ischkRefNoEmpty || isDepoDateEmpty) {
  //     isEmptyField.value = true;
  //     return false;
  //   } else {
  //     isEmptyField.value = false;
  //     return true;
  //   }
  // }

  //date Controller for take date
  TextEditingController dateController = TextEditingController();
  final date = ''.obs;
  final depositedate = ''.obs;

  updateDate(DateTime dateTime) {
    date.value = DateFormat.yMMMd().format(DateTime.parse(dateTime.toString()));
    print('Deposit date value: ${date.value}');
  }


  depositedateupdateDate(DateTime dateTime) {
    depositedate.value = DateFormat.yMMMd().format(DateTime.parse(dateTime.toString()));
    print('Deposit date value: ${depositedate.value}');
  }


  //for submit operation
  TextEditingController reference = TextEditingController();
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
      // Check if any required field is empty
      if (amount.text.isEmpty ||
          bankName == 'Bank name' ||
          paymentType == 'Mode of Payment' ||
          invoiceType == 'Invoice type' || // Modify 'Type' to 'Invoice type'
          (!isPaymentCash.value && chkRefNo.text.isEmpty) ||
          (!isPaymentCash.value && date.value.isEmpty) ||
          (!isPaymentCash.value && cusBank.text.isEmpty)) {
        Get.snackbar(
          'Warning!',
          'Please fill up all required fields', // Update the message
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        return; // Exit the method early
      } else {
        saving(true);
        await generateDPNumber();
        // Convert amount text to a double, removing any commas
        String amountTextWithoutCommas = amount.text.replaceAll(',', '');
        double amountValue = double.parse(amountTextWithoutCommas);


        print("DM Print: ${loginController.xDM.value}");

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
              "xamount": amountValue.toString(),
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
              "xchequeno": chkRefNo.text,
              "xref": reference.text,
              "xopincapply": incentiveApplicableYearly.value,
              "xdepositref_date": date.value.toString(),
              "partpayment" : partpayment.value
            }));

        print(response.body);

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
    reference.clear();
    amount.clear();
    depositBranch.clear();
    invoiceType.value = 'Invoice type';
    bankSelection.value = 'Bank name';
    cusBank.clear();
    chkRefNo.clear();
    dateController.clear(); // Clear the date text controller
    date.value = ''; // Clear the date value
    note.clear();
  }


}
