import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazi_sales_app/production/controller/process_controller.dart';
import 'package:get/get.dart';
import '../../sales/constant/colors.dart';
import '../../sales/constant/dimensions.dart';
import '../../sales/widget/big_text.dart';
import '../../sales/widget/reusable_dropdown.dart';
import '../model/material_store_model.dart';


class ProcessingFormScreen extends StatefulWidget {
  const ProcessingFormScreen({Key? key}) : super(key: key);

  @override
  State<ProcessingFormScreen> createState() => _ProcessingFormScreenState();
}

class _ProcessingFormScreenState extends State<ProcessingFormScreen> {
  ProcessController processController = Get.find<ProcessController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processController.getMaterialStore();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarColor,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              ),
            ),
            title: BigText(
              text: 'Processing',
              color: AppColor.defWhite,
              size: 25,
            ),
          ),
      body: Obx(()
      {
        return processController.isLoading2.value
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
                          child: TextFormField(
                            // controller: depositController.amount,
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
                            //controller: depositController.reference,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Reference'),
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        ReusableDropdownButton<MaterialStoreList>(
                          items: processController.materialStoreList,
                          //selectedItem: processController.selectedMaterialStore,
                          onChanged: (MaterialStoreList? selectedItem) {
                            // processController.selectedMaterialStore = selectedItem;
                            if (selectedItem != null) {
                              processController.pXwh.value = selectedItem.xwh;
                              processController.pXLong.value = selectedItem.xlong;
                              processController.totalMatSt.value = '${processController.pXLong.value} -${processController.pXwh.value}';
                              print('store id: ${processController.totalMatSt.value}');
                            } else {
                              processController.totalMatSt.value = '';
                            }
                          },
                          displayText: (MaterialStoreList item) => '${item.xlong} - ${item.xwh}',
                          hintText: processController.totalMatSt.value,
                        ),
                        ReusableDropdownButton<MaterialStoreList>(
                          items: processController.materialStoreList,
                          //selectedItem: processController.selectedMaterialStore,
                          onChanged: (MaterialStoreList? selectedItem) {
                            // processController.selectedMaterialStore = selectedItem;
                            if (selectedItem != null) {
                              processController.pXwh.value = selectedItem.xwh;
                              processController.pXLong.value = selectedItem.xlong;
                              processController.totalMatSt.value = '${processController.pXLong.value} -${processController.pXwh.value}';
                              print('store id: ${processController.totalMatSt.value}');
                            } else {
                              processController.totalMatSt.value = '';
                            }
                          },
                          displayText: (MaterialStoreList item) => '${item.xlong} - ${item.xwh}',
                          hintText: processController.totalMatSt.value,
                        ),                        /*Container(
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
                            print(
                                'name of the bank: ${depositController.bankSelection.value}');
                            print(
                                'name of the bank: ${depositController.bankCode.value}');
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
                      ),*/
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Dimensions.height50,
                  width: Dimensions.height120,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  clipBehavior: Clip.hardEdge,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColor.appBarColor),
                    onPressed: () {

                    },
                    child: BigText(
                      text: 'Submit',
                      color: AppColor.defWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }))
    );
  }
}
