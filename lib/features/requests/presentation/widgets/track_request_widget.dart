import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../../../../common/widgets/generic_error_screen.dart';
import 'package:move/features/requests/presentation/providers/providers.dart';
import 'package:move/features/requests/presentation/providers/track_request_state_notifier_provider.dart';

class TrackRequestWidget extends ConsumerStatefulWidget {
  final int id;
  const TrackRequestWidget({super.key, required this.id});

  @override
  ConsumerState<TrackRequestWidget> createState() => _TrackRequestWidgetState();
}

class _TrackRequestWidgetState extends ConsumerState<TrackRequestWidget> {
  GoogleMapController? mapController;

  TextEditingController markerAddressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(trackRequestStateNotifierProvider.notifier)
          .trackRequest(widget.id);
    });
  }

  void onRetry() {
    ref
        .read(trackRequestStateNotifierProvider.notifier)
        .trackRequest(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final requestState = ref.watch(trackRequestStateNotifierProvider);
    return requestState.when(
      data: (request) {
        if (request!.latitude == null || request.longitude == null) {
          return GenericErrorScreen(onRetry: onRetry);
        }

        final LatLng requestPosition = LatLng(
          request.latitude!.toDouble(),
          request.longitude!.toDouble(),
        );

        final Set<Marker> marker = {
          Marker(
            markerId: const MarkerId('request'),
            position: requestPosition,
            infoWindow: const InfoWindow(title: 'request location'),
          ),
        };
        return Scaffold(
          body: SingleChildScrollView(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: requestPosition,
                zoom: 15,
              ),
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
        );
      },
      error: (error, stackTrace) => GenericErrorScreen(onRetry: onRetry),
      loading: () => const LoaderWidget(),
    );
  }
}
