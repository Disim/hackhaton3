import 'package:flutter/material.dart';
import 'package:hackaton3/elements/constants_elements.dart';

Color kPrimaryColor = Colors.blueAccent;

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.red,
        titleTextStyle: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        elevation: 10,
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w300),
          titleSmall: TextStyle(fontWeight: FontWeight.w300)),
      buttonTheme: ButtonThemeData(
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(doubleMediumRad)),
        buttonColor: kPrimaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(doubleMediumRad)),
            borderSide: BorderSide(
                color: borderColor)), //Color.fromRGBO(222, 229, 248, 1)
        focusedBorder: OutlineInputBorder(
          borderRadius:
              const BorderRadius.all(Radius.circular(doubleMediumRad * 1.5)),
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(doubleMediumRad)),
          borderSide: BorderSide(color: Color(0xffdf7070), width: 2.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(doubleMediumRad * 1.5)),
          borderSide: BorderSide(color: Color(0xffd53a3a), width: 2.0),
        ),
      ),
    );
  }
}
