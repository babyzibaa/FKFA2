import 'package:flutter/material.dart'; // Import the Flutter Material package for UI components.

class fkfaBottomSheetTheme {
  // Private constructor to prevent the class from being instantiated.
  fkfaBottomSheetTheme._();

  // Define a light theme for the bottom sheet.
  static BottomSheetThemeData lightBottomSheet = BottomSheetThemeData(
    showDragHandle: true, // Displays a small handle on the bottom sheet for dragging.
    backgroundColor: Colors.white, // Sets the background color of the bottom sheet to white.
    modalBackgroundColor: Colors.white, // Sets the background color when the bottom sheet is in modal mode.
    constraints: const BoxConstraints(
      minWidth: double.infinity, // Ensures the bottom sheet stretches to the full width of the screen.
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Gives the bottom sheet rounded corners with a radius of 16 pixels.
    ),
  );

  // Define a dark theme for the bottom sheet.
  static BottomSheetThemeData darkBottomSheet = BottomSheetThemeData(
    showDragHandle: true, // Displays a small handle on the bottom sheet for dragging.
    backgroundColor: Colors.black, // Sets the background color of the bottom sheet to black (for dark mode).
    modalBackgroundColor: Colors.black, // Sets the background color when the bottom sheet is in modal mode (dark).
    constraints: const BoxConstraints(
      minWidth: double.infinity, // Ensures the bottom sheet stretches to the full width of the screen.
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Gives the bottom sheet rounded corners with a radius of 16 pixels.
    ),
  );
}
