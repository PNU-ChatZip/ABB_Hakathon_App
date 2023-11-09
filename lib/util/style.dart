import 'package:flutter/material.dart';

class ColorStyles {
  static const Color mainColor = Colors.green;
}

class ButtonStyles {
  static ButtonStyle mainButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(fontSize: 16), // Set the font size
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      ColorStyles.mainColor,
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      Colors.white,
    ),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(
          color: ColorStyles.mainColor, width: 2), // Set border color and width
    ),
  );

  static ButtonStyle closeButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(fontSize: 16), // Set the font size
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      Colors.redAccent,
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      Colors.white,
    ),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(
          color: Colors.redAccent, width: 2), // Set border color and width
    ),
  );
}
