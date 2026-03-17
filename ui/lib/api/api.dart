import 'package:connectrpc/connect.dart' as connect;
import 'package:connectrpc/protobuf.dart' as connect_proto;
import 'package:connectrpc/protocol/connect.dart' as connect_protocol;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../gen/library/v1/library.connect.client.dart';

import 'http_client_factory.dart'
    if (dart.library.io) 'http_client_io.dart'
    if (dart.library.js_interop) 'http_client_web.dart';

// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main');
});

// Provider for the server URL
class ServerUrlNotifier extends Notifier<String?> {
  @override
  String? build() {
    if (kIsWeb) {
      final uri = Uri.base;
      final origin = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      return origin;
    }
    
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString('server_url');
  }

  Future<void> setUrl(String url) async {
    if (kIsWeb) return;
    
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('server_url', url);
    state = url;
  }
}

final serverUrlProvider = NotifierProvider<ServerUrlNotifier, String?>(ServerUrlNotifier.new);

// Provider for the download path
class DownloadPathNotifier extends Notifier<String?> {
  @override
  String? build() {
    if (kIsWeb) return null;
    
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString('download_path');
  }

  Future<void> setPath(String path) async {
    if (kIsWeb) return;
    
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString('download_path', path);
    state = path;
  }
}

final downloadPathProvider = NotifierProvider<DownloadPathNotifier, String?>(DownloadPathNotifier.new);

// Provider for the connect.Transport
final transportProvider = Provider<connect.Transport>((ref) {
  final serverUrl = ref.watch(serverUrlProvider);
  
  final baseUrl = serverUrl ?? 'http://localhost:8080';
  final apiBaseUrl = baseUrl.endsWith('/') ? '${baseUrl}api' : '$baseUrl/api';

  return connect_protocol.Transport(
    baseUrl: apiBaseUrl,
    codec: const connect_proto.ProtoCodec(),
    httpClient: createClient(),
  );
});

// Provider for the LibraryServiceClient
final libraryClientProvider = Provider<LibraryServiceClient>((ref) {
  final transport = ref.watch(transportProvider);
  return LibraryServiceClient(transport);
});
