import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:un_ride/appColors.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: AppColors.primaryDark,
  primaryColorLight: AppColors.primaryLight,
  primaryColor: AppColors.primary,

  //!El color de los fondos
  scaffoldBackgroundColor: AppColors.scaffoldBackground,

  //!Va hacer que todos lo input tengan ese borde
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
