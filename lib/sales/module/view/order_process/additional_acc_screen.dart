import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/module/controller/cart_controller.dart';
import 'package:get/get.dart';


class AdditionAccScreen extends StatefulWidget {
  const AdditionAccScreen({Key? key}) : super(key: key);

  @override
  State<AdditionAccScreen> createState() => _AdditionAccScreenState();
}

class _AdditionAccScreenState extends State<AdditionAccScreen> {
  CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
