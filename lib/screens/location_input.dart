import 'package:flutter/material.dart';

import '../widgets/location_input.dart';

class LocationInputScreen extends StatefulWidget {
  static const routeName = '/location-input';
  const LocationInputScreen({super.key});

  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  // final LatLng center = const LatLng(-32.944242, -60.650538);
  // GoogleMapController? mapController;
  // LatLng? currentPosition;
  // LatLng? selectedPosition;
  // TextEditingController? originAddressController = TextEditingController();
  // TextEditingController? markerAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const LocationInputWidget();
  }
}
