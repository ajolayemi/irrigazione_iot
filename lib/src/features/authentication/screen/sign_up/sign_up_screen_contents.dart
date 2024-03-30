import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/already_have_an_account.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/password_visibility_icon_button.dart';
import 'package:irrigazione_iot/src/features/authentication/widgets/sliver_sign_up_cta.dart';
import 'package:irrigazione_iot/src/providers/auth_providers.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/form_title_and_field.dart';
import 'package:irrigazione_iot/src/widgets/padded_safe_area.dart';
import 'package:irrigazione_iot/src/widgets/responsive_sliver_form.dart';

class SignUpScreenContents extends ConsumerStatefulWidget {
  const SignUpScreenContents({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpScreenContentsState();
}

class _SignUpScreenContentsState extends ConsumerState<SignUpScreenContents>
    with AppFormValidators {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String get _name => _nameController.text;
  String get _surname => _surnameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;

  // * Keys for testing using find.byKey()
  static const nameKey = Key('signUpName');
  static const surnameKey = Key('signUpSurname');
  static const emailKey = Key('signUpEmail');
  static const passwordKey = Key('signUpPassword');
  static const confirmPasswordKey = Key('signUpConfirmPassword');
  static const passwordVisibilityKey = Key('signUpPasswordVisibility');
  static const confirmPasswordVisibilityKey =
      Key('signUpConfirmPasswordVisibility');

  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nonEmptyFieldsEditingComplete(String value) {
    if (canSubmitNonEmptyFields(value: value)) {
      _node.nextFocus();
    }
  }

  String? _nonEmptyFieldsErrorText(String value) {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
      errorKey: getNonEmptyFieldsErrorKey(value: value),
    );
  }

  void _emailEditingComplete({
    required List<String?> existingEmails,
  }) {
    if (canSubmitEmail(
      value: _email,
      mailsToCompareAgainst: existingEmails,
    )) {
      _node.nextFocus();
    }
  }

  String? _emailErrorText({
    required List<String?> existingEmails,
  }) {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
        errorKey: getEmailErrorKey(
      value: _email,
      mailsToCompareAgainst: existingEmails,
    ));
  }

  void _passwordEditingComplete() {
    if (canSubmitPassword(
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

  void _confirmPasswordEditingComplete() {
    if (canSubmitConfirmPassword(
      password: _password,
      confirmPassword: _confirmPassword,
    )) {
      _node.unfocus();
    }
  }

  String? _confirmPasswordErrorText() {
    if (!_submitted) return null;
    return context.getLocalizedErrorText(
      errorKey: getConfirmPasswordErrorKey(
        password: _password,
        confirmPassword: _confirmPassword,
      ),
    );
  }

  void _onTapViewPassword() {
    final currentState = ref.read(showPasswordProvider);
    ref.read(showPasswordProvider.notifier).state = !currentState;
  }

  void _onTapViewConfirmPassword() {
    final currentState = ref.read(showConfirmPasswordProvider);
    ref.read(showConfirmPasswordProvider.notifier).state = !currentState;
  }

  Future<void> _signUp() async {
    _node.unfocus();
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      print('User can sign up');
    } else {
      print('User cannot sign up');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final obscurePassword = !ref.watch(showPasswordProvider);
    final obscureConfirmPassword = !ref.watch(showConfirmPasswordProvider);
    return GestureDetector(
      onTap: _node.unfocus,
      child: PaddedSafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            gapH64,
            Expanded(
              child: CustomScrollView(
                slivers: [
                  ResponsiveSliverForm(
                    node: _node,
                    formKey: _formKey,
                    children: [
                      gapH64,
                      // name field
                      FormTitleAndField(
                        fieldKey: nameKey,
                        fieldTitle: loc.nameFormFieldTitle,
                        fieldHintText: loc.nameFormHint,
                        fieldController: _nameController,
                        keyboardType: TextInputType.name,
                        validator: (_) => _nonEmptyFieldsErrorText(_name),
                        onEditingComplete: () =>
                            _nonEmptyFieldsEditingComplete(_name),
                      ),
                      gapH16,
                      // surname field
                      FormTitleAndField(
                        fieldKey: surnameKey,
                        fieldTitle: loc.surnameFormFieldTitle,
                        fieldHintText: loc.surnameFormHint,
                        fieldController: _surnameController,
                        keyboardType: TextInputType.name,
                        validator: (_) => _nonEmptyFieldsErrorText(_surname),
                        onEditingComplete: () =>
                            _nonEmptyFieldsEditingComplete(_surname),
                      ),
                      gapH16,
                      // email field
                      FormTitleAndField(
                        fieldKey: emailKey,
                        fieldTitle: loc.emailFormFieldTitle,
                        fieldHintText: loc.emailFormHint,
                        fieldController: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (_) => _emailErrorText(
                            existingEmails: []), // TODO: Add existing emails
                        onEditingComplete: () => _emailEditingComplete(
                          existingEmails: [], // TODO: Add existing emails
                        ),
                      ),
                      gapH16,
                      // password field
                      FormTitleAndField(
                          fieldKey: passwordKey,
                          fieldTitle: loc.passwordFormFieldTitle,
                          fieldHintText: loc.passwordFormHint,
                          fieldController: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscurePassword,
                          validator: (_) => _passwordErrorText(),
                          onEditingComplete: _passwordEditingComplete,
                          suffixIcon: PasswordVisibilityIconButton(
                            key: passwordVisibilityKey,
                            isVisible: obscurePassword,
                            onPressed: _onTapViewPassword,
                          )),
                      gapH16,
                      // confirm password field
                      FormTitleAndField(
                        fieldKey: confirmPasswordKey,
                        fieldTitle: loc.confirmPasswordFormFieldTitle,
                        fieldHintText: loc.confirmPasswordFormHint,
                        fieldController: _confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureConfirmPassword,
                        validator: (_) => _confirmPasswordErrorText(),
                        onEditingComplete: _confirmPasswordEditingComplete,
                        suffixIcon: PasswordVisibilityIconButton(
                          key: confirmPasswordVisibilityKey,
                          isVisible: obscureConfirmPassword,
                          onPressed: _onTapViewConfirmPassword,
                        ),
                      ),

                      gapH32,
                      // sign up button
                      SignUpSliverCtaButton(
                        onPressed: _signUp,
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Already have an account? Sign in
            const AlreadyHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
