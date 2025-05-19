import 'package:flutter/material.dart';
import '../widgets/validate_phone_number_widget.dart';

class ValidatePhoneNumberScreen extends StatefulWidget {
  static const path = '/validate-number';
  static const name = 'validate-number';
  const ValidatePhoneNumberScreen({super.key});

  @override
  State<ValidatePhoneNumberScreen> createState() =>
      _ValidatePhoneNumberScreenState();
}

class _ValidatePhoneNumberScreenState extends State<ValidatePhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return const ValidatePhoneNumberWidget();
  }
}
