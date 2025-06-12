import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hint,
  required Icon icon,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: icon,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}

Widget buildButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.indigo,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    onPressed: onPressed,
    child: Text(text),
  );
}
