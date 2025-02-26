import 'package:flutter/material.dart';

Widget scrollableSheet(TextEditingController addressController,
    TextEditingController locController) {
  return DraggableScrollableSheet(
    initialChildSize: 0.2,
    minChildSize: 0.2,
    maxChildSize: 0.5,
    builder: (context, scrollController) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
            ),
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 248, 246, 246),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Enter pickup location',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.indigo,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        locController.text,
                        style: const TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
