import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../../requests/data/models/get_requests_model.dart';
import '../../../requests/presentation/providers/get_tracking_state_notifier_provider.dart';
import '../../../map/presentation/widgets/map_helper.dart';

class TrackDelivery extends ConsumerStatefulWidget {
  final GetRequestsModel requestsModel;
  const TrackDelivery({super.key, required this.requestsModel});

  @override
  ConsumerState<TrackDelivery> createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends ConsumerState<TrackDelivery> {
  GoogleMapController? mapController;
  Marker? vehicleMarker;
  Marker? destinationMarker;
  Timer? pollingTimer;
  LatLng? currentPosition;
  LatLng? destinationPosition;
  double? destinationLat;
  double? destinationLng;
  Set<Polyline> polylines = {};
  bool isListening = false;
  bool markersLoaded = false;
  late BitmapDescriptor vehicleIcon;
  late BitmapDescriptor destinationIcon;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await loadIcons();
      await loadDestinationPosition();
      ref
          .read(getTrackingStateNotifierProvider.notifier)
          .trackRequest(widget.requestsModel.id!);
      startPolling();
    });
  }

  Future<String> buildOrigin(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) return '';

      final p = placemarks.first;

      final name = p.street ?? '';
      final streetName = p.thoroughfare ?? '';
      final number = p.subThoroughfare ?? '';
      final zip = p.postalCode ?? '';
      final city = p.subAdministrativeArea ?? '';
      final state = p.administrativeArea ?? '';
      final country = p.country ?? '';

      return '$name, $streetName $number, $zip $city, $state, $country'.trim();
    } catch (e) {
      print('error converting LatLng to address: $e');
      return '';
    }
  }

  String buildDestination() {
    final data = widget.requestsModel;

    final street = data.calleHasta;
    final number = data.numeroHasta;
    final city = data.tramos![1].direccion!.city;
    final state = data.tramos![1].direccion!.state;
    final zipCode = data.tramos![1].direccion!.zipCode;
    final country = data.tramos![1].direccion!.country;

    return '$street $number, $zipCode $city, $state, $country';
  }

  Future<void> loadDestinationPosition() async {
    try {
      final address = buildDestination();
      if (address.isEmpty) return;

      final latLng = await MapHelper.getLatLngFromAddress(address);

      destinationMarker = buildMarker(
        id: 'destination',
        position: latLng,
        icon: destinationIcon,
      );
      setState(() {});
    } catch (e) {
      print("Error obtaining destination: $e");
    }
    loadPolyline();
  }

  Future<LatLng> addressToLatLng(String address) {
    return MapHelper.getLatLngFromAddress(address);
  }

  Future<void> loadMarkers() async {
    setState(() {
      if (currentPosition != null) {
        vehicleMarker = buildMarker(
          id: 'vehicle',
          position: currentPosition!,
          icon: vehicleIcon,
        );
      }
    });
  }

  void startPolling() {
    pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      ref
          .read(getTrackingStateNotifierProvider.notifier)
          .trackRequest(widget.requestsModel.id!);
    });
  }

  Marker buildMarker({
    required String id,
    required LatLng position,
    required BitmapDescriptor icon,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      icon: markersLoaded ? icon : BitmapDescriptor.defaultMarker,
    );
  }

  void animateMarker(LatLng newPosition) {
    if (mapController == null) return;
    setState(() {
      currentPosition = newPosition;
      vehicleMarker = buildMarker(
        id: 'vehicle',
        position: newPosition,
        icon: vehicleIcon,
      );
    });
    mapController?.animateCamera(CameraUpdate.newLatLng(newPosition));
  }

  void moveCamera(LatLng target) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: 15)),
    );
  }

  void destinationToLatLng(String address) {
    MapHelper.getLatLngFromAddress(address);
  }

  Future<void> loadIcons() async {
    vehicleIcon = await MapHelper.createEmojiMarker('🚘');
    destinationIcon = await MapHelper.createEmojiMarker('🏠');
    markersLoaded = true;
  }

  Future<void> loadPolyline() async {
    if (currentPosition == null || destinationMarker == null) {
      print(
        'polyline not ready. current position or destination marker is null',
      );
      return;
    }

    try {
      final origin = await buildOrigin(currentPosition!);
      final destination = buildDestination();

      final polyline = await MapHelper.generatePolyline(
        origin: origin,
        destination: destination,
        apiKey: dotenv.env['API_KEY']!,
      );

      if (polyline.points.isNotEmpty) {
        setState(() {
          polylines.clear();
          polylines = {polyline};
        });
      } else {
        print('polyline returned EMPTY!');
      }
    } catch (e) {
      print('error loading polyline: $e');
    }
  }

  Widget deliveryData() {
    return Row(
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 40,
          color: Color.fromARGB(255, 220, 217, 227),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Delivery #${widget.requestsModel.id}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 5),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'FROM: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '${widget.requestsModel.calleDesde} ${widget.requestsModel.numeroDesde}, ${widget.requestsModel.tramos![0].direccion!.city}',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'TO: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '${widget.requestsModel.calleHasta} ${widget.requestsModel.numeroHasta}, ${widget.requestsModel.tramos![1].direccion!.city}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    pollingTimer?.cancel();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getTrackingStateNotifierProvider, (prev, next) {
      next.whenData((trackingData) {
        if (trackingData.isNotEmpty) {
          final latest = trackingData.first;
          final lat = (latest?.latitude ?? 0).toDouble();
          final lng = (latest?.longitude ?? 0).toDouble();
          final newPosition = LatLng(lat, lng);

          if (!markersLoaded) {
            loadMarkers();
            markersLoaded = true;
            setState(() {});
          }

          if (currentPosition == null) {
            setState(() {
              currentPosition = newPosition;

              vehicleMarker = buildMarker(
                id: 'vehicle',
                position: newPosition,
                icon: vehicleIcon,
              );
            });
            moveCamera(newPosition);
          } else if (currentPosition != newPosition) {
            animateMarker(newPosition);
          }
          loadPolyline();
        }
      });
    });

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body:
          currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentPosition!,
                      zoom: 15,
                    ),
                    markers: {
                      if (vehicleMarker != null) vehicleMarker!,
                      if (destinationMarker != null) destinationMarker!,
                    },
                    polylines: polylines,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                  ),

                  Positioned(
                    left: 40,
                    right: 40,
                    bottom: 50,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 112, 128, 219),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.deepPurpleAccent),
                      ),
                      child: deliveryData(),
                    ),
                  ),
                ],
              ),
    );
  }
}
