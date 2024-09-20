import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.montserratTextTheme(),
    scaffoldBackgroundColor: scaffoldBackGroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldBackGroundColor,
      titleTextStyle: GoogleFonts.montserrat(
        textStyle: const TextStyle(color: Colors.black, fontSize: 20),
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldBackGroundColor,
      titleTextStyle: GoogleFonts.montserrat(
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}
