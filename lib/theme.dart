import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        )),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _textFieldBorder,
      focusedBorder: _textFieldBorder,
      border: _textFieldBorder,
      contentPadding: EdgeInsets.zero,
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff011A70),
      background: Colors.white,
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.montserrat(color: const Color(0xff7E7777)),
      labelLarge: GoogleFonts.montserrat(
          color: Colors.black, fontWeight: FontWeight.bold),
    ));

final _textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(color: const Color(0xff011A70).withOpacity(.46)),
);
