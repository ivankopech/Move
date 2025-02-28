import 'package:flutter/material.dart';

import '../widgets/address_input.dart';

class AddressInputScreen extends StatefulWidget {
  static const routeName = '/address-input';

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

  @override
  Widget build(BuildContext context) {
    return AddressInput(
      originAddressController: originAddressController!,
      destinationAddressController: destinationAddressController!,
    );
  }
}
