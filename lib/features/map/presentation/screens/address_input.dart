import 'package:flutter/material.dart';

import '../widgets/address_input.dart';

class AddressInputScreen extends StatefulWidget {
  static const path = '/address-input';
  static const name = 'address-input';

  const AddressInputScreen({super.key});

  @override
  State<AddressInputScreen> createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  TextEditingController? originAddressController;
  TextEditingController? destinationAddressController;

  @override
  void initState() {
    super.initState();
    originAddressController = TextEditingController();
    destinationAddressController = TextEditingController();
  }

  @override
  void dispose() {
    originAddressController!.dispose();
    destinationAddressController!.dispose();
    super.dispose();
  }

  void handleSelected(String value, bool isOrigin) {
    if (isOrigin) {
      originAddressController?.text = value;
    } else {
      destinationAddressController?.text = value;
    }

    final origin = originAddressController?.text;
    final destination = destinationAddressController?.text;

    if (origin!.isNotEmpty && destination!.isNotEmpty) {
      Navigator.of(context).pop({'origin': origin, 'destination': destination});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddressInput(
      isOrigin: true,
      controller: originAddressController!,
      onSelected: (value) => handleSelected(value, true),
      otherAddress: destinationAddressController?.text,
    );
  }
}
