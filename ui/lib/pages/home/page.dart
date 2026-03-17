import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'providers.dart';
import '../../api/api.dart';
import '../../gen/library/v1/library.pb.dart' as libraryv1library;

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  Future<void> _downloadFile(
    BuildContext context,
    WidgetRef ref,
    libraryv1library.Link link,
    String serverUrl,
  ) async {
    if (kIsWeb) {
      final baseUrl = serverUrl.endsWith('/')
          ? serverUrl.substring(0, serverUrl.length - 1)
          : serverUrl;
      final downloadUrl = Uri.parse('$baseUrl/api/files/serve/${link.id}');
      if (!await launchUrl(downloadUrl, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $downloadUrl')),
          );
        }
      }
      return;
    }

    String? downloadPath = ref.read(downloadPathProvider);

    if (downloadPath == null || downloadPath.isEmpty) {
      final selectedPath = await FilePicker.platform.getDirectoryPath();
      if (selectedPath == null) return;
      await ref.read(downloadPathProvider.notifier).setPath(selectedPath);
      downloadPath = selectedPath;
    }

    final baseUrl = serverUrl.endsWith('/')
        ? serverUrl.substring(0, serverUrl.length - 1)
        : serverUrl;
    final downloadUrl = Uri.parse('$baseUrl/api/files/serve/${link.id}');

    try {
      final response = await http.get(downloadUrl);
      if (response.statusCode == 200) {
        final fileName = link.title.isNotEmpty
            ? link.title
            : p.basename(link.url.isNotEmpty ? link.url : 'downloaded_file');
        
        final safeFileName = fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
        final file = File(p.join(downloadPath, safeFileName));
        await file.writeAsBytes(response.bodyBytes);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File saved to ${file.path}')),
          );
        }
      } else {
        throw Exception('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error downloading file: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlListAsync = ref.watch(urlListProvider);
    final addUrl = ref.read(addUrlProvider);
    final retryAction = ref.read(retryActionProvider);
    final serverUrl = ref.watch(serverUrlProvider) ?? 'http://localhost:8080';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(urlListProvider),
            tooltip: 'Refresh List',
          ),
        ],
      ),
      body: urlListAsync.when(
        data: (links) => links.isEmpty
            ? const Center(child: Text('Your URLs will appear here'))
            : ListView.builder(
                itemCount: links.length,
                itemBuilder: (context, index) {
                  final libraryv1library.Link link = links[index];
                  return ListTile(
                    title: Text(link.title.isNotEmpty ? link.title : link.url),
                    subtitle: link.title.isNotEmpty ? Text(link.url) : null,
                    leading: const Icon(Icons.link),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(link.status),
                        if (link.status.toLowerCase() == 'complete')
                          IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () =>
                                _downloadFile(context, ref, link, serverUrl),
                            tooltip: 'Download',
                          ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () => retryAction(link),
                          tooltip: 'Retry',
                        ),
                      ],
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $err'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(urlListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUrlDialog(context, ref, addUrl),
        tooltip: 'Add URL',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddUrlDialog(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function(String) onAdd,
  ) {
    showDialog(
      context: context,
      builder: (context) => _AddUrlDialog(onAdd: onAdd),
    );
  }
}

class _AddUrlDialog extends HookConsumerWidget {
  final Future<void> Function(String) onAdd;

  const _AddUrlDialog({required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    Future<void> pasteFromClipboard() async {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data?.text != null) {
        controller.text = data!.text!;
      }
    }

    return AlertDialog(
      title: const Text('Add New URL'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Enter URL',
              hintText: 'https://example.com',
              suffixIcon: IconButton(
                icon: const Icon(Icons.content_paste),
                onPressed: pasteFromClipboard,
                tooltip: 'Paste from clipboard',
              ),
            ),
            keyboardType: TextInputType.url,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final url = controller.text;
            if (url.isNotEmpty) {
              await onAdd(url);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
