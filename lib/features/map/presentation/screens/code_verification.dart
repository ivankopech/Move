import 'package:flutter/material.dart';

import '../widgets/code_verification_widget.dart';

class CodeVerificationScreen extends StatefulWidget {
  String verificationId;
  static const path = '/code-verification';
  static const name = 'code-verification';
  CodeVerificationScreen({super.key, required this.verificationId});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return CodeVerificationWidget(verificationId: widget.verificationId);
  }
}
