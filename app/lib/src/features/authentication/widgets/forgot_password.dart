import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_text_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key, required this.isLoading});

  final bool isLoading;

  static const forgotPasswordButtonKey = Key('forgotPasswordButton');

  @override
  Widget build(BuildContext context) {
    return Align(
      key: forgotPasswordButtonKey,
      alignment: Alignment.centerRight,
      child: CustomTextButton(
        onPressed: () {}, // TODO add forgot password logic
        text: context.loc.forgotPasswordButtonTitle,
      ),
    );
  }
}
