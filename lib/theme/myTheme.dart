import 'package:flutter/material.dart';

class MyThemeData {
  static Color primaryLight = const Color(0xff5D9CEC);
  static Color greenLight = const Color(0xffDCE9D8);
  static Color blackColor = const Color(0xff363636);
  static Color greenColor = const Color(0xff61E757);
  static Color weightColor = const Color(0xffffffff);
  static Color redColor = const Color(0xffEC4B4B);
  static Color greyColor = const Color(0xffC8C9CB);
  static Color primaryDarkBackGround = const Color(0xff060E1E);
  static Color darkColor = const Color(0xff141922);

  static final ThemeData lightTheme = ThemeData(
      primaryColor: primaryLight,
      scaffoldBackgroundColor: greenLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        selectedItemColor: primaryLight,
        unselectedItemColor: greyColor,
      ),
      textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)));

  static final ThemeData darkTheme = ThemeData();
}
