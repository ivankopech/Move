import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppColors extends Equatable {
  final Color primaryColor;
  final Color primaryHoverColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color errorColor;

  const AppColors({
    this.primaryColor = const Color(0xFFF01AC8), // Color principal (magenta)
    this.primaryHoverColor = const Color(0xFFF557D8), // Hover
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.surfaceColor = const Color(0xFFF7F7F7),
    this.textPrimary = const Color(0xFF000000),
    this.textSecondary = const Color(0xFF555555),
    this.errorColor = const Color(0xFFFF3B30),
  });

  @override
  List<Object?> get props => [
    primaryColor,
    primaryHoverColor,
    backgroundColor,
    surfaceColor,
    textPrimary,
    textSecondary,
    errorColor,
  ];
}

final appColors = const AppColors();
