import 'package:flutter/material.dart';

class TableTitle extends StatelessWidget {
  const TableTitle(this.width, this.title,
      {Key? key, this.shouldOffRight = true})
      : super(key: key);
  final double width;
  final String title;
  final bool shouldOffRight;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.6),
            border: Border(
                left: BorderSide(
                    color: shouldOffRight ? Colors.transparent : Colors.red),
                top: const BorderSide(color: Colors.red),
                bottom: const BorderSide(color: Colors.red),
                right: const BorderSide(color: Colors.red))),
        height: 45,
        width: width,
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
        )));
  }
}
