import 'package:flutter/material.dart';

import '../widgets/arrival_time.dart';

class ArrivalTimeScreen extends StatefulWidget {
  static const path = '/arrival-time';
  static const name = 'arrival-time';

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
