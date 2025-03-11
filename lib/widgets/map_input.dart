import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/drawer.dart';
import '../widgets/bottom_sheet.dart';

class MapInputWidget extends StatefulWidget {
  const MapInputWidget({super.key});

  @override
  State<MapInputWidget> createState() => _MapInputWidgetState();
}

class _MapInputWidgetState extends State<MapInputWidget> {
  final LatLng center = const LatLng(-32.944242, -60.650538);
  GoogleMapController? mapController;
  LatLng? currentPosition;
  LatLng? selectedPosition;
  TextEditingController originAddressController = TextEditingController();
  TextEditingController destinationAddressController = TextEditingController();
  TextEditingController markerAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentLocation();
  }

  Future<void> currentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('location services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    LatLng userLatLng = LatLng(position.latitude, position.longitude);

    setState(() {
      currentPosition = userLatLng;
      selectedPosition = userLatLng;
    });
    getAddressLatLng(userLatLng);
  }

  Future<void> getAddressLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String formattedAddress =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
        setState(() {
          markerAddressController.text = formattedAddress;
        });
      }
    } catch (e) {
      print('error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentPosition!,
                      zoom: 17,
                    ),
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    onCameraIdle: () {
                      if (selectedPosition != null) {
                        getAddressLatLng(selectedPosition!);
                      }
                    },
                    onCameraMove: (position) {
                      setState(() {
                        selectedPosition = position.target;
                      });
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 24,
                  left: MediaQuery.of(context).size.width / 2 - 24,
                  child: const Icon(
                    Icons.location_on,
                    size: 60,
                    color: Colors.indigo,
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 15,
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.waving_hand_outlined),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                ),
                ScrollableSheet(
                  originAddressController: originAddressController,
                  destinationAddressController: destinationAddressController,
                  locController: markerAddressController,
                ),
              ],
            ),
    );
  }
}
