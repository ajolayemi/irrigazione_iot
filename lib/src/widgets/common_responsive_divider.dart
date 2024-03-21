import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class CommonResponsiveDivider extends StatelessWidget {
  const CommonResponsiveDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveCenter(
      padding: EdgeInsets.only(
        left: Sizes.p16,
        right: Sizes.p16,
      ),
      child: Divider(
        color: Colors.grey,
        thickness: 2,
      ),
    );
  }
}
