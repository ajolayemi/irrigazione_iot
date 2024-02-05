import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/primary_button.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

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
        body: ResponsiveCenter(
          child: FocusScope(
            node: _node,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

                  // Sign In Button
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Sizes.p16,
                      left: Sizes.p16,
                    ),
                    child: CTAButton(
                      buttonType: ButtonType.primary,
                      text: context.loc.signInButtonTitle,
                      onPressed: _submit,
                    ),
                  ),

                  gapH24,
                  // Sign in with Google Button
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Sizes.p16,
                      left: Sizes.p16,
                    ),
                    child: CTAButton(
                      buttonType: ButtonType.secondary,
                      text: context.loc.signInWithGoogleButtonTitle,
                      onPressed: () => {}, // TODO add sign in with google logic
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
