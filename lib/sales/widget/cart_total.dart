import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/view/order_process/bill_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../module/controller/cart_controller.dart';
import '../module/controller/login_controller.dart';
import '../module/model/deposit_number_list_model.dart';
import 'big_text.dart';

class CartTotal extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  LoginController loginController = Get.find<LoginController>();
  String xCus;
  String xOrg;
  String xterritory;
  String delDisc;

  CartTotal({
    Key? key,
    required this.xCus,
    required this.xOrg,
    required this.xterritory,
    required this.delDisc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      if (cartController.addedProducts.isEmpty) {
        return Container();
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: Dimensions.height50,
              width: Dimensions.height150 - Dimensions.height20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, //New
                        blurRadius: 2,
                        offset: Offset(0, 0))
                  ]),
              clipBehavior: Clip.hardEdge,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.appBarColor,
                ),
                onPressed: () async {
                  await cartController.fetchDropdownItems(xCus);
                  dialogBox(context);
                },
                child: Obx(() => cartController.isProcessing.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : BigText(
                        text: 'Process',
                        color: AppColor.defWhite,
                      )),
              ),
            ),
          ],
        );
      }
    });
  }

  dynamic dialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          // title: BigText(text: 'Choose deposit number'),
          title: BigText(text: 'Confirmation'),
          content: SizedBox(
            // height: 260,
            width: double.maxFinite,
            // child: buildView(context),
            child: Text("Are you sure to proceed"),
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
                if (cartController.selectedNumber.value ==
                    'Select deposit number') {
                  cartController.selectedNumber.value = '';
                  cartController.selectedAmount.value = '0.0';
                  Navigator.pop(context);
                  await cartController.processOrder(xCus, xOrg, context);
                } else {
                  Navigator.pop(context);
                  await cartController.processOrder(xCus, xOrg, context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildView(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.height80,
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Center(
            child: Obx(
              () {
                if (cartController.dropdownItems.isEmpty) {
                  cartController.selectedNumber.value = '';
                  cartController.selectedAmount.value = '0.0';
                  return const Text(
                      'No deposit available now'); // Show a loading indicator while fetching the dropdown items
                } else {
                  return DropdownButton<DepositListModel>(
                    underline: const SizedBox(),
                    iconSize: 30.0,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    // Set the selected value based on your requirements
                    items: cartController.dropdownItems
                        .map((DepositListModel item) {
                      return DropdownMenuItem<DepositListModel>(
                        value: item,
                        child: Text(
                          item.xdepositnum,
                          style: TextStyle(color: Colors.black),
                        ), // Customize the display of the dropdown item as needed
                      );
                    }).toList(),
                    onChanged: (DepositListModel? selectedItem) {
                      if (selectedItem != null) {
                        cartController.selectedNumber.value =
                            selectedItem.xdepositnum;
                        cartController.selectedAmount.value =
                            selectedItem.xamount;
                      }
                    },
                    hint: Obx(
                      () => Text(
                        cartController.selectedNumber.value,
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
                  );
                }
              },
            ),
          ),
        ),
        Obx(() {
          return Container(
            height: Dimensions.height70 + Dimensions.height35,
            width: double.maxFinite,
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Deposit No : ${cartController.selectedNumber.value}'),
                Text(
                    'Deposit amount : ${cartController.selectedAmount.value} Tk.'),
              ],
            ),
          );
        }),
        // Obx(() {
        //   return Row(
        //     children: [
        //       Theme(
        //         data: Theme.of(context)
        //             .copyWith(unselectedWidgetColor: Colors.black),
        //         child: Checkbox(
        //           value: cartController.isChecked.value,
        //           activeColor: AppColor.appBarColor,
        //           checkColor: AppColor.defWhite,
        //           onChanged: (value) {
        //             if (value != null) {
        //               cartController.isChecked.value = value;
        //               cartController.incentive.value = value ? 'Yes' : 'No';
        //             }
        //             print(
        //                 'Incentive applicable: ${cartController.incentive.value}');
        //           },
        //         ),
        //       ),
        //       Text(
        //         "Incentive applicable",
        //         style: GoogleFonts.urbanist(
        //           // color: mainBlackColor,
        //           fontSize: Dimensions.fontBigS16,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ],
        //   );
        // }),
      ],
    );
  }
}
