import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/or_sign_with_widget.dart';
import 'package:irrigazione_iot/src/features/authentication/presentation/sign_in/providers_sign_in_button.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/widgets/custom_text_button.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/responsive_scrollable.dart';

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

class _SignInContentsState extends ConsumerState<SignInScreen> {
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

  @override
  Widget build(BuildContext context) {
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
                      validator: (_) => '', // TODO add email validation
                      inputFormatters: [], // TODO add email input formatters
                      onEditingComplete: () =>
                          {}, // TODO add email onEditingComplete,
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
                      validator: (_) => '', // TODO add password validation
                      inputFormatters: [], // TODO add password input formatters
                      onEditingComplete: () =>
                          {}, // TODO add password onEditingComplete,
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
                      onPressed: _submit,
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
