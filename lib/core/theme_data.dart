import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.montserratTextTheme(),
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: GoogleFonts.montserrat(
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
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
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      titleTextStyle: GoogleFonts.montserrat(
        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}
