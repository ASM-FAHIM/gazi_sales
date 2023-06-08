import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../controller/deposit_controller.dart';
import '../../model/bank_list_model.dart';
import '../../model/payment_model_model.dart';

class DepositFormScreen extends StatefulWidget {
  String tso;
  String cusId;
  String cusName;
  String territory;
  String zone;
  String zm;
  String division;
  String dm;

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
  }) : super(key: key);

  @override
  State<DepositFormScreen> createState() => _DepositFormScreenState();
}

class _DepositFormScreenState extends State<DepositFormScreen> {
  DepositController depositController = Get.put(DepositController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    depositController.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        leading: GestureDetector(
          onTap: () {
            // depositController.clearDealerList();
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            size: 25,
          ),
        ),
        title: BigText(
          text: "Entry form",
          color: AppColor.defWhite,
          size: 25,
        ),
        actions: [
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
                        height: Dimensions.height650 + Dimensions.height20,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
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
                                child: BigText(
                                  text: 'Customer name: ${widget.cusName}',
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
                                child: BigText(
                                  text: 'Customer ID: ${widget.cusId}',
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
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'^0')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'-')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\.')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r',')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\+')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\*')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'/')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'=')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'%')),
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r' ')),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Please enter amount',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18.0,
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
                                  items: <String>[
                                    "Imp",
                                    "Roto",
                                    "Tanks",
                                    "Toys",
                                  ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    depositController.selectedOption.value =
                                        value.toString();
                                  },
                                  hint: Obx(() => Text(
                                        depositController.selectedOption.value,
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
                                  items: depositController.bankList
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic bank) {
                                    return DropdownMenuItem<String>(
                                      value: bank['xname'] as String,
                                      child: Text(bank['xname'] as String),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    final bank = depositController.bankList.firstWhere((element) => element['xname'] == value);
                                    depositController.bankSelection.value = bank['xname'] as String;
                                    depositController.bankCode.value = bank['xbank'] as String;
                                    print('name of the bank: ${depositController.bankSelection.value}');
                                    print('name of the bank: ${depositController.bankCode.value}');
                                  },
                                  hint: Obx(() => Text(
                                        depositController.bankSelection.value,
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
                                      hintText: 'Enter deposit branch'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
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
                                  controller: depositController.cusBank,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter customer bank'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
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
                                  controller: depositController.chkRefNo,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter check/Ref. No'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
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
                                child: Obx(
                                  () => TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Date',
                                    ),
                                    onTap: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );

                                      if (selectedDate != null) {
                                        depositController
                                            .updateDate(selectedDate);
                                      }
                                    },
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: DateFormat.yMMMd().format(
                                        DateTime.parse(
                                            depositController.date.value),
                                      ),
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
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: TextFormField(
                                  controller: depositController.note,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter note'),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
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
                              primary: AppColor.appBarColor),
                          onPressed: () {
                            final String paymentNature =
                                depositController.selectedOption.value;
                            final String bankName =
                                depositController.bankSelection.value;
                            final String paymentType =
                                depositController.paymentMod.value;
                            depositController.insertToDeposit(
                                widget.cusId,
                                widget.cusName,
                                'Open',
                                bankName,
                                paymentNature);
                            // depositController.depositSubmission(widget.cusId,
                            //     bankName, paymentNature, paymentType);
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
                      ),
                    ],
                  ),
                ),
              );
      }),
    ));
  }
}
