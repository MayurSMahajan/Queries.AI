import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // static colors
  // *****************
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade900;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Color(0xFFF9F1FF);
  static const Color _lightGradientSecondColor = Color(0xFFFFFFFF);

  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static const Color _appbarColorDark = Color(0XFF362840);
  static const Color _darkGradientSecondColor = Color(0xFF111111);

  static const Color _secondaryIconColor = Colors.grey;
  static const Color _accentColor = Color(0xFFCA82FF);

  // *****************
  // Text Style - light
  // *****************
  static final TextStyle _lightHeadingText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: GoogleFonts.pacifico().fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static final TextStyle _lightBodyText = TextStyle(
      color: _lightTextColorPrimary,
      fontFamily: GoogleFonts.quicksand().fontFamily,
      fontWeight: FontWeight.bold,
      height: 1.35,
      fontSize: 16);

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: _lightHeadingText,
    bodyText1: _lightBodyText,
  );

  // *****************
  // Text Style - dark
  // *****************
  static final TextStyle _darkThemeHeadingTextStyle =
      _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyTextStyle =
      _lightBodyText.copyWith(color: _darkTextColorPrimary);

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkThemeHeadingTextStyle,
    bodyText1: _darkThemeBodyTextStyle,
  );

  // *****************
  // Theme light/dark
  // *****************

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: _lightPrimaryColor,
      appBarTheme: const AppBarTheme(
          color: _appbarColorLight,
          iconTheme: IconThemeData(color: _lightTextColorPrimary)),
      bottomAppBarColor: _appbarColorLight,
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: _lightOnPrimaryColor,
        secondary: _accentColor,
        primaryContainer: _lightPrimaryVariantColor,
        surfaceVariant: _appbarColorLight,
        onSurfaceVariant: _lightGradientSecondColor,
      ),
      iconTheme: const IconThemeData(color: _secondaryIconColor),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(_accentColor),
        overlayColor: MaterialStateProperty.all(_accentColor),
      ),
      textTheme: _lightTextTheme);

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryColor,
      appBarTheme: const AppBarTheme(
          color: _appbarColorDark,
          iconTheme: IconThemeData(color: _darkTextColorPrimary)),
      bottomAppBarColor: _appbarColorDark,
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _accentColor,
        onPrimary: _darkOnPrimaryColor,
        primaryContainer: _darkPrimaryVariantColor,
        surfaceVariant: _appbarColorDark,
        onSurfaceVariant: _darkGradientSecondColor,
      ),
      iconTheme: const IconThemeData(color: _secondaryIconColor),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(_accentColor),
        overlayColor: MaterialStateProperty.all(_accentColor),
      ),
      textTheme: _darkTextTheme);
}
