import 'package:flutter/material.dart';

import '../widgets/map_input.dart';

class MapInputScreen extends StatefulWidget {
  static const routeName = '/location-input';
  const MapInputScreen({super.key});

  @override
  State<MapInputScreen> createState() => _MapInputScreenState();
}

class _MapInputScreenState extends State<MapInputScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MapInputWidget();
  }
}
