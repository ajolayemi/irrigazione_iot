import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/constants/app_constants.dart';
import 'package:irrigazione_iot/src/features/authentication/screen/sign_up/sign_up_controller.dart';
import 'package:irrigazione_iot/src/providers/auth_providers.dart';
import 'package:irrigazione_iot/src/utils/app_form_error_texts_extension.dart';
import 'package:irrigazione_iot/src/utils/app_form_validators.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;

  // * Keys for testing using find.byKey()
  static const emailKey = Key('signUpEmail');
  static const passwordKey = Key('signUpPassword');
  static const confirmPasswordKey = Key('signUpConfirmPassword');

  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

    return context.getLocalizedDependentErrorText(
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

  @override
  Widget build(BuildContext context) {
    final isSigningUp = ref.watch(signUpControllerProvider).isLoading;
    final loc = context.loc;
    final obscurePassword = !ref.watch(showPasswordProvider);
    final obscureConfirmPassword = !ref.watch(showConfirmPasswordProvider);
    return Container();
  }
}
