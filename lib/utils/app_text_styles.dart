import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTextStyles extends Equatable {
  final TextStyle headline;
  final TextStyle subhead;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle button;

  const AppTextStyles({
    this.headline = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    this.subhead = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    this.body = const TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    this.caption = const TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
    this.button = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  });

  @override
  List<Object?> get props => [headline, subhead, body, caption, button];
}
final appTextStyles = const AppTextStyles();