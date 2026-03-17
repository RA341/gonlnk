import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../api/api.dart';
import '../../gen/library/v1/library.pb.dart' as libraryv1library;

// FutureProvider for fetching the URL list
final urlListProvider = FutureProvider<List<libraryv1library.Link>>((ref) async {
  final client = ref.watch(libraryClientProvider);
  
  const maxRetries = 3;
  int retryCount = 0;
  
  while (true) {
    try {
      final response = await client
          .list(libraryv1library.ListRequest())
          .timeout(const Duration(seconds: 10));
      return response.links;
    } catch (e) {
      retryCount++;
      if (retryCount >= maxRetries) {
        rethrow;
      }
      // Exponential backoff or simple delay
      await Future.delayed(Duration(seconds: retryCount));
    }
  }
});

// Provider that provides the URL addition logic
final addUrlProvider = Provider((ref) {
  return (String url) async {
    final client = ref.read(libraryClientProvider);
    await client.add(libraryv1library.AddRequest(link: [url]));
    // After successful addition, refresh the list
    ref.invalidate(urlListProvider);
  };
});

// Provider that provides the URL retry logic
final retryActionProvider = Provider((ref) {
  return (libraryv1library.Link link) async {
    final client = ref.read(libraryClientProvider);
    await client.retry(libraryv1library.RetryRequest(link: link));
    // After successful retry request, refresh the list
    ref.invalidate(urlListProvider);
  };
});
