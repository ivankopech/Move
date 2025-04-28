import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:square_in_app_payments/google_pay_constants.dart';
// import 'package:square_in_app_payments/in_app_payments.dart';
// import 'package:square_in_app_payments/models.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import './custom_card_widget.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreditCardModel? currentModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert payment information')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                CustomCreditCardWidget(
                  formKey: formKey,
                  onModelChange: (model) => currentModel = model,
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Valid card!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Wrong data')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),

                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.purple],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        minHeight: 50,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
