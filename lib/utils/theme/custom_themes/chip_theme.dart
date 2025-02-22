import 'package:flutter/material.dart'; // Import the Flutter Material package for UI components.

class fkfaChipTheme {
  // Private constructor to prevent the class from being instantiated.
  fkfaChipTheme._();

  // Define a light theme for chips (small UI elements representing inputs, filters, or choices).
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4), // Sets the color of the chip when disabled, with reduced opacity.
    labelStyle: const TextStyle(
      color: Colors.black, // Sets the text color on the chip label to black for the light theme.
    ),
    selectedColor: Colors.blue, // Sets the background color of the chip when it's selected to blue.
    padding: const EdgeInsets.symmetric(
      horizontal: 12.0, // Adds horizontal padding of 12 pixels around the chip content.
      vertical: 12, // Adds vertical padding of 12 pixels around the chip content.
    ),
    checkmarkColor: Colors.white, // Sets the color of the checkmark when the chip is selected to white.
  );

  // Define a dark theme for chips.
  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4), // Sets the color of the chip when disabled, with reduced opacity.
    labelStyle: const TextStyle(
      color: Colors.white, // Sets the text color on the chip label to white for the dark theme.
    ),
    selectedColor: Colors.blue, // Sets the background color of the chip when it's selected to blue.
    padding: const EdgeInsets.symmetric(
      horizontal: 12.0, // Adds horizontal padding of 12 pixels around the chip content.
      vertical: 12, // Adds vertical padding of 12 pixels around the chip content.
    ),
    checkmarkColor: Colors.white, // Sets the color of the checkmark when the chip is selected to white.
  );
}
