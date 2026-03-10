import 'package:flutter/material.dart';
import 'package:news_app/core/themes/light_color.dart' show LightColor;

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightColor.backgroundColor,
  primaryColor: LightColor.primaryColor,
  colorScheme: ColorScheme.light(),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.black),
  appBarTheme: AppBarTheme(
    // backgroundColor: Color(0xFFF6F7F9),
    // centerTitle: true,
    // titleTextStyle: TextStyle(color: Color(0xFF161F1B), fontSize: 20),
    // iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ),

  // switchTheme: SwitchThemeData(
  //   trackColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Color(0xFF15B86C);
  //     }
  //     return Colors.white;
  //   }),
  //   thumbColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.white;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineColor: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return Colors.transparent;
  //     }
  //     return Color(0xFF9E9E9E);
  //   }),
  //   trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return 0;
  //     }
  //     return 2;
  //   }),
  // ),
  // checkboxTheme: CheckboxThemeData(
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //   side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
  // ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: LightColor.primaryColor,
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
  ),

  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Color(0xFF15B86C),
  //   foregroundColor: Color(0xFFFFFCFC),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //   extendedTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  // ),
  // textTheme: TextTheme(
  //   displayLarge: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontWeight: FontWeight.w400,
  //     fontSize: 32,
  //   ),
  //   displayMedium: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: 28,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   displaySmall: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: 24,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   labelMedium: TextStyle(color: Colors.black, fontSize: 16),
  //   labelLarge: TextStyle(color: Colors.black, fontSize: 24),
  //   labelSmall: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: 20,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   titleSmall: TextStyle(
  //     color: Color(0xFF3A4640),
  //     fontSize: 14,
  //     overflow: TextOverflow.ellipsis,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   titleMedium: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //   ),
  //   titleLarge: TextStyle(
  //     color: Color(0xFF6A6A6A),
  //     fontSize: 16,
  //     decorationColor: Color(0xFF49454F),
  //     decoration: TextDecoration.lineThrough,
  //     overflow: TextOverflow.ellipsis,
  //     fontWeight: FontWeight.w400,
  //   ),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    // suffixIconColor: Color(0xFF363636),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: .75),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFFFFFFF), width: 1),
    ),
    filled: true,
    fillColor: Color(0xFFFFFFFF),

    hintStyle: TextStyle(
      color: Color(0xFF363636),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  // iconTheme: IconThemeData(color: Color(0xFF161F1B), size: 24),
  // dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
  // listTileTheme: ListTileThemeData(
  //   titleTextStyle: TextStyle(
  //     color: Color(0xFF161F1B),
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //   ),
  // ),
  // textSelectionTheme: TextSelectionThemeData(
  //   cursorColor: Colors.black,
  //   selectionColor: Colors.white,
  //   selectionHandleColor: Colors.black,
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    selectedItemColor: LightColor.primaryColor,
    unselectedItemColor: Color(0xFF363636),
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  ),

  // popupMenuTheme: PopupMenuThemeData(
  //   color: Color(0xFFF6F7F9),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //   shadowColor: Color(0xFF3A4640),
  //   elevation: 2,
  //   labelTextStyle: WidgetStateProperty.all(
  //     TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
  //   ),
  // ),
  splashFactory: NoSplash.splashFactory,
  tabBarTheme: TabBarThemeData(indicatorColor: Colors.black),
);
