import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFed1c24);
const greenApp = Color(0xff0cd638);

class LightThemeColors {
  static Color primaryColor = kPrimaryColor;
  static Color primaryColorDark = const Color(0xff960512);
  static Color secondaryColor = const Color(0xffcccccc);
  static Color primaryTextColor = const Color(0xff191347);
  static Color secondaryTextColor = const Color(0xff8c8c8d);

  static Color scaffoldBackgroundColor = const Color(0xfff5f5f5);
  static Color surface = const Color(0xffffffff);
  static Color selectedItem =const Color(0xffabaaaa);
  static Color greenApp =const Color(0xff0cd638);

  static Color secondaryTextColorError = const Color(0xffce0b52);
  static Color primaryColorError = const Color(0xffd40a0a);

  static Color colorTitle = const Color(0xff1e67ee);

}

class DarkThemeColors {
  static Color primaryColor = const Color(0xff1e1d1d);
  static Color primaryColorDark = const Color(0xff070001);
  static Color secondaryColor = const Color(0xff5b5a5a);
  static Color primaryTextColor = const Color(0xfff1f0f0);
  static Color secondaryTextColor = const Color(0xfff5f3f3);

  static Color scaffoldBackgroundColor = const Color(0xff4d4c4c);
  static Color surface = const Color(0xff656565);
  static Color selectedItem = const Color(0xffa1bdd3);

  static Color secondaryTextColorError = const Color(0xffce0b52);
  static Color primaryColorError = const Color(0xffd40a0a);

  static Color colorTitle = const Color(0xff6697f6);

}

ThemeData theme({String themeType = 'light'}) {
  return themeType == 'dark' ? darkTheme : lightTheme;
}

