import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import '../../sales/constant/colors.dart';
import '../../sales/widget/big_text.dart';

class ProductionProcessScreen extends StatefulWidget {
  const ProductionProcessScreen({Key? key}) : super(key: key);

  @override
  State<ProductionProcessScreen> createState() =>
      _ProductionProcessScreenState();
}

class _ProductionProcessScreenState extends State<ProductionProcessScreen> {
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
            text: 'Production Module',
            color: AppColor.defWhite,
            size: 25,
          ),
        ),
      ),
    );
  }
}
