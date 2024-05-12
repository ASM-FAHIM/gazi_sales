import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableWidget extends StatelessWidget {
  String text;
  String image;
  String? textS;
  String? badgeText;
  Color? circleColor;
  ReusableWidget(
      {Key? key,
      required this.text,
      required this.image,
      this.circleColor = Colors.transparent,
      this.textS = '',
      this.badgeText = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 3.8,
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 5, top: 5),
            child: CircleAvatar(
              backgroundColor: circleColor,
              radius: 12,
              child: Text(
                badgeText!,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Center(
            child: Image(
              image: AssetImage(image),
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.bakbakOne(
                    fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 400,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Center(
              child: Text(
                textS!,
                style: GoogleFonts.bakbakOne(
                    fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
