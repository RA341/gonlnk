import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'pages/home/page.dart';
import 'pages/settings/page.dart';
import 'providers.dart';

class MainLayout extends HookConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

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
}
