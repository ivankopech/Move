import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import './custom_textfield.dart';

class AddressInput extends StatefulWidget {
  final TextEditingController originAddressController;
  final TextEditingController destinationAddressController;

  const AddressInput({
    super.key,
    required this.originAddressController,
    required this.destinationAddressController,
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
  bool isTypingOrigin = false;
  late TextEditingController originController;
  late TextEditingController destinationController;

  @override
  void initState() {
    super.initState();
    loadEnv();
    originFocusNode = FocusNode();
    destinationFocusNode = FocusNode();

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
    const String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    final Uri uri = Uri.parse('$baseUrl?input=$input&key=$apiKey');

    try {
      final response = await Dio().get(uri.toString());

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          if (isOrigin) {
            originSuggestions =
                (data['predictions'] as List)
                    .map((item) => item['description'] as String)
                    .toList();
          } else {
            destinationSuggestions =
                (data['predictions'] as List)
                    .map((item) => item['description'] as String)
                    .toList();
          }
        });
      }
    } catch (e) {
      print('error fetching suggestions: $e');
    }
  }

  void onSuggestionTap(String address, bool isOrigin) {
    setState(() {
      if (isOrigin) {
        widget.originAddressController.text = address;
        originSuggestions.clear();
        widget.originAddressController.selection = TextSelection.fromPosition(
          const TextPosition(offset: 0),
        );
      } else {
        widget.destinationAddressController.text = address;
        destinationSuggestions.clear();
        widget.destinationAddressController.selection =
            TextSelection.fromPosition(const TextPosition(offset: 0));
      }
    });

    if (!isOrigin) {
      // Navigator.pop(context, {
      //   'origin': widget.originAddressController.text,
      //   'destination': widget.destinationAddressController.text,
      // });
      context.pop({
        'origin': originController.text,
        'destination': destinationController.text,
      });
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
