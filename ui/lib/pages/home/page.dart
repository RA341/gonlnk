import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers.dart';

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlListAsync = ref.watch(urlListProvider);
    final addUrl = ref.read(addUrlProvider);

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
        data: (urls) => urls.isEmpty
            ? const Center(child: Text('Your URLs will appear here'))
            : ListView.builder(
                itemCount: urls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(urls[index]),
                    leading: const Icon(Icons.link),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
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
