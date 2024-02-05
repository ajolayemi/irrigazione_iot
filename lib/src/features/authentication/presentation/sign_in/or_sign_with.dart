import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class OrSignWithWidget extends StatefulWidget {
  const OrSignWithWidget({super.key});

  @override
  State<OrSignWithWidget> createState() => _OrSignInWithState();
}

class _OrSignInWithState extends State<OrSignWithWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: context.theme.dividerColor,
          ),
        ),
        gapH8,
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p8, vertical: Sizes.p16),
          child: Text(context.loc.orText,
              style: context.textTheme.titleMedium!.copyWith(
                color: context.theme.dividerColor,
              )),
        ),
        gapH8,
        Expanded(
          child: Container(
            height: 1,
            color: context.theme.dividerColor,
          ),
        ),
      ],
    );
  }
}
