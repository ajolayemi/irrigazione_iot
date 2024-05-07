import 'package:flutter/widgets.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions/extensions.dart';

class OrWithWidget extends StatelessWidget {
  const OrWithWidget({
    super.key,
    required this.orText,
  });

  final String orText;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final dividerColor = theme.dividerColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: dividerColor,
          ),
        ),
        gapH8,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p8,
            vertical: Sizes.p16,
          ),
          child: Text(
            orText,
            style: textTheme.titleMedium!.copyWith(
              color: dividerColor,
            ),
          ),
        ),
        gapH8,
        Expanded(
          child: Container(
            height: 1,
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
