import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import '../../../../core/routing/app_router_paths.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/widgets/auth_primary_button.dart';
import '../../../auth/widgets/auth_shell.dart';
import '../cubit/auth_cubit.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, this.email = ''});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: _OtpView(email: email),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.email});

  final String email;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text.trim()).join();

  void _verify() {
    final code = _code;
    if (code.length < 6) {
      _showMessage('Please enter the 6 digit code.');
      return;
    }
    context.read<AuthCubit>().verifyEmail(email: widget.email, code: code);
  }

  void _resend() {
    if (widget.email.isEmpty) return;
    context.read<AuthCubit>().resendOtp(email: widget.email);
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
          verifyEmailSuccess: (_) =>
              context.go(AppRoutePaths.phoneUsageScreen),
          otpResentSuccess: (message) => _showMessage(message),
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
                  'Get Your Code',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.deepTeal,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please enter the 6 digit code that send to your email address.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 44,
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    const Text("If you don't receive code! "),
                    GestureDetector(
                      onTap: _resend,
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          color: AppTheme.deepTeal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                AuthPrimaryButton(
                  label: isSubmitting ? 'Verifying...' : 'Verify',
                  onPressed: _verify,
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
