import 'package:flutter/material.dart';

class AppAssets {
  static const String loginJeet = 'assets/images/loginjeet.png';
}

Widget appImage(String imagePath) {
  return Image.asset(imagePath, scale: 20);
}
