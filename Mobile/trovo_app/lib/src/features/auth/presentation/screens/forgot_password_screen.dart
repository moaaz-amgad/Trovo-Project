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

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _emailController = TextEditingController();
  String? _emailError;

  static final RegExp _emailPattern = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    if (!_emailPattern.hasMatch(email)) {
      setState(() => _emailError = 'Please enter a valid email address');
      return;
    }
    context.read<AuthCubit>().forgotPassword(email: email);
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
          forgotPasswordSuccess: (email, _) => context.push(
            '${AppRoutePaths.resetPasswordScreen}?email=$email',
          ),
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
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepTeal,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter your registered email below',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 18),
                AuthInputField(
                  label: 'Email',
                  hintText: 'Write Your Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  errorText: _emailError,
                  onChanged: (_) {
                    if (_emailError != null) {
                      setState(() => _emailError = null);
                    }
                  },
                ),
                const SizedBox(height: 24),
                AuthPrimaryButton(
                  label: isSubmitting ? 'Submitting...' : 'Submit',
                  onPressed: _submit,
                  isEnabled: !isSubmitting,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Remember the password? '),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () =>
                          context.go(AppRoutePaths.loginScreen),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: AppTheme.deepTeal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
