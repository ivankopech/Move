import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:go_router/go_router.dart';

import './custom_textfield.dart';

class AddressInput extends StatefulWidget {
  final bool isOrigin;
  final TextEditingController controller;
  final Function(String) onSelected;
  final String? otherAddress;

  const AddressInput({
    super.key,
    required this.isOrigin,
    required this.controller,
    required this.onSelected,
    this.otherAddress,
  });

  @override
  State<AddressInput> createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
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

    setState(() {
      if (isOrigin) {
        originController.text = address;
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
                controller: widget.controller,
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
