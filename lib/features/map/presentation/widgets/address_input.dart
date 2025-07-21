import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:move/features/map/data/models/request_info.dart';
import 'package:move/features/map/presentation/providers/providers.dart';

import './custom_textfield.dart';

class AddressInput extends ConsumerStatefulWidget {
  final bool isOrigin;
  final Function(String) onSelected;
  final String? otherAddress;

  const AddressInput({
    super.key,
    required this.isOrigin,
    required this.onSelected,
    this.otherAddress,
  });

  @override
  ConsumerState<AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends ConsumerState<AddressInput> {
  late FocusNode originFocusNode;
  late FocusNode destinationFocusNode;
  List<String> suggestions = [];
  List<String> originSuggestions = [];
  List<String> destinationSuggestions = [];
  bool isOriginFocused = false;
  String apiKey = dotenv.env['API_KEY'] ?? '';
  bool isTypingOrigin = true;
  late TextEditingController originController;
  late TextEditingController destinationController;
  late FlutterGooglePlacesSdk places;
  LatLng? originLatLng;
  LatLng? destinationLatLng;

  @override
  void initState() {
    super.initState();
    loadEnv();

    originFocusNode = FocusNode();
    destinationFocusNode = FocusNode();

    places = FlutterGooglePlacesSdk(apiKey);

    originFocusNode.addListener(() {
      setState(() {
        isTypingOrigin = originFocusNode.hasFocus;
        if (!originFocusNode.hasFocus) originSuggestions.clear();
      });
    });

    destinationFocusNode.addListener(() {
      setState(() {
        isTypingOrigin =
            !destinationFocusNode.hasFocus ? false : isTypingOrigin;
        if (!destinationFocusNode.hasFocus) destinationSuggestions.clear();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra =
        GoRouterState.of(context).extra as Map<String, TextEditingController>;
    originController = extra['originController']!;
    destinationController = extra['destinationController']!;
  }

  Future<void> loadEnv() async {
    await dotenv.load();
    setState(() {
      apiKey = dotenv.env['API_KEY'] ?? '';
      places = FlutterGooglePlacesSdk(apiKey);
    });
  }

  @override
  void dispose() {
    originFocusNode.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  }

  Future<void> fetchSuggestions(String input, bool isOrigin) async {
    if (input.isEmpty) {
      setState(() {
        if (isOrigin) {
          originSuggestions.clear();
        } else {
          destinationSuggestions.clear();
        }
      });
      return;
    }

    final result = await places.findAutocompletePredictions(input);
    final suggestions =
        result.predictions.map((p) {
          final primaryText = p.primaryText;
          final secondaryText = p.secondaryText;
          return '$primaryText, $secondaryText';
        }).toList();

    setState(() {
      if (isOrigin) {
        originSuggestions = suggestions;
      } else {
        destinationSuggestions = suggestions;
      }
    });
  }

  Future<void> onSuggestionTap(String suggestion, bool isOrigin) async {
    final predictions = await places.findAutocompletePredictions(suggestion);
    if (predictions.predictions.isEmpty) return;

    final prediction = predictions.predictions.first;
    final details = await places.fetchPlace(
      prediction.placeId,
      fields: [
        PlaceField.AddressComponents,
        PlaceField.Name,
        PlaceField.Address,
      ],
    );

    final address = details.place?.address ?? prediction.primaryText;

    //parse address and latlng
    final fullAddressModel = await buildFullAddressModel(
      address,
      ref,
      isOrigin,
    );

    if (isOrigin) {
      ref.read(originAddressProvider.notifier).state = fullAddressModel;
    } else {
      ref.read(destinationAddressProvider.notifier).state = fullAddressModel;
    }

    setState(() {
      if (isOrigin) {
        originController.text = address;
        originController.selection = TextSelection.collapsed(offset: 0);
        originSuggestions.clear();
      } else {
        destinationController.text = address;
        destinationSuggestions.clear();
      }
    });

    if (originController.text.isNotEmpty &&
        destinationController.text.isNotEmpty) {
      context.pop({
        'origin': originController.text,
        'destination': destinationController.text,
      });
    }
  }

  void handleTap(bool isOrigin) {
    Future.microtask(() {
      if (mounted) {
        setState(() {
          isTypingOrigin = isOrigin;
        });
      }
    });
  }

  Future<AddressModel> buildFullAddressModel(
    String fullAddress,
    WidgetRef ref,
    bool isOrigin,
  ) async {
    final parts = fullAddress.split(',').map((e) => e.trim()).toList();

    if (parts.length < 4) {
      throw Exception('Formato de dirección no válido');
    }

    String street = '';
    String number = '';
    String postalCode = '';
    String city = '';
    String state = '';
    String country = '';
    double? lat;
    double? lng;

    if (parts[0].contains("PRF")) {
      final streetAndNumber = parts[1].split(' ');
      number = streetAndNumber.removeLast();
      street = streetAndNumber.join(' ');
      postalCode = parts[2].split(' ')[0];
      city = parts[2].substring(postalCode.length).trim();
      state = parts[3];
      country = parts[4];
    } else {
      final streetAndNumber = parts[0].split(' ');
      number = streetAndNumber.removeLast();
      street = streetAndNumber.join(' ');
      postalCode = parts[1].split(' ')[0];
      city = parts[1].substring(postalCode.length).trim();
      state = parts[2];
      country = parts[3];
    }

    final addressString =
        '$street $number, $postalCode $city, $state, $country';

    try {
      final locations = await locationFromAddress(addressString);
      if (locations.isNotEmpty) {
        lat = locations.first.latitude;
        lng = locations.first.longitude;
        if (isOrigin) {
          setState(() {
            originLatLng = LatLng(lat: lat!, lng: lng!);
          });
        } else {
          setState(() {
            destinationLatLng = LatLng(lat: lat!, lng: lng!);
          });
        }
      }
    } catch (e) {
      print('Error getting coordinates: $e');
    }

    if (originLatLng != null && destinationLatLng != null) {
      final double? rawDistance = await getDistance(
        originLatLng!.lat,
        originLatLng!.lng,
        destinationLatLng!.lat,
        destinationLatLng!.lng,
      );

      if (rawDistance != null) {
        print('la distancia es de: $rawDistance');
        ref.read(distanceProvider.notifier).state = Distance(
          distance: rawDistance,
        );
      } else {
        print('error');
      }
    }

    return AddressModel(
      street: street,
      number: number,
      postalCode: postalCode,
      city: city,
      state: state,
      country: country,
      latitude: lat?.toString() ?? '',
      longitude: lng?.toString() ?? '',
    );
  }

  Future<double?> getDistance(
    double originLat,
    double originLng,
    double destLat,
    double destLng,
  ) async {
    final url =
        Uri.https('maps.googleapis.com', '/maps/api/distancematrix/json', {
          'origins': '$originLat, $originLng',
          'destinations': '$destLat,$destLng',
          'key': apiKey,
        });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final distanceInMeters =
            data['rows'][0]['elements'][0]['distance']['value'];

        final distanceInKm = distanceInMeters / 1000.0;

        final truncatedDistance = (distanceInKm * 10).truncateToDouble() / 10;
        return truncatedDistance;
      } else {
        throw Exception('Error al obtener la distancia');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isTypingOrigin ? 'Pickup' : 'Drop off')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomTextField(
                controller: originController,
                focusNode: originFocusNode,
                icon: const Icon(Icons.arrow_upward_outlined),
                hintText: 'Enter origin location...',
                isOrigin: true,
                suggestions: originSuggestions,
                onSuggestionTap: onSuggestionTap,
                fetchSuggestions: fetchSuggestions,
                onTap: handleTap,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: destinationController,
                focusNode: destinationFocusNode,
                icon: const Icon(Icons.arrow_downward_outlined),
                hintText: 'Enter destination location...',
                isOrigin: false,
                suggestions: destinationSuggestions,
                onSuggestionTap: onSuggestionTap,
                fetchSuggestions: fetchSuggestions,
                onTap: (isOrigin) {
                  Future.microtask(() {
                    if (mounted) {
                      setState(() {
                        isTypingOrigin = isOrigin;
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
