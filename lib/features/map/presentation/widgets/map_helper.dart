import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapHelper {
  static Future<Set<Marker>> generateMarkers({
    required String origin,
    required String destination,
  }) async {
    Set<Marker> markers = {};

    if (origin.isNotEmpty) {
      LatLng originLatLng = await getLatLngFromAddress(origin);
      markers.add(
        Marker(
          markerId: const MarkerId('origin'),
          position: originLatLng,
          infoWindow: InfoWindow(title: "Origin: $origin"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    if (destination.isNotEmpty) {
      LatLng destinationLatLng = await getLatLngFromAddress(destination);
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: destinationLatLng,
          infoWindow: InfoWindow(title: 'Destination: $destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );
    }
    return markers;
  }

  static Future<Polyline> generatePolyline({
    required String origin,
    required String destination,
    required String apiKey,
  }) async {
    LatLng originLatLng = await getLatLngFromAddress(origin);
    LatLng destinationLatLng = await getLatLngFromAddress(destination);

    PolylinePoints polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: apiKey,
      request: PolylineRequest(
        origin: PointLatLng(originLatLng.latitude, originLatLng.longitude),
        destination: PointLatLng(
          destinationLatLng.latitude,
          destinationLatLng.longitude,
        ),
        mode: TravelMode.driving,
      ),
    );

    List<LatLng> polylineCoordinates =
        result.points
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList();

    return Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.indigo,
      width: 5,
      points:
          polylineCoordinates.isNotEmpty
              ? polylineCoordinates
              : [originLatLng, destinationLatLng],
    );
  }

  static Future<LatLng> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        print(
          'lat: ${locations.first.latitude}, long ${locations.first.longitude}',
        );
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      debugPrint('error getting coordinates for address: $e');
    }
    return const LatLng(-32.944242, -60.650538);
  }
}
