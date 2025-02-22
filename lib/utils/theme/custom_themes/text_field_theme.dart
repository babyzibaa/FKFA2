import 'package:flutter/material.dart'; // Importing the Flutter Material package for UI components.

class fkfaTextFormFieldTheme {
  // Private constructor to avoid creating multiple instances.
  fkfaTextFormFieldTheme._();

  // Define the light theme for input fields (TextFormField).
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3, // Allows error text to span up to 3 lines.
    prefixIconColor: Colors.grey, // Sets the color of the prefix icon to grey.
    suffixIconColor: Colors.grey, // Sets the color of the suffix icon to grey.

    // Defines the style for labels when not focused or floating.
    labelStyle: const TextStyle().copyWith(
      fontSize: 14.0, // Sets the label font size to 14 pixels.
      color: Colors.black, // Sets the label color to black.
    ),

    // Defines the style for hint text inside the input field.
    hintStyle: const TextStyle().copyWith(
      fontSize: 14.0, // Sets the hint font size to 14 pixels.
      color: Colors.black, // Sets the hint text color to black.
    ),

    // Defines the style for error messages.
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal, // Sets the error text font style to normal.
    ),

    // Defines the label style when the input field is focused.
    floatingLabelStyle: const TextStyle().copyWith(
      color: Colors.black.withOpacity(0.8), // Sets the floating label color with reduced opacity.
    ),

    // Defines the border style when the input field is in a normal state (not focused).
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0), // Rounds the input field borders with a 14-pixel radius.
      borderSide: const BorderSide(
        width: 1.0, // Sets the border width to 1 pixel.
        color: Colors.grey, // Sets the border color to grey.
      ),
    ),

    // Defines the border style when the input field is enabled but not focused.
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.grey,
      ),
    ),

    // Defines the border style when the input field is focused.
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.black12, // Uses a lighter black color when focused.
      ),
    ),

    // Defines the border style when the input field has an error.
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.red, // Sets the border color to red in case of an error.
      ),
    ),

    // Defines the border style when the input field is focused but has an error.
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.orange, // Sets the border color to orange when focused with an error.
      ),
    ),
  );

  // Define the dark theme for input fields (TextFormField).
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3, // Allows error text to span up to 3 lines.
    prefixIconColor: Colors.grey, // Sets the color of the prefix icon to grey.
    suffixIconColor: Colors.grey, // Sets the color of the suffix icon to grey.

    // Defines the style for labels when not focused or floating.
    labelStyle: const TextStyle().copyWith(
      fontSize: 14.0, // Sets the label font size to 14 pixels.
      color: Colors.white, // Sets the label color to white for the dark theme.
    ),

    // Defines the style for hint text inside the input field.
    hintStyle: const TextStyle().copyWith(
      fontSize: 14.0, // Sets the hint font size to 14 pixels.
      color: Colors.white, // Sets the hint text color to white for the dark theme.
    ),

    // Defines the style for error messages.
    errorStyle: const TextStyle().copyWith(
      fontStyle: FontStyle.normal, // Sets the error text font style to normal.
    ),

    // Defines the label style when the input field is focused.
    floatingLabelStyle: const TextStyle().copyWith(
      color: Colors.white.withOpacity(0.8), // Sets the floating label color with reduced opacity in the dark theme.
    ),

    // Defines the border style when the input field is in a normal state (not focused).
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0), // Rounds the input field borders with a 14-pixel radius.
      borderSide: const BorderSide(
        width: 1.0, // Sets the border width to 1 pixel.
        color: Colors.grey, // Sets the border color to grey.
      ),
    ),

    // Defines the border style when the input field is enabled but not focused.
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.grey,
      ),
    ),

    // Defines the border style when the input field is focused.
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.white, // Uses white color when focused in the dark theme.
      ),
    ),

    // Defines the border style when the input field has an error.
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.red, // Sets the border color to red in case of an error.
      ),
    ),

    // Defines the border style when the input field is focused but has an error.
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: Colors.orange, // Sets the border color to orange when focused with an error.
      ),
    ),
  );
}
