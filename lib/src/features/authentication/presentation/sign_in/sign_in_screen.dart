import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/or_sign_with_widget.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/providers_sign_in_button.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/custom_text_button.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_scrollable.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/email_password_sign_in_validators.dart';

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
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      // Add logic to sign user in here

      // call on the sign in function passed in the widget
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
    final state = false; // TODO add loading state
    return SafeArea(
      child: Scaffold(
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
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        onPressed: () => {}, // TODO add forgot password logic
                        text: context.loc.forgotPasswordButtonTitle,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: context.theme.primaryColor,
                          decorationThickness: 2.0,
                        ),
                      ),
                    ),

                    // sign in button
                    CTAButton(
                      buttonType: ButtonType.primary,
                      text: context.loc.signInButtonTitle,
                      isLoading: state, // TODO add loading state
                      onPressed: state ? null :  _submit, // TODO add sign in logic
                    ),

                    gapH24,
                    const OrSignWithWidget(),

                    // Sign in with Google Button
                    AuthProviderSignInButton(
                      text: context.loc.signInWithGoogleButtonTitle,
                      providerIcon: Image.asset(
                        'assets/images/google_logo.png',
                        height: Sizes.p32,
                        width: Sizes.p32,
                      ),
                      onPressed: () => {}, // TODO add sign in with google logic
                      isLoading: false, // TODO add loading state
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
