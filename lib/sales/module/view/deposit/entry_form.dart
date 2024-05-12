import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../controller/deposit_controller.dart';

class DepositFormScreen extends StatefulWidget {
  final String tso;
  final String cusId;
  final String cusName;
  final String territory;
  final String zone;
  final String zm;
  final String division;
  final String dm;
  final String zbusiness;


  DepositFormScreen({
    Key? key,
    required this.tso,
    required this.cusId,
    required this.cusName,
    required this.territory,
    required this.zone,
    required this.zm,
    required this.division,
    required this.dm,
    required this.zbusiness,
  }) : super(key: key);

  @override
  State<DepositFormScreen> createState() => _DepositFormScreenState();
}

class _DepositFormScreenState extends State<DepositFormScreen> {
  DepositController depositController = Get.put(DepositController());

  final NumberFormat _formatter = NumberFormat("#,##,###");

  late DateTime datetime;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
    depositController.fetchAll();
    datetime = DateTime.now();

    print(datetime);
  }

  Future<bool> onWillPop() async {
    depositController.clearFields();
    return true;
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            leading: GestureDetector(
              onTap: () {
                depositController.clearFields();
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              ),
            ),
            title: BigText(
              text: "Deposit Entry form",
              color: AppColor.defWhite,
              size: 18,
            ),
            actions: [
              BigText(
                text: "${widget.zbusiness}",
                color: AppColor.defWhite,
                size: 15,
              ),


              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      Get.back();
                    },
                    icon: const Icon(
                      MdiIcons.homeCircle,
                      color: AppColor.defWhite,
                      size: 35,
                    )),
              )
            ],
          ),
          body: Obx(() {
            return depositController.isAllLoaded.value
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: const CircularProgressIndicator(
                      color: AppColor.appBarColor,
                    ),
                  ),
                  const Text('Loading...')
                ],
              ),
            )
                : SingleChildScrollView(
              child: Container(
// padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: Dimensions.height650 + Dimensions.height30,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: Dimensions.height50,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: 'Customer : ',
                                    size: 18,
                                  ),
                                  Flexible(
                                    child: BigText(
                                      text: ' ${widget.cusName}',
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: Dimensions.height50,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                children: [
                                  BigText(
                                    text: 'ID :',
                                    size: 18,
                                  ),
                                  BigText(
                                    text: ' ${widget.cusId}',
                                  ),
                                ],
                              ),
                            ),    //ID


                            Container(
                              height: Dimensions.height50,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                children: [
                                  BigText(
                                      text: "Deposit Date : ",
                                      size: 18
                                  ),
                                  BigText(
                                      text: "${DateFormat('dd MMMM, yyyy').format(datetime)}",
                                      size: 18

                                  ),
                                ],
                              ),


                            ),
                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? Colors.red
                                      : Colors.grey,
                                  width:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                controller: depositController.amount,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp(r'^0')),
                                  FilteringTextInputFormatter.deny(RegExp(r'-')),
                                  FilteringTextInputFormatter.deny(RegExp(r'\.')),
                                  FilteringTextInputFormatter.deny(RegExp(r',')),
                                  FilteringTextInputFormatter.deny(RegExp(r'\+')),
                                  FilteringTextInputFormatter.deny(RegExp(r'\*')),
                                  FilteringTextInputFormatter.deny(RegExp(r'/')),
                                  FilteringTextInputFormatter.deny(RegExp(r'=')),
                                  FilteringTextInputFormatter.deny(RegExp(r'%')),
                                  FilteringTextInputFormatter.deny(RegExp(r' ')),


                                  TextInputFormatter.withFunction((oldValue, newValue) {
                                    if (newValue.text.isEmpty) {
                                      return newValue.copyWith(text: '');
                                    } else {
                                      final num parsed = int.parse(newValue.text);
                                      final formatted = _formatter.format(parsed);
                                      return newValue.copyWith(
                                        text: formatted,
                                        selection: TextSelection.collapsed(offset: formatted.length),
                                      );
                                    }
                                  }),
                                ],

                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: const InputDecoration(
                                  labelText: 'Enter amount',
                                  border: InputBorder.none,
// hintText: 'Enter amount',
                                ),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),    //Enter amount

                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (depositController.isReferenceRequired.value && depositController.reference.text.isEmpty && depositController.isEmptyField.value)
                                      ? Colors.red
                                      : Colors.grey,
                                  width: (depositController.isReferenceRequired.value && depositController.reference.text.isEmpty && depositController.isEmptyField.value)
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                controller: depositController.reference,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Reference',
                                ),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),  //Reference

                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? Colors.red
                                      : Colors.grey,
                                  width:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Yearly Dealer Commission Applicable',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Obx(
                                        () => DropdownButton<String>(
                                      value: depositController.incentiveApplicableYearly.value,
                                      onChanged: (newValue) {
                                        depositController.setSelectedValueYearly(newValue!);
                                      },
                                      items: <String>['Yes', 'No'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),  //Yearly Dealer Commission Applicable

                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? Colors.red
                                      : Colors.grey,
                                  width:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Part of MR?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Obx(
                                        () => DropdownButton<String>(
                                      value: depositController
                                          .partpayment.value,
                                      onChanged: (newValue) {
                                        depositController
                                            .partpayment_value(newValue!);
                                      },
                                      items: <String>['No', 'Yes']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),  //'Part of MR?
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12,top: 8,bottom: 0),
                                child: Text(
                                  'Invoice Type',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? Colors.red
                                      : Colors.grey,
                                  width:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButton(
                                underline: const SizedBox(),
// to remove the default underline of DropdownButton
                                iconSize: 30.0,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),

                                items: depositController.invoiceList
                                    .map<DropdownMenuItem<String>>(
                                        (dynamic type) {
                                      return DropdownMenuItem<String>(
                                        value: type['xcode'] as String,
                                        child: Text(type['xcode'] as String),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  depositController.invoiceType.value =
                                      value.toString();
                                },
                                hint: Obx(() => Text(
                                  depositController.invoiceType.value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  ),
                                )),
                                isExpanded: true,
// to make the dropdown button span the full width of the container
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                              ),
                            ),    //Mode of payment

                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12,top: 8,bottom: 0),
                                child: Text(
                                  'Mode of payment',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? Colors.red
                                      : Colors.grey,
                                  width:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButton(
                                underline: const SizedBox(),
// to remove the default underline of DropdownButton
                                iconSize: 30.0,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                items: depositController.paymentList
                                    .map<DropdownMenuItem<String>>(
                                        (dynamic mode) {
                                      return DropdownMenuItem<String>(
                                        value: mode['xcode'] as String,
                                        child: Text(mode['xcode'] as String),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  depositController.paymentMod.value =
                                  value as String;
                                },
                                hint: Obx(() => Text(
                                  depositController.paymentMod.value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  ),
                                )),
                                isExpanded: true,
// to make the dropdown button span the full width of the container
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                              ),
                            ),      //Bank Name

                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12,top: 8,bottom: 0),
                                child: Text(
                                  'Bank Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),          //Bank Name
                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? Colors.red
                                      : Colors.grey,
                                  width:
                                  depositController.isEmptyField.value ==
                                      true
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButton(
                                underline: const SizedBox(),
// to remove the default underline of DropdownButton
                                iconSize: 30.0,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                items: depositController.bankList
                                    .map<DropdownMenuItem<String>>(
                                        (dynamic bank) {
                                      return DropdownMenuItem<String>(
                                        value: bank['xname'] as String,
                                        child: Text(bank['xname'] as String),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  final bank = depositController.bankList
                                      .firstWhere((element) =>
                                  element['xname'] == value);
                                  depositController.bankSelection.value =
                                  bank['xname'] as String;
                                  depositController.bankCode.value =
                                  bank['xbank'] as String;
                                },
                                hint: Obx(
                                      () => Text(
                                    depositController.bankSelection.value,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                // to make the dropdown button span the full width of the container
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                controller: depositController.depositBranch,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Enter deposit branch'),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),      //Enter deposit branch


// "Cheque/Ref No" field wrapped with Obx
                            Obx(
                                  () => Container(
                                height: Dimensions.height70,
                                width: double.maxFinite,
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: depositController.paymentMod.value != 'Cash' && depositController.chkRefNo.text.isEmpty
                                        ? Colors.red
                                        : Colors.grey,
                                    width: depositController.paymentMod.value != 'Cash' && depositController.chkRefNo.text.isEmpty
                                        ? 2.0
                                        : 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: TextFormField(
                                  controller: depositController.chkRefNo,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Cheque/Ref No',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  onChanged: (value) {
                                    depositController.updatePaymentFields(
                                      depositController.paymentMod.value.toString(),
                                      chkRefNo: value,
                                    );
                                  },
                                ),
                              ),
                            ),

                            // "Enter customer bank" field wrapped with Obx
                            Obx(
                                  () => Container(
                                height: Dimensions.height70,
                                width: double.maxFinite,
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(

                                    //depositController.paymentMod.value != 'Cash' &&
                                    //                                       depositController.date.value.isEmpty

                                    //depositController.isCusBankRequired.value && depositController.cusBank.text.isEmpty
                                    color: depositController.paymentMod.value != 'Cash'  && depositController.cusBank.text.isEmpty
                                        ? Colors.red
                                        : Colors.grey,
                                    width: depositController.paymentMod.value != 'Cash'  && depositController.cusBank.text.isEmpty
                                        ? 2.0
                                        : 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: TextFormField(
                                  controller: depositController.cusBank,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Enter customer bank',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                  onChanged: (value) {
                                    depositController.updatePaymentFields(
                                      depositController.paymentMod.value.toString(),
                                      customerBank: value,
                                    );
                                  },
                                ),
                              ),
                            ),


                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (depositController.paymentMod.value != 'Cash' &&
                                      depositController.date.value.isEmpty)
                                      ? Colors.red
                                      : Colors.grey,
                                  width: (depositController.paymentMod.value != 'Cash' &&
                                      depositController.date.value.isEmpty)
                                      ? 2.0
                                      : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Obx(
                                    () => TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Cheque/Ref date',
                                  ),
                                  onTap: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );

                                    if (selectedDate != null) {
                                      depositController.updateDate(selectedDate);
                                    }
                                  },
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: depositController.date.value,
                                  ),
                                ),
                              ),
                            ), //Cheque/Ref date
                            Container(
                              height: Dimensions.height70,
                              width: double.maxFinite,
                              padding:
                              const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                controller: depositController.note,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Enter note'),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),      //Enter note
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: Dimensions.height50,
                      width: Dimensions.height120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.hardEdge,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.appBarColor),


                        onPressed: () {
                          // Extract values from the controller
                          final String paymentNature = depositController.invoiceType.value;
                          final String bankName = depositController.bankSelection.value;
                          final String bankCode = depositController.bankCode.value;
                          final String paymentType = depositController.paymentMod.value;

                          // Validate all fields
                          if (depositController.validateReferenceField() &&
                              depositController.amount.text.isNotEmpty &&
                              depositController.invoiceType.value != 'Invoice type' &&
                              depositController.paymentMod.value != 'Mode of payment' &&
                              depositController.bankSelection.value != 'Bank name' &&
                              depositController.validatePaymentFields()) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return UploadSingleCartAlert(
                                  deposit: depositController,
                                  amount: depositController.amount.text,
                                  cusID: widget.cusId,
                                  cusName: widget.cusName,
                                  invoiceType: paymentNature,
                                  bankName: bankName,
                                  bankCode: bankCode,
                                  paymentType: paymentType,
                                  product_type: depositController.invoiceType.value,
                                );
                              },
                            );
                          } else {
                            // Show a warning Snackbar if any field is invalid
                            Get.snackbar(
                              'Warning!',
                              'Please fill up all required fields',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 3),
                            );
                          }
                        },



                        child: depositController.saving.value
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : BigText(
                          text: 'Submit',
                          color: AppColor.defWhite,
                        ),
                      ),
                    ),      //Submit
                  ],
                ),
              ),
            );
          }),
        ));
  }
}



//for upload single cart alert
class UploadSingleCartAlert extends StatelessWidget {
  UploadSingleCartAlert({
    Key? key,
    required this.deposit,
    required this.amount,
    required this.invoiceType,
    required this.bankName,
    required this.bankCode,
    required this.paymentType,
    required this.cusID,
    required this.cusName,
    required this.product_type
  }) : super(key: key);

  final DepositController deposit;
  final String amount;
  final String invoiceType;
  final String bankName;
  final String bankCode;
  final String paymentType;
  final String cusID;
  final String cusName;
  final String product_type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            '$cusID',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),

          Text(
            '$cusName',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Confirm deposit amount for $product_type',
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$amount.00 Tk.',
              style: GoogleFonts.roboto(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'No',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text(
            'Yes',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await deposit.insertToDeposit(
              cusID,
              cusName,
              'Open',
              invoiceType,
              bankName,
              bankCode,
              paymentType,
            );
          },
        ),
      ],
    );
  }
}