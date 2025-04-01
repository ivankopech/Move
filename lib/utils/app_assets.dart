import 'package:flutter/material.dart';

class AppAssets {
  static const String loginJheet = 'assets/images/loginjeet.png';
  // static const String logoSvg = 'assets/icons/logo.svg';
  // static const String otroPng = 'assets/images/otro.png';
}

Widget appImage(String imagePath) {
  return Image.asset(imagePath);
}