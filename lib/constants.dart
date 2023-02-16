import 'package:flutter/material.dart';

TextStyle radioTitleStyle =
    TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 20);

TextStyle radioSubTitleStyle =
    TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w400);

class CustomButtonStyle {
  static ButtonStyle buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width, 60),
      shadowColor: Color(0xff2E3B62),
    );
  }
}

TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white);

TextStyle boldHeading =
    TextStyle(fontSize: 20, fontFamily: 'Roboto', fontWeight: FontWeight.w700);

TextStyle subheading = TextStyle(
  fontSize: 14, fontFamily: 'Roboto', fontWeight: FontWeight.w400
);


