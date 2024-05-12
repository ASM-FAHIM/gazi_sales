import 'package:flutter/material.dart';

import 'big_text.dart';

class TextContainer extends StatelessWidget {
  String scannedText;
  TextContainer({
    required this.scannedText,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width:300,
      padding: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: BigText(text: scannedText,),
    );
  }
}