import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class MorePageItemListTile extends StatelessWidget {
  const MorePageItemListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.leadingIcon,
  });

  final String title;
  final VoidCallback onTap;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        padding: const EdgeInsets.only(
          left: Sizes.p16,
          right: Sizes.p16,
        ),
        child: ListTile(
          title: Text(title),
          leading: Icon( leadingIcon),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
