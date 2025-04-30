import 'package:flutter/material.dart';

import '../widgets/payment_input_widget.dart';

class PaymentScreen extends StatefulWidget {
  static const path = '/payment-input';
  static const name = 'payment-input';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return PaymentWidget();
  }
}
