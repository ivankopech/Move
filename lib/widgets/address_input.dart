import 'package:flutter/material.dart';

class AddressInput extends StatefulWidget {
  final TextEditingController originAddressController;
  final TextEditingController destinationAddressController;

  const AddressInput({
    super.key,
    required this.originAddressController,
    required this.destinationAddressController,
  });

  @override
  State<AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  late FocusNode originFocusNode;
  late FocusNode destinationFocusNode;

  @override
  void initState() {
    super.initState();
    originFocusNode = FocusNode();
    destinationFocusNode = FocusNode();

    originFocusNode.addListener(() {
      if (originFocusNode.hasFocus) {
        setState(() {
          //que cambie el nombre
        });
      }
    });
  }

  @override
  void dispose() {
    originFocusNode.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print('entro');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          originFocusNode.hasFocus
              ? 'Pickup'
              : destinationFocusNode.hasFocus
                  ? 'Drop off'
                  : 'Pickup',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: widget.originAddressController,
              focusNode: originFocusNode, // Associate with focus node
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: widget.destinationAddressController,
              focusNode: destinationFocusNode, // Associate with focus node
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 248, 246, 246),
                prefixIcon: const Icon(Icons.arrow_downward_outlined),
                hintText: 'Enter destination location...',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.indigo,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
