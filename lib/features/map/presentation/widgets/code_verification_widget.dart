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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Phone number verified!')));
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
                hintText: 'Código SMS',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const Spacer(),
            loading
                ? CircularProgressIndicator()
                : Container(
                  margin: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () async {
                      await verifyCode();
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
                          "Verify code",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
