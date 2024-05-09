import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/features/more/widgets/more_page_item_list_tile.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class CompanyUsersMoreOptionItem extends ConsumerWidget {
  const CompanyUsersMoreOptionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    return MorePageItemListTile(
      title: loc.companyUsersMenuTitle,
      onTap: () => context.pushNamed(
        AppRoute.companyUsers.name,
      ),
      leadingIcon: Icons.people,
    );
  }
}
