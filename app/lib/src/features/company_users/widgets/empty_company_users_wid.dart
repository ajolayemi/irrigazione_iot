import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/shared/widgets/common_add_icon_button.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_data_widget.dart';

/// A widget to display when there are no company users
class EmptyCompanyUsers extends StatelessWidget {
  const EmptyCompanyUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return SliverEmptyDataWidget(
      message: loc.noUsersConnectedWithCompany,
      buttonText: loc.addNewButtonLabel,
      onPressed: () => CommonAddIconButton(
        onPressed: () => context.pushNamed(
          AppRoute.addCompanyUser.name,
        ),
      ),
    );
  }
}
