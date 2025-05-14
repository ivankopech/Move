import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppPaddings extends Equatable {
  final EdgeInsets small;
  final EdgeInsets medium;
  final EdgeInsets large;
  final EdgeInsets horizontal;
  final EdgeInsets vertical;

  const AppPaddings({
    this.small = const EdgeInsets.all(8.0),
    this.medium = const EdgeInsets.all(16.0),
    this.large = const EdgeInsets.all(24.0),
    this.horizontal = const EdgeInsets.symmetric(horizontal: 16.0),
    this.vertical = const EdgeInsets.symmetric(vertical: 16.0),
  });

  AppPaddings copyWith({
    EdgeInsets? small,
    EdgeInsets? medium,
    EdgeInsets? large,
    EdgeInsets? horizontal,
    EdgeInsets? vertical,
  }) {
    return AppPaddings(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      horizontal: horizontal ?? this.horizontal,
      vertical: vertical ?? this.vertical,
    );
  }

  @override
  List<Object?> get props => [small, medium, large, horizontal, vertical];
}

// Instancia global de AppPaddings
final appPaddings = const AppPaddings();