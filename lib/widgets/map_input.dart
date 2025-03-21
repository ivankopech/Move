import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:move_app/screens/address_input.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../widgets/drawer.dart';
import './input_address_sheet.dart';
import '../widgets/map_helper.dart';
import './select_vehicle_sheet.dart';

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
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  String apiKey = dotenv.env['API_KEY'] ?? '';
  bool showInputSheet = true;

  @override
  void initState() {
    super.initState();
    currentLocation();
    loadEnv();
  }

  Future<void> loadEnv() async {
    await dotenv.load();
    setState(() {
      apiKey = dotenv.env['API_KEY'] ?? '';
    });
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

  Future<void> openAddressInput() async {
    final result = await Navigator.of(context)
        .pushNamed(AddressInputScreen.routeName, arguments: {
      'originController': originAddressController,
      'destinationController': destinationAddressController,
    });
    if (result != null && result is Map<String, String>) {
      setState(() {
        originAddressController.text = result['origin']!;
        destinationAddressController.text = result['destination']!;
      });
      updateMap();
    }
  }

  Future<void> updateMap() async {
    if (originAddressController.text.isNotEmpty &&
        destinationAddressController.text.isNotEmpty) {
      try {
        Set<Marker> marker = await MapHelper.generateMarkers(
          origin: originAddressController.text,
          destination: destinationAddressController.text,
        );
        Polyline polyline = await MapHelper.generatePolyline(
          origin: originAddressController.text,
          destination: destinationAddressController.text,
          apiKey: apiKey,
        );
        setState(() {
          markers = marker;
          polylines = {polyline};
        });
        if (markers.isNotEmpty) {
          mapController?.animateCamera(
            CameraUpdate.newLatLng(marker.first.position),
          );
        }
      } catch (e) {
        print('error es: $e');
      }
    }
  }

  void toggleSheet() {
    setState(() {
      showInputSheet = !showInputSheet;
    });
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
                      updateMap();
                    },
                    markers: markers,
                    polylines: polylines,
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
                showInputSheet
                    ? InputAddressSheet(
                        originAddressController: originAddressController,
                        destinationAddressController:
                            destinationAddressController,
                        locController: markerAddressController,
                        onAddressTap: openAddressInput,
                        onContinue: toggleSheet,
                      )
                    : SelectVehicleSheet(),
              ],
            ),
    );
  }
}
