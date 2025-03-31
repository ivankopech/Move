import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/config/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
