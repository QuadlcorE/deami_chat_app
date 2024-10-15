import 'package:flutter/material.dart';
import 'package:deami_chat_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: ColorUtils.white,
  hintColor: ColorUtils.lightGrey,
  fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
  splashFactory: NoSplash.splashFactory,
  colorScheme: ColorScheme.light(
    primary: ColorUtils.black,
    surface: ColorUtils.white,
  ),

  // ElevatedButton theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorUtils.yellow,
      foregroundColor: ColorUtils.black,
      textStyle: _textTheme.labelLarge, // Use defined textStyle
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  ),

  // Define OutlinedButton theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: ColorUtils.darkYellow, width: 1),
      foregroundColor: ColorUtils.darkYellow,
      // textStyle: GoogleFonts.spaceGrotesk(fontSize: 16),
      textStyle: _textTheme.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  ),

  // Define TextButton theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorUtils.darkYellow,
      textStyle: _textTheme.labelLarge,
      padding: const EdgeInsets.all(16),
    ),
  ),

  // Define FloatingAction Button
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorUtils.yellow,
    foregroundColor: ColorUtils.black,
    shape: const CircleBorder(),
    extendedTextStyle: _textTheme.labelLarge,
  ),

  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  textTheme: _textTheme,
);

final TextTheme _textTheme = TextTheme(
  // Heading 1
  headlineLarge: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 48,
    fontWeight: FontWeight.w600,
  ),

  // Heading 2
  headlineMedium: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 34,
    fontWeight: FontWeight.w500,
  ),

  // Heading 3
  headlineSmall: TextStyle(
      color: ColorUtils.black,
      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      fontStyle: FontStyle.normal,
      fontSize: 20,
      fontWeight: FontWeight.w500),

  // Button
  labelLarge: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),

  // Caption
  labelMedium: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  ),

  // Overline
  labelSmall: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  ),

  // Subtitle 1
  titleLarge: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),

  // Subtitle 2
  titleMedium: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),

  // Body 1
  bodyLarge: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),

  // Body 1
  bodyMedium: TextStyle(
    color: ColorUtils.black,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),

  // Button
  // titleLarge: TextStyle(
  //     color: ColorUtils.white,
  //     fontFamily: 'Poppins',
  //     fontStyle: FontStyle.normal,
  //     fontSize: 12,
  //     fontWeight: FontWeight.w700,
  //     letterSpacing: 1.1),
);
