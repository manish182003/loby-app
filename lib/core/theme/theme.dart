import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

/// Defines app theme including text themes.
class ApplicationTheme {
  static ThemeData getAppThemeData() => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: aquaGreenColor,
        primarySwatch: primarySwatchColor,
        scaffoldBackgroundColor: backgroundColor,
        // colorScheme:_customColorScheme,
        iconTheme: const IconThemeData(color: iconColor),
        appBarTheme:
            const AppBarTheme(backgroundColor: backgroundBalticSeaColor),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryTextColor,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 5.0.sp : 25.sp,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          displayLarge: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 4.5.sp : 19.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          displayMedium: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 4.0.sp : 14.sp,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          displaySmall: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 3.5.sp : 12.5.spa,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          headlineMedium: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 3.0.sp : 11.spa,
            fontWeight: FontWeight.w600,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          headlineSmall: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 2.5.sp : 10.spa,
            fontWeight: FontWeight.w500,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          titleLarge: TextStyle(
            fontSize: Device.deviceType == DeviceType.web ? 2.0.sp : 9.spa,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          titleMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textInputTitleColor,
            fontFamily: 'Montserrat',
          ),
          titleSmall: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: bodyTextColor,
            fontFamily: 'Montserrat',
          ),
          bodyLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: bodyTextColor,
            fontFamily: 'Montserrat',
          ),
          bodyMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
          labelLarge: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
            fontFamily: 'Montserrat',
          ),
        ),
      );
}
