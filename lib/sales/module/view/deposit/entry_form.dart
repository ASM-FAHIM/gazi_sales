import 'package:flutter/material.dart';
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
                        height: Dimensions.height650 + Dimensions.height30,
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
                                  text: 'Customer : ${widget.cusName}',
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
                                  text: 'ID : ${widget.cusId}',
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
                                    hintText: 'Enter amount',
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
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: TextFormField(
                                  controller: depositController.reference,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Reference'),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Incentive Applicable ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Obx(
                                      () => DropdownButton<String>(
                                        value: depositController
                                            .incentiveApplicable.value,
                                        onChanged: (newValue) {
                                          depositController
                                              .setSelectedValue(newValue!);
                                        },
                                        items: <String>['Yes', 'No']
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
                                      hintText: 'Cheque/Ref No'),
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
                                      hintText: 'Cheque/Ref date',
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
                                      text: depositController.date.value,
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
                                depositController.invoiceType.value;
                            final String bankName =
                                depositController.bankSelection.value;
                            final String bankCode =
                                depositController.bankCode.value;
                            final String paymentType =
                                depositController.paymentMod.value;
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
                                  );
                                });
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
  }) : super(key: key);

  final DepositController deposit;
  final String amount;
  final String invoiceType;
  final String bankName;
  final String bankCode;
  final String paymentType;
  final String cusID;
  final String cusName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Save',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Confirm deposit amount',
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$amount Tk.',
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
