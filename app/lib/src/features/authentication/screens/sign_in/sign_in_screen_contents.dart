import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/exceptions/app_exception.dart';
import 'package:irrigazione_iot/src/features/authentication/screens/sign_in/sign_in_controller.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/dont_have_an_account.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/forgot_password.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/password_visibility_icon_button.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/providers_sign_in_button.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/sliver_sign_in_cta.dart';
import 'package:irrigazione_iot/src/shared/providers/auth_providers.dart';
import 'package:irrigazione_iot/src/shared/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/shared/widgets/or_with_widget.dart';
import 'package:irrigazione_iot/src/shared/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_sliver_form.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';

// Widget to show the sign in form
class SignInScreenContents extends ConsumerStatefulWidget {
  const SignInScreenContents({
    super.key,
    this.onSignedIn,
  });

  final VoidCallback? onSignedIn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignInScreenContentsState();
}

class _SignInScreenContentsState extends ConsumerState<SignInScreenContents>
    with AppFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const passwordVisibilityKey = Key('signInPasswordVisibility');

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  var _submitted = false;

  // An error text to display when user logging failed due to wrong email or password
  String? _errorTextOnLoginFailed;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final loc = context.loc;
    _node.unfocus();
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(signInControllerProvider.notifier);
      final success = await controller.authenticateWithEmailAndPassword(
        _email,
        _password,
      );
      final hasUserNotFoundException =
          ref.read(signInControllerProvider).error is UserNotFoundException;

      // If user not found, invalidate password field
      if (hasUserNotFoundException) {
        _errorTextOnLoginFailed = loc.invalidCredentialsErrorText;
      }
      if (success) {
        widget.onSignedIn?.call();
      }
    }
  }

  Future<void> _submitWithGoogle() async {
    _node.unfocus();
    // Clear form fields
    _emailController.clear();
    _passwordController.clear();
    // set submitted state to false so that the error hints are not shown
    setState(() => _submitted = false);
    final controller = ref.read(signInControllerProvider.notifier);
    final success = await controller.authenticateWithGoogle();
    if (success) {
      widget.onSignedIn?.call();
    }
  }

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
      minLength: AppConstants.minPasswordLength,
    )) {
      _node.nextFocus();
    }
  }

  String? _passwordErrorText() {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
      minFieldLength: AppConstants.minPasswordLength,
      errorKey: getPasswordErrorKey(
        value: _password,
        minLength: AppConstants.minPasswordLength,
      ),
    );
  }

  void _onTapViewPassword() {
    final currentState = ref.read(showPasswordProvider);
    ref.read(showPasswordProvider.notifier).state = !currentState;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signInControllerProvider).isLoading;
    final loc = context.loc;
    final obscurePassword = !ref.watch(showPasswordProvider);
    final textTheme = context.textTheme;

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
                        loc.signInPageIntroductoryTitleText,
                        style: textTheme.titleLarge,
                      ),
                      gapH8,
                      Text(
                        loc.signInPageIntroductorySubtitleText,
                        style: textTheme.titleSmall,
                      ),
                      gapH32,
                      // email field
                      FormTitleAndField(
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
                      // Password Field
                      FormTitleAndField(
                        key: passwordKey,
                        fieldKey: passwordKey,
                        fieldTitle: loc.passwordFormFieldTitle,
                        fieldHintText: loc.passwordFormHint,
                        fieldController: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        errorText: _errorTextOnLoginFailed,
                        validator: (_) => _passwordErrorText(),
                        onEditingComplete: _passwordEditingComplete,
                        obscureText: obscurePassword,
                        suffixIcon: PasswordVisibilityIconButton(
                          key: passwordVisibilityKey,
                          isVisible: obscurePassword,
                          onPressed: _onTapViewPassword,
                        ),
                      ),
                      gapH4,
                      ForgotPassword(isLoading: isLoading),
                      gapH32,
                      // sign in button
                      SignInSliverCtaButton(onPressed: _submit),
                      gapH24,
                      OrWithWidget(orText: loc.orSignWithText),
                      // Sign in with Google Button
                      SliverAuthProviderSignInButton(
                        text: loc.signInWithGoogleButtonTitle,
                        providerIcon: Image.asset(
                          'assets/images/google_logo.png',
                          height: Sizes.p32,
                          width: Sizes.p32,
                        ),
                        onPressed: _submitWithGoogle,
                        buttonStateKey: SignInController.googleSignInStateKey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const DontHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
