import 'dart:ui';

import 'package:first_mobile/ui/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

const MaterialColor c_blue = Colors.amber;
const MaterialColor c_yellow = Colors.yellow;
const Color c_pink = Color(0xfff62a5d);
const primaryClr = c_blue;
const Color c_darkHeader = Color(0xFF424242);
const Color darkHeader = Color.fromARGB(255, 255, 255, 255);




class Themes {
  static final light =  ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.white,
    brightness: Brightness.light),
    brightness: Brightness.light
  );

  static final dark =  ThemeData(
colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.black,
    brightness: Brightness.dark),
    brightness: Brightness.dark
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode? Colors.grey[500]:Colors.grey,
        decorationThickness: 0
    )
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode? Colors.white:Colors.black,
          decorationThickness: 0

      )
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato (
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode? Colors.grey[100]:Colors.grey[700],
          decoration: TextDecoration.none,
          decorationThickness: 0
      )
  );
}