import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';
import 'package:irrigazione_iot/src/widgets/common_add_icon_button.dart';

/// Displays a list of boards, i.e centraline in italian.
class BoardsListScreen extends ConsumerWidget {
  const BoardsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          AppSliverBar(
            title: loc.iotBoardsMenuTitle,
            actions: [
              CommonAddIconButton(
                onPressed: () => showNotImplementedAlertDialog(
                  context: context,
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}