import 'package:flutter/material.dart';

import '../widgets/item_information.dart';

class ItemInformationScreen extends StatefulWidget {
  static const path = '/item-info-input';
  static const name = 'item-info-input';

  const ItemInformationScreen({super.key});

  @override
  State<ItemInformationScreen> createState() => _ItemInformationScreenState();
}

class _ItemInformationScreenState extends State<ItemInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return ItemInformation();
  }
}
