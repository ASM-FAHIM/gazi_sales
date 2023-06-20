import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget(
    this.width,
    this.title, {
    Key? key,
    this.shouldColorBottom = false,
    this.shouldColorTop = false,
    this.shouldColorRight = false,
    this.shouldColorLeft = false,
  }) : super(key: key);

  final double width;
  final String title;
  final bool shouldColorRight;
  final bool shouldColorLeft;
  final bool shouldColorTop;
  final bool shouldColorBottom;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    return Container(
        decoration: BoxDecoration(
            border: Border(
                left: _borderSide(shouldColorLeft),
                top: _borderSide(shouldColorTop),
                bottom: _borderSide(shouldColorBottom),
                right: _borderSide(shouldColorRight))),
        height: 45,
        width: width,
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: textStyle,
        )));
  }

  BorderSide _borderSide(bool shouldColor) {
    return BorderSide(color: _colorDecide(shouldColor));
  }

  Color _colorDecide(bool status) {
    if (status) {
      return Colors.transparent;
    } else {
      return Colors.red;
    }
  }
}
