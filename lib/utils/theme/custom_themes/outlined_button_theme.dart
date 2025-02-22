import 'package:flutter/material.dart'; // Importing the Flutter Material package for UI components.

class fkfaOutlinedButtonTheme {
  // Private constructor to prevent creating multiple instances.
  fkfaOutlinedButtonTheme._();

  // Define the light theme for outlined buttons.
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0, // Removes the shadow effect, making it flat.
      foregroundColor: Colors.black, // Sets the text/icon color to black for the button.
      side: const BorderSide(color: Colors.blue), // Adds a blue border around the button.
      textStyle: const TextStyle(
        fontSize: 16.0, // Sets the font size of the button text to 16 pixels.
        color: Colors.black, // Text color remains black.
        fontWeight: FontWeight.w600, // Makes the text semi-bold.
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0, // Adds 16 pixels of vertical padding inside the button.
        horizontal: 20.0, // Adds 20 pixels of horizontal padding inside the button.
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0), // Sets the button corners to be rounded with a 14-pixel radius.
      ),
    ),
  );

  // Define the dark theme for outlined buttons.
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0, // Removes the shadow effect, making it flat.
      foregroundColor: Colors.white, // Sets the text/icon color to white for the button.
      side: const BorderSide(color: Colors.blueAccent), // Adds a blueAccent border around the button.
      textStyle: const TextStyle(
        fontSize: 16.0, // Sets the font size of the button text to 16 pixels.
        color: Colors.white, // Text color remains white.
        fontWeight: FontWeight.w600, // Makes the text semi-bold.
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0, // Adds 16 pixels of vertical padding inside the button.
        horizontal: 20.0, // Adds 20 pixels of horizontal padding inside the button.
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0), // Sets the button corners to be rounded with a 14-pixel radius.
      ),
    ),
  );
}
