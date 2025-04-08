import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

class PlacesSuggestionHelper {
  late final FlutterGooglePlacesSdk places;

  PlacesSuggestionHelper(String apiKey)
    : places = FlutterGooglePlacesSdk(apiKey);

  Future<List<String>> fetchSuggestions(String input) async {
    if (input.isEmpty) return [];

    final result = await places.findAutocompletePredictions(input);
    return result.predictions.map((p) => p.fullText).toList();
  }
}
