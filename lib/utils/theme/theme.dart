import 'package:fkfa/utils/theme/custom_themes/appbar_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/chip_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/text_field_theme.dart';
import 'package:fkfa/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class mainAppTheme {
  mainAppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    chipTheme: fkfaChipTheme.lightChipTheme,
    appBarTheme: fkfaAppBarTheme.lightAppBarTheme,
    checkboxTheme: fkfaCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: fkfaBottomSheetTheme.lightBottomSheet,
    outlinedButtonTheme: fkfaOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: fkfaTextFormFieldTheme.lightInputDecorationTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: fkfaTextTheme.lightTextTheme,
    elevatedButtonTheme: fkfaElevatedButtonTheme.LightElevatedButton,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: fkfaTextTheme.darkTextTheme,
    elevatedButtonTheme: fkfaElevatedButtonTheme.darkElevatedButton,
    outlinedButtonTheme: fkfaOutlinedButtonTheme.darkOutlinedButtonTheme,
    chipTheme: fkfaChipTheme.darkChipTheme,
    checkboxTheme: fkfaCheckboxTheme.darkCheckboxTheme,
    appBarTheme: fkfaAppBarTheme.darkAppBarTheme,
    inputDecorationTheme: fkfaTextFormFieldTheme.darkInputDecorationTheme,
    bottomSheetTheme: fkfaBottomSheetTheme.darkBottomSheet,
  );
}