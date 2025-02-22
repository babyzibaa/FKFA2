import 'package:flutter/material.dart'; // Import the Flutter Material package for UI components.

class fkfaCheckboxTheme {
  // Private constructor to prevent the class from being instantiated.
  fkfaCheckboxTheme._();

  // Define a light theme for checkboxes.
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Adds rounded corners with a radius of 4 pixels to the checkbox.
    ),
    checkColor: MaterialStateProperty.resolveWith<Color>((states) {
      // Sets the color of the check mark based on the checkbox's state.
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // If the checkbox is selected, the check mark is white.
      } else {
        return Colors.black; // If the checkbox is unselected, the check mark is black.
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      // Sets the background color of the checkbox based on its state.
      if (states.contains(MaterialState.selected)) {
        return Colors.blue; // If the checkbox is selected, the background is blue.
      } else {
        return Colors.transparent; // If the checkbox is unselected, the background is transparent (no color).
      }
    }),
  );

  // Define a dark theme for checkboxes.
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Adds rounded corners with a radius of 4 pixels to the checkbox.
    ),
    checkColor: MaterialStateProperty.resolveWith<Color>((states) {
      // Sets the color of the check mark based on the checkbox's state.
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // If the checkbox is selected, the check mark is white.
      } else {
        return Colors.black; // If the checkbox is unselected, the check mark is black.
      }
    }),
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      // Sets the background color of the checkbox based on its state.
      if (states.contains(MaterialState.selected)) {
        return Colors.blue; // If the checkbox is selected, the background is blue.
      } else {
        return Colors.transparent; // If the checkbox is unselected, the background is transparent (no color).
      }
    }),
  );
}
