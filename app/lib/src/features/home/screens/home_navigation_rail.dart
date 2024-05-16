import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

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
          labelType: NavigationRailLabelType.all,
          groupAlignment: 0,
          destinations: [
            NavigationRailDestination(
              icon: const Icon(Icons.home),
              selectedIcon: const Icon(Icons.home_filled),
              label: Text(context.loc.homePageTitle),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.list_alt),
              selectedIcon: const Icon(Icons.list_alt),
              label: Text(context.loc.collectorPageTitle),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.water),
              selectedIcon: const Icon(Icons.water),
              label: Text(context.loc.pumpPageTitle),
            ),
            NavigationRailDestination(
              icon: const Icon(Icons.category),
              selectedIcon: const Icon(Icons.category),
              label: Text(context.loc.sectorPageTitle),
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
