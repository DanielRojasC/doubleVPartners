import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff263AEC);
const Color secondaryColor = Color(0xff1A237E);
const Color accentColor = Color(0xff82B1FF);
const Color lightBackground = Color.fromARGB(255, 243, 244, 250);

const Color backgroundColor = Color(0xffFAFAFA);

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

TextStyle inputLabelTextStyle() => TextStyle(color: primaryColor, fontSize: 14);

TextStyle inputTextStyle() => TextStyle(color: Colors.black, fontSize: 14);

TextStyle formTitleTextStyle() =>
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

TextStyle titleTextStyle(double fontSize) => TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );

class InputStyles {
  static InputDecoration basicInputDecoration(String hintText) =>
      InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorStyle: TextStyle(color: Colors.red),
        hintText: hintText,
        alignLabelWithHint: true,
      );
}
