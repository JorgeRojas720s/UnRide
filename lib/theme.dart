import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color.fromARGB(255, 254, 5, 5),
  primaryColorLight: const Color.fromARGB(255, 7, 20, 255),
  primaryColor: const Color.fromARGB(255, 69, 230, 6),
  scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 31),
  //!Va hacer que todos lo input tengan ese borde
  inputDecorationTheme: InputDecorationTheme( 
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
