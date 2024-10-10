import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/routes/routes_enums.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/password_visibility_icon_button.dart';
import 'package:irrigazione_iot/src/features/weenat/controllers/weenat_auth_controller.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_auth_payload.dart';
import 'package:irrigazione_iot/src/shared/providers/auth_providers.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';

class WeenatAuthScreenContents extends ConsumerStatefulWidget {
  const WeenatAuthScreenContents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WeenatAuthScreenContentsState();
}

class _WeenatAuthScreenContentsState
    extends ConsumerState<WeenatAuthScreenContents> with AppFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  // * Keys for testing using find.byKey()
  static const emailKey = Key('weenat-email');
  static const passwordKey = Key('weenat-password');
  static const passwordVisibilityKey = Key('weenat-signInPasswordVisibility');

  bool _submitted = false;

  void _emailEditingComplete() {
    if (canSubmitEmail(value: _email)) {
      _node.nextFocus();
    }
  }

  String? _emailErrorText() {
    if (!_submitted) return null;

    return context.getLocalizedErrorText(
      errorKey: getEmailErrorKey(value: _email),
    );
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(value: _email)) {
      _node.previousFocus();
    }
    if (!canSubmitPassword(
      value: _password,
      minLength: 1,
      validateJustEmpty: true,
    )) {
      _node.nextFocus();
    }
  }

  String? _passwordErrorText() {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
      minFieldLength: 1,
      errorKey: getPasswordErrorKey(
        value: _password,
        minLength: 1,
        validateJustEmpty: true,
      ),
    );
  }

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);
    if (_formKey.currentState?.validate() == true) {
      final payload = WeenatAuthPayload(
        email: _email,
        password: _password,
      );
      final success = await ref
          .read(
            weenatAuthControllerProvider.notifier,
          )
          .authWeenat(payload: payload);
      if (success && mounted) {
        context.pushReplacementNamed(AppRoute.weenatMap.name);
      }
    }
  }

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    final obscurePassword = !ref.watch(showPasswordProvider);
    final isLoading = ref.watch(weenatAuthControllerProvider).isLoading;
    return GestureDetector(
      onTap: _node.unfocus,
      child: PaddedSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  ResponsiveSliverForm(
                    node: _node,
                    formKey: _formKey,
                    children: [
                      gapH32,
                      Text(
                        loc.weenatAuthScreenIntroductoryText,
                        style: textTheme.titleLarge,
                      ),
                      gapH32,

                      // email field
                      FormTitleAndField(
                        enabled: !isLoading,
                        key: emailKey,
                        fieldKey: emailKey,
                        fieldTitle: loc.emailFormFieldTitle,
                        fieldHintText: loc.emailFormHint,
                        fieldController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (_) => _emailErrorText(),
                        inputFormatters: <TextInputFormatter>[
                          ValidatorInputFormatter(
                            editingValidator: EmailEditingRegexValidator(),
                          ),
                        ],
                        onEditingComplete: _emailEditingComplete,
                      ),
                      gapH24,
                      // Password field
                      FormTitleAndField(
                        key: passwordKey,
                        enabled: !isLoading,
                        fieldKey: passwordKey,
                        fieldTitle: loc.passwordFormFieldTitle,
                        fieldHintText: loc.passwordFormHint,
                        fieldController: _passwordController,
                        obscureText: obscurePassword,
                        validator: (_) => _passwordErrorText(),
                        onEditingComplete: _passwordEditingComplete,
                        suffixIcon: PasswordVisibilityIconButton(
                          key: passwordVisibilityKey,
                          isVisible: obscurePassword,
                          onPressed: () {
                            ref
                                .read(showPasswordProvider.notifier)
                                .update((state) => !state);
                          },
                        ),
                      ),
                      gapH64,
                      SliverCTAButton(
                        text: loc.weenatSignInCta,
                        buttonType: ButtonType.primary,
                        onPressed: _submit,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
