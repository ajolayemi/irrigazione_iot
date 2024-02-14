import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

// Widget to show the home navigation bar for mobile screens
class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar(
      {super.key,
      required this.body,
      required this.selectedIndex,
      required this.onDestinationSelected});

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: context.loc.homePageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: context.loc.settingsPageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.more_vert),
            label: context.loc.morePageTitle,
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
