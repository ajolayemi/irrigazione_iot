import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/constants/breakpoints.dart';
import 'package:irrigazione_iot/src/features/authentication/role_management/data/role_management_repository.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_text_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// A place holder widget to tell user that there is no data to show.
/// It presents a text button to allow user to perform a specific action.
class EmptyDataWidget extends ConsumerWidget {
  const EmptyDataWidget({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit =
        ref.watch(userCanCreateStreamProvider).valueOrNull ?? false;
    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      padding: const EdgeInsets.all(Sizes.p8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Visibility(
            visible: canEdit,
            child: CustomTextButton(
              text: buttonText,
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}

class SliverEmptyDataWidget extends StatelessWidget {
  const SliverEmptyDataWidget(
      {super.key,
      required this.message,
      required this.buttonText,
      required this.onPressed});

  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: EmptyDataWidget(
        message: message,
        buttonText: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}
