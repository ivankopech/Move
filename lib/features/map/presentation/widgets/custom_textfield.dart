import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Icon icon;
  final String hintText;
  final bool isOrigin;
  final List<String> suggestions;
  final Function(String, bool) onSuggestionTap;
  final Function(String, bool) fetchSuggestions;
  final Function(bool) onTap;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.icon,
    required this.hintText,
    required this.isOrigin,
    required this.suggestions,
    required this.onSuggestionTap,
    required this.fetchSuggestions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          onTap: onTap(isOrigin),
          onChanged: (input) => fetchSuggestions(input, isOrigin),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 248, 246, 246),
            prefixIcon: icon,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.indigo),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.indigo),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        ),
        if ((isOrigin && suggestions.isNotEmpty) ||
            (!isOrigin && suggestions.isNotEmpty))
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 5),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: (isOrigin ? suggestions : suggestions)
                  .map((suggestion) => ListTile(
                        title: Text(suggestion),
                        onTap: () => onSuggestionTap(suggestion, isOrigin),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
