import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFFF25700);
  static const Color disabledColor = Color(0xFFEAECF0);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryTextColor = Color(0xFF1E1E1E);
  static const Color secondaryTextColor = Color(0xFF959595);

  static ThemeData get themeData {
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.white),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: disabledColor.withValues(alpha: 1.05),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        //AppBar
        headlineLarge: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: primaryTextColor,
        ),
        //welcome (App name)
        displayLarge: GoogleFonts.abhayaLibre(
          fontSize: 48.sp,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        //welcome&order (description //\\ ingredients title)
        displayMedium: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w300,
          color: const Color(0xFFDADADA),
        ),

        // order (BottomBar title/left)
        bodyLarge: GoogleFonts.poppins(
          color: primaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),

        //user&order (textfield titles //\\ bottomBar info/right)
        bodyMedium: GoogleFonts.poppins(
          color: secondaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
