import 'package:flutter/material.dart';
import './utils.dart';

class AppButtonStyles {
  static ButtonStyle primaryButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.pressed)) {
        return appColors.primaryHoverColor;
      }
      return appColors.primaryColor;
    }),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(appTextStyles.button),
    elevation: WidgetStateProperty.all<double>(3),
  );

  static ButtonStyle secondaryButton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.pressed)) {
        return appColors.primaryHoverColor;
      }
      return appColors.primaryColor;
    }),
    side: WidgetStateProperty.resolveWith<BorderSide>((states) {
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.pressed)) {
        return BorderSide(color: appColors.primaryHoverColor, width: 2);
      }
      return BorderSide(color: appColors.primaryColor, width: 2);
    }),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textStyle: WidgetStateProperty.all<TextStyle>(
      appTextStyles.button.copyWith(color: appColors.primaryColor),
    ),
    elevation: WidgetStateProperty.all<double>(0),
  );
}
