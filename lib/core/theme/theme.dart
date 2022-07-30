import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

/// Defines app theme including text themes.
class ApplicationTheme {
  static ThemeData getAppThemeData() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: aquaGreenColor,
        primarySwatch: primarySwatchColor,
        scaffoldBackgroundColor: backgroundDarkJungleGreenColor,
        // colorScheme:_customColorScheme,
        iconTheme: const IconThemeData(color: iconColor),
        appBarTheme: const AppBarTheme(backgroundColor: backgroundBalticSeaColor),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryTextColor,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 5.0.sp : 32.sp,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          headline1: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 4.5.sp : 24.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          headline2: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 4.0.sp : 18.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          headline3: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 3.5.sp : 16.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          headline4: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 3.0.sp : 14.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          headline5: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 2.5.sp : 12.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          headline6: TextStyle(
            fontSize: SizerUtil.deviceType == DeviceType.web ? 2.0.sp : 10.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Poppins',
          ),
          subtitle1: TextStyle(
            fontSize: 8.sp,
            fontWeight: FontWeight.w400,
            color: textInputTitleColor,
            fontFamily: 'Poppins',
          ),
          subtitle2: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: bodyTextColor,
            fontFamily: 'Poppins',
          ),
          bodyText1: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: bodyTextColor,
          ),
          bodyText2: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
          ),
          button: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
          ),
        ),
      );
}
