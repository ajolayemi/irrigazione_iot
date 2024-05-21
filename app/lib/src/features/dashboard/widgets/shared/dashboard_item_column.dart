import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class DashboardItemColumn extends StatelessWidget {
  const DashboardItemColumn({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge,
        ),
        gapH8,
        child,
      ],
    );
  }
}
