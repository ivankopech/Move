import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppColors extends Equatable {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color textColor;
  final Color errorColor;

  const AppColors({
    this.primaryColor = const Color(0xFF007AFF),
    this.secondaryColor = const Color(0xFFFF9500),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.errorColor = const Color(0xFFFF0000),
  });

  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? textColor,
    Color? errorColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  @override
  List<Object?> get props => [primaryColor, secondaryColor, backgroundColor, textColor, errorColor];
}

// Instancia global de AppColors
final appColors = const AppColors();