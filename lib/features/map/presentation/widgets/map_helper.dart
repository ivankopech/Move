import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

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
      final originIcon = await createEmojiMarker('🏠');
      markers.add(
        Marker(
          markerId: const MarkerId('origin'),
          position: originLatLng,
          infoWindow: InfoWindow(title: "Origin: $origin"),
          icon: originIcon,
        ),
      );
    }
    if (destination.isNotEmpty) {
      LatLng destinationLatLng = await getLatLngFromAddress(destination);
      final destinationIcon = await createEmojiMarker('🏁');
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: destinationLatLng,
          infoWindow: InfoWindow(title: 'Destination: $destination'),
          icon: destinationIcon,
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
        debugPrint(
          'lat: ${locations.first.latitude}, long ${locations.first.longitude}',
        );
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      debugPrint('error getting coordinates for address: $e');
    }
    return const LatLng(-32.944242, -60.650538);
  }

  static Future<BitmapDescriptor> createEmojiMarker(String emoji) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(
      text: emoji,
      style: const TextStyle(fontSize: 30),
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(
      textPainter.width.toInt(),
      textPainter.height.toInt(),
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(uint8List);
  }

  static double degToRad(double deg) => deg * (math.pi / 180.0);

  static double haversineKm(LatLng a, LatLng b) {
    const r = 6371.0; // km
    final dLat = degToRad(b.latitude - a.latitude);
    final dLng = degToRad(b.longitude - a.longitude);

    final lat1 = degToRad(a.latitude);
    final lat2 = degToRad(b.latitude);

    final h =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLng / 2), 2);

    final c = 2 * math.atan2(math.sqrt(h), math.sqrt(1 - h));
    return r * c;
  }

  static double polylineDistanceKm(List<LatLng> points) {
    if (points.length < 2) return 0.0;
    double total = 0.0;
    for (int i = 0; i < points.length - 1; i++) {
      total += haversineKm(points[i], points[i + 1]);
    }
    return total;
  }
}
