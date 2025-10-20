import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/utils/extentions.dart';

class AppThemes {
  static const primaryColor = "#4C8613";
  static const mediumGreenColor = "#61B80C";
  static const whiteColor = "#FFFFFF";
  static const blackColor = "#000000";
  static const grayColor = "#AFAFAF";
  static const darkGrayColor = "#707070";
  static const lightGrayColor = "#F3F3F3";
  static const textFormGrayColor = "#B1B1B1";
  static const lightGreenColor = "#AED489";
  static const fillColorOne = "#FAEEE2";
  static const fillColorTwo = "#E1F7FF";
  static const fillColorThree = "#FFE5DE";
  static const fillColorFour = "#FFEDD5";
  static const fillColorFive = "#FAEAFF";
  static const lighterGreenColor = "#E5ECDD";
  static const darkerGrayColor = "#808080";
  static const fillGrayColor = "#F9FBF7";
  static const blueGreenColor = "#2D9E78";
  static const lightBlueGreenColor = "#E6F5F0";
  static const yellowGreenColor = "#EAFFD5";
  static const lightRedColor = "#FFE4E4";
  static const redColor = "#FF0000";

  static ThemeData get lightTheme => ThemeData(
    indicatorColor: yellowGreenColor.color,
    primaryColor: primaryColor.color,
    scaffoldBackgroundColor: whiteColor.color,
    textTheme: arabicTextTheme,
    hoverColor: lighterGreenColor.color,
    fontFamily: "Tajawal",
    hintColor: lighterGreenColor.color,
    primaryColorLight: Colors.white,
    primaryColorDark: blackColor.color,
    disabledColor: lighterGreenColor.color,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    dividerColor: lighterGreenColor.color,
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor.color,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: whiteColor.color,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        // fontFamily: FontFamily.shubbak,
        color: blackColor.color,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: whiteColor.color,
      selectedItemColor: primaryColor.color,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      // selectedLabelStyle: const TextStyle(color: Colors.white),
      // unselectedLabelStyle: TextStyle(color: "#AED489".color),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: "#CBD1DB".color),
      unselectedItemColor: "#CBD1DB".color,
      enableFeedback: true,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor.color;
        } else {
          return lighterGreenColor.color;
        }
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: BorderSide.none,
      ),
      iconSize: 24.h,
      backgroundColor: primaryColor.color,
      elevation: 1,
    ),
    colorScheme: ColorScheme.light(
      primaryContainer: lighterGreenColor.color,
      // secondary: secondaryColor.color,
      primary: primaryColor.color,
      error: redColor.color,
    ),
    timePickerTheme: TimePickerThemeData(
      elevation: 0,
      dialHandColor: primaryColor.color,
      dialTextColor: Colors.black,
      backgroundColor: Colors.white,
      hourMinuteColor: whiteColor.color,
      dayPeriodTextColor: Colors.black,
      entryModeIconColor: Colors.transparent,
      dialBackgroundColor: whiteColor.color,
      hourMinuteTextColor: Colors.black,
      dayPeriodBorderSide: BorderSide(color: primaryColor.color),
    ),
    dividerTheme: DividerThemeData(color: lighterGreenColor.color),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(
        // fontFamily: FontFamily.shubbak,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: primaryColor.color,
        fillColor: whiteColor.color,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: lighterGreenColor.color),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(
        fontSize: 14,
        // fontFamily: FontFamily.shubbak,
        color: lighterGreenColor.color,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 12,
        // fontFamily: FontFamily.shubbak,
        color: lighterGreenColor.color,
        fontWeight: FontWeight.w400,
      ),
      fillColor: whiteColor.color,
      filled: true,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: redColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lighterGreenColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: lighterGreenColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lighterGreenColor.color),
        borderRadius: BorderRadius.circular(14.r),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static TextTheme get arabicTextTheme => const TextTheme(
    labelLarge: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
  );
}