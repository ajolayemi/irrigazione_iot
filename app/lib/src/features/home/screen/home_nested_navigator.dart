import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/breakpoints.dart';
import 'home_navigation_rail.dart';
import 'home_navigator_bar.dart';

// Check the following links for more details on house this type of navigation works:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
class HomeNestedNavigation extends StatelessWidget {
  const HomeNestedNavigation({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey<String>('home_nested_navigation'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < Breakpoint.bottomNavigationBar) {
        return HomeNavigationBar(
            body: navigationShell,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _goBranch);
      }

      return HomeNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch);
    });
  }
}
