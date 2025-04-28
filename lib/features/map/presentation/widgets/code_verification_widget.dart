import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../screens/payment_input.dart';

class CodeVerificationWidget extends StatefulWidget {
  String verificationId;
  CodeVerificationWidget({super.key, required this.verificationId});

  @override
  State<CodeVerificationWidget> createState() => _CodeVerificationWidgetState();
}

class _CodeVerificationWidgetState extends State<CodeVerificationWidget> {
  final TextEditingController codeController = TextEditingController();
  bool loading = false;

  Future<void> verifyCode() async {
    final smsCode = codeController.text.trim();

    if (smsCode.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Enter the full 6-digit code')));
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Teléfono verificado correctamente!')),
      );
      await context.pushNamed(PaymentScreen.name);
      //navigate to other screen
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone verification')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Enter the code you received'),
            SizedBox(height: 20),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Código SMS',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: () async {
                    await verifyCode();
                    //context.pushNamed(PaymentScreen.name);
                  },
                  child: Text('Verificar'),
                ),
          ],
        ),
      ),
    );
  }
}
