import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableDropdownFormField extends StatelessWidget {
  final RxString value;
  final List<String> options;
  final Function(String) onChanged;
  final String hintText;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color hintTextColor;
  final Color iconColor;

  ReusableDropdownFormField({
    required this.value,
    required this.options,
    required this.onChanged,
    required this.hintText,
    this.enabledBorderColor = Colors.black,
    this.focusedBorderColor = Colors.black,
    this.fillColor = Colors.white,
    this.hintTextColor = Colors.grey,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 1),
          ),
          filled: true,
          fillColor: fillColor,
        ),
        dropdownColor: Colors.white,
        value: value.value,
        items: options.map<DropdownMenuItem<String>>((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (newValue) {
          value.value = newValue!;
          onChanged(newValue!);
        },
        hint: Text(
          hintText,
          style: TextStyle(
            color: hintTextColor,
            fontSize: 15.0,
          ),
        ),
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          color: iconColor,
        ),
      );
    });
  }
}
