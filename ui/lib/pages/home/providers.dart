import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// FutureProvider for fetching the URL list
final urlListProvider = FutureProvider<List<String>>((ref) async {
  // Stub for API fetch
  await Future.delayed(const Duration(seconds: 1));
  return [
    'https://flutter.dev',
    'https://riverpod.dev',
  ];
});

// Provider that provides the URL addition logic (API stub)
final addUrlProvider = Provider((ref) {
  return (String url) async {
    // Stub for API POST
    debugPrint('API CALL: Adding URL: $url');
    await Future.delayed(const Duration(milliseconds: 500));
    // After successful addition, refresh the list
    ref.invalidate(urlListProvider);
  };
});
