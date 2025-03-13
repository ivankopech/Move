import 'package:flutter/material.dart';

import './map_input.dart';

class ScrollableSheet extends StatefulWidget {
  final TextEditingController originAddressController;
  final TextEditingController destinationAddressController;
  final TextEditingController locController;
  final VoidCallback onAddressTap;

  const ScrollableSheet({
    Key? key,
    required this.originAddressController,
    required this.destinationAddressController,
    required this.locController,
    required this.onAddressTap,
  }) : super(key: key);

  @override
  _ScrollableSheetState createState() => _ScrollableSheetState();
}

class _ScrollableSheetState extends State<ScrollableSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.3,
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
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: widget.originAddressController,
                        onTap: widget.onAddressTap,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 246, 246),
                          prefixIcon: const Icon(Icons.arrow_upward_outlined),
                          hintText: 'Enter pickup location...',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.indigo,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        ),
                      ),
                      if (widget.originAddressController.text.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        TextField(
                          controller: widget.destinationAddressController,
                          onTap: widget.onAddressTap,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 248, 246, 246),
                            prefixIcon: const Icon(Icons.arrow_upward_outlined),
                            hintText: 'Enter drop-off location...',
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.indigo,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                          ),
                        ),
                      ],
                      if (widget.originAddressController.text.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
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
                                "Continuar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (widget.originAddressController.text.isEmpty &&
                          widget.destinationAddressController.text.isEmpty) ...[
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
                                widget.locController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
