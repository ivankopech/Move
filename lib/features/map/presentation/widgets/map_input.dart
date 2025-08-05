import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:move/common/widgets/loader_widget.dart';
import '/features/map/presentation/screens/address_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

import '../../../home/presentation/widgets/app_drawer.dart';
import './input_address_sheet.dart';
import '../widgets/map_helper.dart';
import './arrival_time.dart';
import './tip_dialog.dart';

import '../../../requests/presentation/providers/get_requests_state_notifier_provider.dart';

class MapInputWidget extends ConsumerStatefulWidget {
  const MapInputWidget({super.key});

  @override
  ConsumerState<MapInputWidget> createState() => _MapInputWidgetState();
}

class _MapInputWidgetState extends ConsumerState<MapInputWidget> {
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
  bool hasShownDialog = false;

  @override
  void initState() {
    super.initState();
    currentLocation();
    loadEnv();
    Future.microtask(() async {
      await ref
          .read(getRequestsStateNotifierProvider.notifier)
          .getRequests('Finished');

      await Future.delayed(Duration(milliseconds: 300));

      showTipDialog();
    });
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
      showLocationDialog(
        title: 'Service disabled',
        message: 'Please activate location services on your device',
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showLocationDialog(
          title: 'Permission denied',
          message: 'We need your location to continue',
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showLocationDialog(
        title: 'Permission permanently denied',
        message: 'You must allow location permissions on your device settings',
        openSettings: true,
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      LatLng userLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        currentPosition = userLatLng;
        selectedPosition = userLatLng;
      });
      getAddressLatLng(userLatLng);
    } catch (e) {
      print('Error while obtaining location: $e');
    }
  }

  Future<void> getAddressLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

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
    final result = await context.push<Map<String, String>>(
      AddressInputScreen.path,
      extra: {
        'originController': originAddressController,
        'destinationController': destinationAddressController,
      },
    );

    if (result != null &&
        result['origin'] != null &&
        result['destination'] != null) {
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

  void showTipDialog() async {
    if (hasShownDialog) return;
    final finishedRequests = ref.read(getRequestsStateNotifierProvider);
    finishedRequests.when(
      data: (request) async {
        final toPrompt =
            request
                .where((r) => r?.tipAmount == 0.0 && r?.tipPercent == 0.0)
                .toList();

        if (toPrompt.isEmpty) return;

        hasShownDialog = true;

        for (final request in toPrompt) {
          if (request == null) continue;

          final from = '${request.calleDesde} ${request.numeroDesde}';
          final to = '${request.calleHasta} ${request.numeroHasta}';

          final result = await showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (_) => TipDialog(
                  id: request.id,
                  from: from,
                  to: to,
                  date: request.fechaViaje,
                ),
          );

          if (result == true) {
            await ref
                .read(getRequestsStateNotifierProvider.notifier)
                .getRequests('Finished');
          }
        }
      },
      loading: () => LoaderWidget(),
      error: (e, _) => print('Error: $e'),
    );
  }

  void showLocationDialog({
    required String title,
    required String message,
    bool openSettings = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (openSettings)
                CupertinoDialogAction(
                  onPressed: () {
                    Geolocator.openAppSettings();
                    Navigator.pop(context);
                  },
                  child: Text('Open config'),
                ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDefaultAction: true,
                child: Text('Close'),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              if (openSettings)
                TextButton(
                  onPressed: () {
                    Geolocator.openAppSettings();
                    Navigator.pop(context);
                  },
                  child: Text('Open config'),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cerrar'),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final finishedRequests = ref.watch(getRequestsStateNotifierProvider);

    return Scaffold(
      drawer: const AppDrawer(),
      body:
          currentPosition == null
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
                      : ArrivalTime(),
                ],
              ),
    );
  }
}
