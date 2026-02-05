import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:move/features/home/presentation/providers/providers.dart';
import 'package:move/features/map/presentation/services/live_activity_service.dart';
import 'package:move/features/requests/data/models/get_tracking_model.dart';
import '../../../requests/data/models/get_requests_model.dart';
import '../../../requests/presentation/providers/get_tracking_state_notifier_provider.dart';
import '../../../requests/presentation/providers/get_requests_state_notifier_provider.dart';
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
  final liveActivityService = LiveActivityService();
  ProviderSubscription<double?>? distanceSub;
  bool startingLive = false;
  bool liveStarted = false;
  bool endingLive = false;
  String? lastStatus;
  DateTime lastLiveUpdate = DateTime.fromMillisecondsSinceEpoch(0);
  double? lastSentKm;
  ProviderSubscription<AsyncValue<GetTrackingModelResponse>>? trackingSub;
  ProviderSubscription<AsyncValue<List<GetRequestsModel?>>>? requestsSub;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await loadIcons();
      await loadDestinationPosition();
      if (!mounted) return;
      ref
          .read(getTrackingStateNotifierProvider.notifier)
          .trackRequest(widget.requestsModel.id!);
      // ref
      //     .read(getRequestsStateNotifierProvider.notifier)
      //     .getRequests(widget.requestsModel.id!, false);
      startPolling();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await startLiveActivity();
    });
    distanceSub = ref.listenManual(distanceDeliveryProvider, (
      prev,
      next,
    ) async {
      if (!liveStarted) return;
      if (next == null) return;

      final now = DateTime.now();
      final tooSoon = now.difference(lastLiveUpdate).inSeconds < 3;
      final tooSmallChange =
          lastSentKm != null && (next - lastSentKm!).abs() < 0.1;

      if (tooSoon || tooSmallChange) return;

      lastLiveUpdate = now;
      lastSentKm = next;

      String street = widget.requestsModel.calleHasta!;
      String number = widget.requestsModel.numeroHasta!;
      String destination = '$street $number';

      await liveActivityService.update(
        status: 'On the way',
        distance: next,
        destination: destination,
      );
    });

    trackingSub = ref.listenManual(getTrackingStateNotifierProvider, (
      prev,
      next,
    ) {
      next.whenData((res) async {
        if (!mounted) return;

        final trackingData = res.items ?? [];
        if (trackingData.isEmpty) return;

        final latest = trackingData.first;
        final lat = latest.latitude;
        final lng = latest.longitude;
        if (lat == null || lng == null) return;

        final newPosition = LatLng(lat, lng);

        if (currentPosition == null) {
          if (!mounted) return;
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

        // Ojo: esto hace requests, puede tardar → re-chequeá mounted
        await loadPolyline();
      });
    });

    requestsSub = ref.listenManual(getRequestsStateNotifierProvider, (
      prev,
      next,
    ) {
      next.whenData((res) async {
        if (!mounted) return;
        if (res.isEmpty) return;

        final status = res.first?.estado;
        if (status == null) return;

        if (status != lastStatus) {
          lastStatus = status;

          if (isFinishedStatus(status) && liveStarted && !endingLive) {
            endingLive = true;
            try {
              await liveActivityService.end();
              liveStarted = false;
            } finally {
              endingLive = false;
            }
          }
        }
      });
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
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      print("Error obtaining destination: $e");
    }
    if (!mounted) return;
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
      if (!mounted) return;
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

      if (!mounted) return;

      if (polyline.points.isNotEmpty) {
        setState(() {
          polylines.clear();
          polylines = {polyline};
        });
        updateDistanceFromPolylines();
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

  void updateDistanceFromPolylines() {
    if (polylines.isEmpty) return;

    final route = polylines.first;
    final kmRaw = MapHelper.polylineDistanceKm(route.points);
    final kmRounded = double.parse(kmRaw.toStringAsFixed(1));

    ref.read(distanceDeliveryProvider.notifier).state = kmRounded;
  }

  Future<void> startLiveActivity() async {
    if (Platform.isIOS) {
      if (liveStarted || startingLive) return;

      startingLive = true;
      String street = widget.requestsModel.calleHasta!;
      String number = widget.requestsModel.numeroHasta!;
      String destination = '$street $number'.trim();
      try {
        final km = ref.read(distanceDeliveryProvider) ?? 0.0;

        await liveActivityService.start(
          status: 'On the way',
          distance: km,
          destination: destination,
        );

        liveStarted = true;
      } finally {
        startingLive = false;
      }
    }
  }

  bool isFinishedStatus(String status) {
    final s = status.toLowerCase();
    return s == 'finished' || s == 'delivered' || s == 'cancelled';
  }

  @override
  void dispose() {
    pollingTimer?.cancel();

    distanceSub?.close();
    requestsSub?.close();
    trackingSub?.close();

    mapController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
