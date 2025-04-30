import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomCreditCardWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(CreditCardModel) onModelChange;

  const CustomCreditCardWidget({
    super.key,
    required this.formKey,
    required this.onModelChange,
  });

  @override
  State<CustomCreditCardWidget> createState() => _CustomCreditCardWidgetState();
}

class _CustomCreditCardWidgetState extends State<CustomCreditCardWidget> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: isCvvFocused,
          obscureCardNumber: false,
          obscureCardCvv: true,
          isHolderNameVisible: true,
          cardBgColor: const Color(0xFF3B3B98),
          isSwipeGestureEnabled: true,
          onCreditCardWidgetChange: (_) {},
        ),
        const SizedBox(height: 20),
        CreditCardForm(
          formKey: widget.formKey,
          obscureCvv: true,
          obscureNumber: false,
          cardNumber: cardNumber,
          cvvCode: cvvCode,
          isHolderNameVisible: true,
          isCardNumberVisible: true,
          isExpiryDateVisible: true,
          cardHolderName: cardHolderName,
          expiryDate: expiryDate,
          isCardHolderNameUpperCase: true,
          onCreditCardModelChange: (model) {
            setState(() {
              cardNumber = model.cardNumber;
              expiryDate = model.expiryDate;
              cardHolderName = model.cardHolderName;
              cvvCode = model.cvvCode;
              isCvvFocused = model.isCvvFocused;
            });
            widget.onModelChange(model);
          },
        ),
      ],
    );
  }
}
