import 'package:flutter/material.dart'; // Import the Flutter Material package for UI components.

class fkfaElevatedButtonTheme {
  // Private constructor to prevent creating multiple instances of the theme.
  fkfaElevatedButtonTheme._();

  // Define the light theme for elevated buttons.
  static final LightElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0, // Removes the shadow effect (flat button).
      foregroundColor: Colors.white, // Sets the text/icon color to white for the button.
      backgroundColor: Colors.blueAccent, // Sets the background color to blueAccent for the button.
      disabledForegroundColor: Colors.grey, // Sets the text/icon color to grey when the button is disabled.
      disabledBackgroundColor: Colors.grey, // Sets the background color to grey when the button is disabled.
      side: const BorderSide(color: Colors.blue), // Adds a blue border around the button.
      padding: const EdgeInsets.symmetric(vertical: 10), // Adds 10 pixels of vertical padding inside the button.
      textStyle: const TextStyle(
        fontSize: 16, // Sets the font size of the button text to 16 pixels.
        color: Colors.white, // The text color remains white.
        fontWeight: FontWeight.w600, // Makes the button text semi-bold.
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Sets the button corners to be rounded with a 12-pixel radius.
      ),
    ),
  );

  // Define the dark theme for elevated buttons.
  static final darkElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0, // Removes the shadow effect (flat button).
      foregroundColor: Colors.white, // Sets the text/icon color to white for the button.
      backgroundColor: Colors.blueAccent, // Sets the background color to blueAccent for the button.
      disabledForegroundColor: Colors.grey, // Sets the text/icon color to grey when the button is disabled.
      disabledBackgroundColor: Colors.grey, // Sets the background color to grey when the button is disabled.
      side: const BorderSide(color: Colors.blue), // Adds a blue border around the button.
      padding: const EdgeInsets.symmetric(vertical: 10), // Adds 10 pixels of vertical padding inside the button.
      textStyle: const TextStyle(
        fontSize: 16, // Sets the font size of the button text to 16 pixels.
        color: Colors.white, // The text color remains white.
        fontWeight: FontWeight.w600, // Makes the button text semi-bold.
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Sets the button corners to be rounded with a 12-pixel radius.
      ),
    ),
  );
}
