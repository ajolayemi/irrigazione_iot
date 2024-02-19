import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class HomeNavigationRail extends StatelessWidget {
  const HomeNavigationRail(
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
        body: Row(
      children: [
        NavigationRail(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          labelType: NavigationRailLabelType.selected,
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.home),
              selectedIcon: const Icon(Icons.home_filled),
              label: Text(context.loc.homePageTitle),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.settings),
              selectedIcon: const Icon(Icons.settings),
              label: Text(context.loc.settingsPageTitle),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.more_horiz),
              selectedIcon: const Icon(Icons.more_horiz),
              label: Text(context.loc.morePageTitle),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: body),
      ],
    ));
  }
}
