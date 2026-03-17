import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/foundation.dart';
import 'pages/home/page.dart';
import 'pages/settings/page.dart';
import 'providers.dart';
import 'api/api.dart';

class MainLayout extends HookConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverUrl = ref.watch(serverUrlProvider);
    final selectedIndex = ref.watch(navigationProvider);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    useEffect(() {
      if (!kIsWeb && serverUrl == null) {
        Future.microtask(() {
          if (context.mounted) {
            _showUrlSetupDialog(context, ref);
          }
        });
      }
      return null;
    }, [serverUrl]);

    final List<Widget> pages = [
      const MyHomePage(title: 'Gonlnk'),
      const SettingsPage(),
    ];

    final mainContent = IndexedStack(
      index: selectedIndex,
      children: pages,
    ).animate().fadeIn(duration: 800.ms, curve: Curves.easeOut);

    final navigationDestinations = [
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ];

    final navigationRailDestinations = [
      const NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Home'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: Text('Settings'),
      ),
    ];

    if (isMobile) {
      return Scaffold(
        body: mainContent,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            ref.read(navigationProvider.notifier).state = index;
          },
          destinations: navigationDestinations,
        ),
      );
    } else {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                ref.read(navigationProvider.notifier).state = index;
              },
              labelType: NavigationRailLabelType.all,
              destinations: navigationRailDestinations,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      );
    }
  }

  void _showUrlSetupDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: 'http://');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Server Configuration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please enter the server URL to connect to.'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                hintText: 'http://localhost:8080',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
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
