import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff00b894);
const Color secondaryColor = Color(0xffC1C7D0);
const Color onSecondaryColor = Colors.black;
const Color onPrimaryColor = Colors.white;

class MyTheme {
  static ThemeData getTheme({required Locale locale}) {
    String fontFamily = 'iranYekan';
    return ThemeData(
      textTheme: locale == const Locale('fa', 'IR')
          ? TextTheme(
              titleSmall: TextStyle(fontFamily: fontFamily),
              headlineMedium: TextStyle(fontFamily: fontFamily),
              bodyLarge: TextStyle(fontFamily: fontFamily),
              bodyMedium: TextStyle(fontFamily: fontFamily),
              titleLarge: TextStyle(
                  fontFamily: fontFamily, fontWeight: FontWeight.bold))
          : null,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        onPrimary: onPrimaryColor,
        onSecondary: onSecondaryColor,
      ),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        hintStyle: TextStyle(
            color: onSecondaryColor.withOpacity(0.6), fontFamily: fontFamily),
        labelStyle: TextStyle(
            color: onSecondaryColor.withOpacity(0.6), fontFamily: fontFamily),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily),
        ),
        foregroundColor: const WidgetStatePropertyAll(onPrimaryColor),
        backgroundColor: const WidgetStatePropertyAll(primaryColor),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      )),
    );
  }
}
