import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/routing/app_router_paths.dart';
import 'package:trovo_app/src/core/theme/app_theme.dart';
import 'package:trovo_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trovo_app/src/features/auth/widgets/auth_input_field.dart';
import 'package:trovo_app/src/features/auth/widgets/auth_primary_button.dart';
import 'package:trovo_app/src/features/auth/widgets/auth_shell.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key, required this.email, this.debugCode});

  final String email;
  final int? debugCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: _NewPasswordView(email: email, debugCode: debugCode),
    );
  }
}

class _NewPasswordView extends StatefulWidget {
  const _NewPasswordView({required this.email, this.debugCode});

  final String email;
  final int? debugCode;

  @override
  State<_NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<_NewPasswordView> {
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.debugCode != null) {
      _codeController.text = widget.debugCode.toString();
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _codeController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (code.isEmpty) {
      _showMessage('Please enter the reset code.');
      return;
    }
    if (password.isEmpty || confirm.isEmpty) {
      _showMessage('Please enter and confirm your new password.');
      return;
    }
    if (password != confirm) {
      _showMessage('Passwords do not match.');
      return;
    }

    context.read<AuthCubit>().resetPassword(
      email: widget.email,
      code: code,
      newPassword: password,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          resetPasswordSuccess: (_) => context.go(AppRoutePaths.loginScreen),
          error: (message) => _showMessage(message),
        );
      },
      builder: (context, state) {
        final isSubmitting = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return AuthShell(
          showBackButton: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 122),
                const Text(
                  'Enter New Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepTeal,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your new password must be different from previously used password.',
                  style: TextStyle(fontSize: 16, height: 1.45),
                ),
                const SizedBox(height: 18),
                AuthInputField(
                  label: 'Reset Code',
                  hintText: 'Enter reset code',
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),
                AuthInputField(
                  label: 'Password',
                  hintText: 'Enter New Password',
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 14),
                AuthInputField(
                  label: 'Confirm Password',
                  hintText: 'Enter New Password',
                  controller: _confirmController,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                AuthPrimaryButton(
                  label: isSubmitting ? 'Submitting...' : 'Continue',
                  onPressed: _submit,
                  isEnabled: !isSubmitting,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
