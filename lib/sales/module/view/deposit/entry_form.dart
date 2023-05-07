import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constant/colors.dart';
import '../../../widget/big_text.dart';
import '../../controller/deposit_controller.dart';

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
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 680,
                  margin: EdgeInsets.only(bottom: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: BigText(text: 'Customer ID: ${widget.cusId}',),
                        ),
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Please enter amount'
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: double.maxFinite,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButton(
                            underline: SizedBox(), // to remove the default underline of DropdownButton
                            iconSize: 30.0,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            items: <String>[
                              "Imp",
                              "Tank",
                              "Roto",
                              "Toy",
                            ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              depositController.selectedOption.value = value.toString();
                            },
                            hint: Obx(() => Text(
                              depositController.selectedOption.value,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            )),
                            isExpanded: true, // to make the dropdown button span the full width of the container
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter deposit branch'
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: double.maxFinite,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButton(
                            underline: SizedBox(), // to remove the default underline of DropdownButton
                            iconSize: 30.0,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            items: <String>[
                              "Cash",
                              "Check",
                              "BEFTN",
                              "EFT",
                              "Payorder",
                              "RTGS",
                              "TT",
                            ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              depositController.paymentMod.value = value.toString();
                            },
                            hint: Obx(() => Text(
                              depositController.paymentMod.value,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            )),
                            isExpanded: true, // to make the dropdown button span the full width of the container
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: double.maxFinite,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButton(
                            underline: SizedBox(), // to remove the default underline of DropdownButton
                            iconSize: 30.0,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            items: <String>[
                              "Sonali Bank",
                              "Standard Chartered Bank",
                              "NRB Bank",
                              "Agrani Bank",
                            ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              depositController.bankSelection.value = value.toString();
                            },
                            hint: Obx(() => Text(
                              depositController.bankSelection.value,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            )),
                            isExpanded: true, // to make the dropdown button span the full width of the container
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter customer bank'
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter check/Ref. No'
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Obx(() => TextField(
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
                                depositController.updateDate(selectedDate);
                              }
                            },
                            readOnly: true,
                            controller: TextEditingController(text: DateFormat.yMMMd().format(DateTime.parse(depositController.date.value))),
                          ),),
                        ),
                        Container(
                          height: 70,
                          width:double.maxFinite,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter note'
                            ),
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
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
