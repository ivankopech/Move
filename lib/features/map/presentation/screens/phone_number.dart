import 'package:flutter/material.dart';

import '../widgets/phone_number.dart';

class PhoneNumberScreen extends StatefulWidget {
  static const path = '/phone-number';
  static const name = 'phone-number';

  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return PhoneNumber();
  }
}
