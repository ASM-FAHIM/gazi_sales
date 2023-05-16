import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/sales/constant/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                                    color: Colors.grey,
                                    width: 1.0,
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
                                padding: EdgeInsets.only(left: 10, right: 10),
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
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  // to remove the default underline of DropdownButton
                                  iconSize: 30.0,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  items: <String>[
                                    "Imp",
                                    "Roto",
                                    "Tank",
                                    "Toy",
                                  ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
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
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0,
                                        ),
                                      )),
                                  isExpanded: true,
                                  // to make the dropdown button span the full width of the container
                                  icon: Icon(
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
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  // to remove the default underline of DropdownButton
                                  iconSize: 30.0,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  items: depositController.paymentList
                                      .map<DropdownMenuItem<PaymentModeModel>>(
                                    (PaymentModeModel value) {
                                      return DropdownMenuItem<PaymentModeModel>(
                                        value: value,
                                        child: Text(value.xcode),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    if (value is PaymentModeModel) {
                                      depositController.paymentMod.value =
                                          value.xcode;
                                    }
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
                                    color: Colors.grey,
                                    width: 1.0,
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
                                      .map<DropdownMenuItem<BankListModel>>(
                                    (BankListModel value) {
                                      return DropdownMenuItem<BankListModel>(
                                        value: value,
                                        child: Text(value.xname),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    if (value is BankListModel) {
                                      depositController.bankSelection.value =
                                          value.xname;
                                    }
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
                                                depositController.date.value))),
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
                            depositController.depositSubmission(widget.cusId,
                                bankName, paymentNature, paymentType);
                          },
                          child: depositController.isSubmitted.value
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
