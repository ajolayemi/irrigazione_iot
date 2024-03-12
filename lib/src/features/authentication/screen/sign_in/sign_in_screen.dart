import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/or_sign_with_widget.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/providers_sign_in_button.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/sign_in_controller.dart';
import 'package:irrigazione_iot/src/utils/string_validators.dart';
import 'package:irrigazione_iot/src/utils/async_value_ui.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/custom_text_button.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_scrollable.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_in/email_password_sign_in_validators.dart';

// Widget to show the sign in form
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({
    super.key,
    this.onSignedIn,
  });

  final VoidCallback? onSignedIn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInContentsState();
}

class _SignInContentsState extends ConsumerState<SignInScreen>
    with EmailAndPasswordValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const signInButtonKey = Key('signInButton');
  static const signInWithGoogleButtonKey = Key('signInWithGoogleButton');
  static const forgotPasswordButtonKey = Key('forgotPasswordButton');

  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    _node.unfocus();
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(signInControllerProvider.notifier);
      final success = await controller.authenticateWithEmailAndPassword(
        email,
        password,
      );
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
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to controller state for when error occurs
    ref.listen(
      signInControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInControllerProvider);
    return Scaffold(
      body: ResponsiveScrollable(
        child: FocusScope(
          node: _node,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapH64,
                  // email field
                  FormTitleAndField(
                    fieldKey: emailKey,
                    fieldTitle: context.loc.emailFormFieldTitle,
                    fieldHintText: context.loc.emailFormHint,
                    fieldController: _emailController,
                    autoCorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (email) => !_submitted
                        ? null
                        : emailErrorText(
                            email ?? '',
                            context,
                          ),
                    inputFormatters: <TextInputFormatter>[
                      ValidatorInputFormatter(
                        editingValidator: EmailEditingRegexValidator(),
                      ),
                    ],
                    onEditingComplete: _emailEditingComplete,
                    keyboardAppearance: Brightness.light,
                  ),
                  gapH24,
                  // Password Field
                  FormTitleAndField(
                    key: passwordKey,
                    fieldKey: emailKey,
                    fieldTitle: context.loc.passwordFormFieldTitle,
                    fieldHintText: context.loc.passwordFormHint,
                    fieldController: _passwordController,
                    autoCorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (password) => !_submitted
                        ? null
                        : passwordErrorText(
                            password ?? '',
                            context,
                          ),
                    onEditingComplete: _passwordEditingComplete,
                    keyboardAppearance: Brightness.light,
                    obscureText: true,
                  ),

                  // Forgot password button
                  Align(
                    key: forgotPasswordButtonKey,
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      onPressed: state.isLoading
                          ? null
                          : () => {}, // TODO add forgot password logic
                      text: context.loc.forgotPasswordButtonTitle,
                    ),
                  ),

                  // If state is loading, replace the sign in section with a circular progress indicator
                  if (state.isLoading) ...[
                    gapH24,
                    const Center(child: CircularProgressIndicator()),
                  ] else ...[
                    // sign in button
                    CTAButton(
                      key: signInButtonKey,
                      buttonType: ButtonType.primary,
                      text: context.loc.signInButtonTitle,
                      isLoading: state.isLoading,
                      onPressed: state.isLoading ? null : _submit,
                    ),

                    gapH24,
                    const OrSignWithWidget(),

                    // Sign in with Google Button
                    AuthProviderSignInButton(
                      key: signInWithGoogleButtonKey,
                      text: context.loc.signInWithGoogleButtonTitle,
                      providerIcon: Image.asset(
                        'assets/images/google_logo.png',
                        height: Sizes.p32,
                        width: Sizes.p32,
                      ),
                      onPressed: state.isLoading ? null : _submitWithGoogle,
                      isLoading: state.isLoading,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
