import 'package:flutter/material.dart'; // Import the Flutter Material package, which provides various UI components.

class fkfaAppBarTheme {
  // Private constructor to prevent the class from being instantiated.
  fkfaAppBarTheme._();

  // Define a light theme for the app bar.
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0, // Removes the shadow below the app bar.
    centerTitle: false, // Aligns the title to the start (left) of the app bar.
    scrolledUnderElevation: 0, // Removes the shadow when the content is scrolled under the app bar.
    backgroundColor: Colors.transparent, // Makes the background color of the app bar transparent.
    surfaceTintColor: Colors.transparent, // Removes any surface tint from the app bar.
    iconTheme: IconThemeData(
      color: Colors.black, // Sets the color of icons in the app bar to black.
      size: 24.0, // Sets the size of icons in the app bar to 24 pixels.
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black, // Sets the color of action icons in the app bar to black.
      size: 24.0, // Sets the size of action icons in the app bar to 24 pixels.
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0, // Sets the font size of the app bar title text to 18 pixels.
      fontWeight: FontWeight.w600, // Makes the app bar title text bold (600 weight).
      color: Colors.black, // Sets the color of the title text to black.
    ),
  );

  // Define a dark theme for the app bar.
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0, // Removes the shadow below the app bar.
    centerTitle: false, // Aligns the title to the start (left) of the app bar.
    scrolledUnderElevation: 0, // Removes the shadow when the content is scrolled under the app bar.
    backgroundColor: Colors.transparent, // Makes the background color of the app bar transparent.
    surfaceTintColor: Colors.transparent, // Removes any surface tint from the app bar.
    iconTheme: IconThemeData(
      color: Colors.black, // Sets the color of icons in the app bar to black.
      size: 24.0, // Sets the size of icons in the app bar to 24 pixels.
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white, // Sets the color of action icons in the app bar to white (for dark mode).
      size: 24.0, // Sets the size of action icons in the app bar to 24 pixels.
    ),
    titleTextStyle: TextStyle(
      fontSize: 18.0, // Sets the font size of the app bar title text to 18 pixels.
      fontWeight: FontWeight.w600, // Makes the app bar title text bold (600 weight).
      color: Colors.white, // Sets the color of the title text to white (for dark mode).
    ),
  );
}
