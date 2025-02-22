import 'package:flutter/material.dart';

class ecomColors {
  ecomColors._(); // Makes it a private constructor

  //App Basic Colors
  static const Color primaryColor = Color(0xFF4868FF);
  static const Color secondaryColor = Color(0xFFFFE24B);
  static const Color accentColor = Color(0xFFb0c7ff);
  
  //Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.809, -0.809),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );

  //Text Colors
  static const Color textPrimaryColor = Color(0xFF333333);
  static const Color textSecondaaryColor = Color(0xFF6C7570);
  static const Color textWhite = Colors.white;

  //Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static  Color darkContainer = Colors.white.withOpacity(0.1);

  //Button Colors
  static const Color buttonPrimaryColor = Color(0xFF4b69ff);
  static const Color buttonSecondaryColor = Color(0xFF6C7570);
  static const Color buttonDisabledColor = Color(0xFFC4C4C4);

  //Border Colors
  static const Color borderPrimaryColor = Color(0xFFD9D9D9);
  static const Color borderSecondaryColor = Color(0xFFE6E6E6);

  //Error and Validation Colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);
  static const Color infoColor = Color(0xFF1976D2);

  //Neutral Shades
  static const Color blackColor = Color(0xFF232323);
  static const Color darkerGreyColor = Color(0xFF4F4F4F);
  static const Color darkGreyColor = Color(0xFF939393);
  static const Color greyColor = Color(0xFFE0E0E0);
  static const Color softGreyColor = Color(0xFFF4F4F4);
  static const Color lightGreyColor = Color(0xFFF9F9F9);
  static const Color whiteColor = Color(0xFFFFFFFF);





}