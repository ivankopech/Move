import 'package:flutter/material.dart';

import '../widgets/arrival_time.dart';

class ArrivalTimeScreen extends StatefulWidget {
  static const path = '/address-input';
  static const name = 'address-input';

  const ArrivalTimeScreen({super.key});

  @override
  State<ArrivalTimeScreen> createState() => _ArrivalTimeScreenState();
}

class _ArrivalTimeScreenState extends State<ArrivalTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return ArrivalTime();
  }
}
