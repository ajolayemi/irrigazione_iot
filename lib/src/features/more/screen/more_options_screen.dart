import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/more/widgets/more_page_item_list_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_responsive_divider.dart';

class MoreOptionsScreen extends StatelessWidget {
  const MoreOptionsScreen({super.key});

  void _showNotImplemented(BuildContext context) {
    showNotImplementedAlertDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(title: loc.morePageTitle),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                MorePageItemListTile(
                  title: loc.iotBoardsMenuTitle,
                  onTap: () => _showNotImplemented(context),
                  leadingIcon: Icons.device_hub,
                ),
                const CommonResponsiveDivider(),
                MorePageItemListTile(
                    title: loc.profilePageTitle,
                    onTap: () => _showNotImplemented(context),
                    leadingIcon: Icons.person),
                MorePageItemListTile(
                  title: loc.settingsMenuTitle,
                  onTap: () => _showNotImplemented(context),
                  leadingIcon: Icons.settings,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
