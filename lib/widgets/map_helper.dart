import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
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

    List<LatLng> routePoints =
        await getRouteCoordinates(originLatLng, destinationLatLng, apiKey);

    return Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.indigo,
      width: 5,
      points: [originLatLng, destinationLatLng],
    );
  }

  static Future<LatLng> getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      debugPrint('error getting coordinates for address: $e');
    }
    return const LatLng(-32.944242, -60.650538);
  }

  static Future<List<LatLng>> getRouteCoordinates(
      LatLng origin, LatLng destination, String apiKey) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if ((data['routes'] as List).isNotEmpty) {
          String encodedPolyline =
              data['routes'][0]['overview_polyline']['points'];
          return decodePolyline(encodedPolyline);
        }
      }
    } catch (e) {
      print('error fetching route: $e');
    }
    return [];
  }

  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polylineCoordinates = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLat = ((result & 1) == 1 ? ~(result >> 1) : (result >> 1));
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int deltaLng = ((result & 1) == 1 ? ~(result >> 1) : (result >> 1));
      lng += deltaLng;

      polylineCoordinates.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polylineCoordinates;
  }
}