ThemeData lightTheme = ThemeData(
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(LightThemeColors.surface),
    fillColor: MaterialStateProperty.all(LightThemeColors.primaryColor),
  ),
  brightness: Brightness.light,
  visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
  // primarySwatch: MaterialColor(
  //   0xFFF5E0C3,
  //   <int, Color>{
  //     50: Color(0x1aF5E0C3),
  //     100: Color(0xfff3a4aa),
  //     200: Color(0xffef717a),
  //     300: Color(0xffee4c5a),
  //     400: Color(0xfffa1225),
  //     500: Color(0xfff61628),
  //     600: Color(0xfff5061a),
  //     700: Color(0xffd20718),
  //     800: Color(0xffd00d1f),
  //     900: Color(0xffa10411)
  //   },
  // ),
  primaryColor: LightThemeColors.primaryColor,
  primaryColorLight: LightThemeColors.secondaryColor,
  primaryColorDark: LightThemeColors.primaryColorDark,
  canvasColor: const Color(0xffdadbdc),
  scaffoldBackgroundColor: LightThemeColors.scaffoldBackgroundColor,
  cardColor: const Color(0xaa929393),
  dividerColor: LightThemeColors.secondaryTextColor.withOpacity(.2),
  focusColor: const Color(0x1aF5E0C3),
  hoverColor: const Color(0xffe6e6fa),
  highlightColor: const Color(0xffb2b2b0),
  splashColor: const Color(0xffb9cace),
  unselectedWidgetColor: Colors.grey.shade400,
  disabledColor: Colors.grey.shade200,
  indicatorColor: LightThemeColors.colorTitle,
  fontFamily: 'iranSans',
  appBarTheme: AppBarTheme(
    backgroundColor: LightThemeColors.scaffoldBackgroundColor,
    elevation: 0,
    foregroundColor: LightThemeColors.primaryTextColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: LightThemeColors.primaryColor,
  ),
  hintColor: LightThemeColors.secondaryTextColor,
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: LightThemeColors.primaryTextColor.withOpacity(.1),
      ),
    ),
    labelStyle: TextStyle(
      color: LightThemeColors.secondaryTextColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        //side: BorderSide(color: LightThemeColors.seconderyTextColor),
        ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: LightThemeColors.scaffoldBackgroundColor,
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontFamily: 'iranSans',
      color: LightThemeColors.primaryTextColor,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      fontFamily: 'iranSans',
      color: LightThemeColors.primaryTextColor,
      fontSize: 13,
    ),
    labelLarge: TextStyle(
      fontFamily: 'iranSans',
      color: LightThemeColors.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'iranSans',
      color: LightThemeColors.primaryTextColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: LightThemeColors.primaryTextColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: LightThemeColors.primaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: LightThemeColors.primaryTextColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: LightThemeColors.primaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: LightThemeColors.primaryTextColor,
    ),
    bodySmall: const TextStyle(fontFamily: 'iranSans', fontSize: 13).apply(
      color: LightThemeColors.secondaryTextColor,
    ),
  ), bottomAppBarTheme: BottomAppBarTheme(color: LightThemeColors.primaryColor), colorScheme: ColorScheme.light(
    primary: LightThemeColors.primaryColor,
    secondary: LightThemeColors.secondaryColor,
    onSecondary: LightThemeColors.primaryTextColor,
    secondaryContainer: LightThemeColors.secondaryTextColor,
    surface: LightThemeColors.surface,
    onSurface: LightThemeColors.primaryTextColor,
  ).copyWith(error: LightThemeColors.secondaryTextColorError),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
  // primarySwatch: MaterialColor(
  //   0xFFF5E0C3,
  //   <int, Color>{
  //     50: Color(0x1aF5E0C3),
  //     100: Color(0xfff3a4aa),
  //     200: Color(0xffef717a),
  //     300: Color(0xffee4c5a),
  //     400: Color(0xfffa1225),
  //     500: Color(0xfff61628),
  //     600: Color(0xfff5061a),
  //     700: Color(0xffd20718),
  //     800: Color(0xffd00d1f),
  //     900: Color(0xffa10411)
  //   },
  // ),
  primaryColor: DarkThemeColors.primaryColor,
  primaryColorLight: DarkThemeColors.secondaryColor,
  primaryColorDark: DarkThemeColors.primaryColorDark,
  canvasColor: const Color(0xff838385),
  scaffoldBackgroundColor: DarkThemeColors.scaffoldBackgroundColor,
  cardColor: const Color(0xaa929393),
  dividerColor: DarkThemeColors.secondaryTextColor.withOpacity(.2),
  focusColor: const Color(0x1aF5E0C3),
  hoverColor: const Color(0xffe6e6fa),
  highlightColor: const Color(0xffb2b2b0),
  splashColor: const Color(0xffb9cace),
  indicatorColor: DarkThemeColors.colorTitle,
  unselectedWidgetColor: Colors.grey.shade400,
  disabledColor: Colors.grey.shade200,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkThemeColors.scaffoldBackgroundColor,
    elevation: 0,
    foregroundColor: DarkThemeColors.primaryTextColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: DarkThemeColors.primaryColor,
  ),
  hintColor: DarkThemeColors.secondaryTextColor,
  inputDecorationTheme: InputDecorationTheme(
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: DarkThemeColors.primaryTextColor.withOpacity(.1),
      ),
    ),
    labelStyle: TextStyle(
      color: DarkThemeColors.secondaryTextColor,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: DarkThemeColors.primaryColor,
    secondary: DarkThemeColors.secondaryColor,
    onSecondary: DarkThemeColors.primaryTextColor,
    secondaryContainer: DarkThemeColors.secondaryTextColor,
    surface: DarkThemeColors.surface,
    onSurface: DarkThemeColors.primaryTextColor,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: DarkThemeColors.scaffoldBackgroundColor,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: DarkThemeColors.secondaryTextColor),
    ),
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      fontFamily: 'iranSans',
      color: DarkThemeColors.primaryTextColor,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      fontFamily: 'iranSans',
      color: DarkThemeColors.primaryTextColor,
      fontSize: 13,
    ),
    labelLarge: TextStyle(
      fontFamily: 'iranSans',
      color: DarkThemeColors.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'iranSans',
      color: DarkThemeColors.primaryTextColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: DarkThemeColors.primaryTextColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: DarkThemeColors.primaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: DarkThemeColors.primaryTextColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: DarkThemeColors.primaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'iranSans',
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: DarkThemeColors.primaryTextColor,
    ),
    bodySmall: const TextStyle(fontFamily: 'iranSans', fontSize: 13).apply(
      color: DarkThemeColors.secondaryTextColor,
    ),
  ), bottomAppBarTheme: BottomAppBarTheme(color: DarkThemeColors.primaryColor),
);
