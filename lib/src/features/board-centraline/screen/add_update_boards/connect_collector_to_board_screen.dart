import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_add_icon_button.dart';

class ConnectCollectorToBoardScreen extends ConsumerWidget {
  const ConnectCollectorToBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.connectCollectorToBoardPageTitle,
              actions: [
                CommonAddIconButton(
                  onPressed: () =>
                      context.pushNamed(AppRoute.addCollector.name),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
