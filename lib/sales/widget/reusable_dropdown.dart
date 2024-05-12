import 'package:flutter/material.dart';

class ReusableDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final void Function(T?) onChanged;
  final String Function(T) displayText;
  final String? hintText;

  const ReusableDropdownButton({
    required this.items,
    required this.onChanged,
    required this.displayText,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
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
      child: DropdownButton<T>(
        underline: const SizedBox(),
        iconSize: 30.0,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        //value: selectedItem,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              displayText(item),
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        hint: Text(
          hintText ?? 'Select an item',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
      ),
    );
  }
}
