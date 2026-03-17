import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../api/api.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverUrl = ref.watch(serverUrlProvider);
    final downloadPath = ref.watch(downloadPathProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dns),
            title: const Text('Server URL'),
            subtitle: Text(serverUrl ?? 'Not set'),
            trailing: kIsWeb ? null : const Icon(Icons.edit),
            onTap: kIsWeb
                ? null
                : () {
                    _showUrlEditDialog(context, ref, serverUrl);
                  },
          ),
          if (!kIsWeb) ...[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Download Path'),
              subtitle: Text(downloadPath ?? 'Not set'),
              trailing: const Icon(Icons.edit),
              onTap: () async {
                final selectedPath =
                    await FilePicker.platform.getDirectoryPath();
                if (selectedPath != null) {
                  ref.read(downloadPathProvider.notifier).setPath(selectedPath);
                }
              },
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Security'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showUrlEditDialog(
      BuildContext context, WidgetRef ref, String? currentUrl) {
    final controller = TextEditingController(text: currentUrl ?? 'http://');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Server URL'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Server URL',
            hintText: 'http://localhost:8080',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final url = controller.text.trim();
              if (url.isNotEmpty) {
                ref.read(serverUrlProvider.notifier).setUrl(url);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
