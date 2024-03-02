import 'package:d_map/constant/color.dart';
import 'package:flutter/material.dart';

final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    backgroundColor: MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
        return CustomColor.primaryColor;
      },
    ),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  ),
);
