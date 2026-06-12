import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/routing/app_router_paths.dart';
import 'package:trovo_app/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trovo_app/src/features/user/presentation/cubit/user_cubit.dart';
import 'package:trovo_app/src/features/progress/presentation/cubit/progress_cubit.dart';

const Color _kBg = Color(0xFFF2F2F2);
const Color _kBasis = Color(0xFF042F40);
const Color _kCard = Color(0xFFF6F3F2);
const Color _kAccent = Color(0xFFC8EFFF);

/// User profile page — header, identity card and a stats section.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => sl<UserCubit>()..loadProfile(),
        ),
        BlocProvider<ProgressCubit>(
          create: (_) => sl<ProgressCubit>()..load(),
        ),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _logout(BuildContext context) async {
    await sl<AuthCubit>().logout();
    if (context.mounted) context.go(AppRoutePaths.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            state.whenOrNull(
              actionSuccess: (_, message) => _showMessage(context, message),
              accountDeleted: (message) {
                _showMessage(context, message);
                context.go(AppRoutePaths.loginScreen);
              },
              error: (message) => _showMessage(context, message),
            );
          },
          builder: (context, state) {
            final profile = state.maybeWhen(
              loaded: (p) => p,
              actionInProgress: (p) => p,
              actionSuccess: (p, _) => p,
              orElse: () => context.read<UserCubit>().profile,
            );
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                24 + MediaQuery.viewPaddingOf(context).bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _IconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      _IconButton(
                        icon: Icons.settings,
                        onTap: () => _openSettings(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _IdentityCard(
                    name: isLoading
                        ? 'Loading…'
                        : (profile?.fullName ?? 'Trovo User'),
                    email: profile?.email ?? '',
                    avatar: profile?.avatar,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.91),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _ProfileRowCard(
                          icon: Icons.person_outline_rounded,
                          title: 'Account Info',
                          subtitle: 'Personal details & security',
                          trailing: const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0x99434842),
                            size: 22,
                          ),
                          onTap: () => _openSettings(context),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<ProgressCubit, ProgressState>(
                          builder: (context, state) {
                            final summary = state.maybeWhen(
                              loaded: (s, _) => s,
                              orElse: () => null,
                            );
                            return Row(
                              children: [
                                Expanded(
                                  child: _MiniStatCard(
                                    icon: Icons.local_fire_department_rounded,
                                    value: '${summary?.streak ?? 0}d',
                                    label: 'Streak',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _MiniStatCard(
                                    icon: Icons.assignment_turned_in_rounded,
                                    value: '${summary?.totalDiagnoses ?? 0}',
                                    label: 'Diagnoses',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline, color: _kBasis),
                title: const Text('Change Password'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _openChangePassword(context, userCubit);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: _kBasis),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _logout(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFF44336),
                ),
                title: const Text(
                  'Delete Account',
                  style: TextStyle(color: Color(0xFFF44336)),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _confirmDelete(context, userCubit);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _openChangePassword(BuildContext context, UserCubit userCubit) {
    final currentController = TextEditingController();
    final newController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current password',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final current = currentController.text.trim();
                final next = newController.text.trim();
                if (current.isEmpty || next.isEmpty) return;
                Navigator.of(dialogContext).pop();
                userCubit.changePassword(
                  currentPassword: current,
                  newPassword: next,
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, UserCubit userCubit) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'This will permanently delete your account and data. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                userCubit.deleteAccount();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Color(0xFFF44336)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: _kBasis, size: 22),
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({
    required this.name,
    required this.email,
    this.avatar,
  });
  final String name;
  final String email;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    final hasNetworkAvatar = avatar != null && avatar!.startsWith('http');
    return SizedBox(
      height: 170 + 62,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 62,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.91),
                border: Border.all(color: const Color(0xFFE5E5E5)),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Text(
                    name,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _kBasis,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withValues(alpha: 0.5),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 124,
              height: 124,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_kAccent, _kBasis],
                ),
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFFB5C8D1),
                backgroundImage: hasNetworkAvatar
                    ? NetworkImage(avatar!) as ImageProvider
                    : null,
                child: hasNetworkAvatar
                    ? null
                    : const Icon(
                        Icons.person,
                        size: 48,
                        color: _kBasis,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileRowCard extends StatelessWidget {
  const _ProfileRowCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _IconBadge(icon: icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _kBasis,
                      letterSpacing: 0.28,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0x99434842),
                      letterSpacing: 0.5,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _kBasis,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

class _ProgressStatsCard extends StatelessWidget {
  const _ProgressStatsCard();

  static const List<double> _bars = [0.40, 0.60, 0.30, 0.80, 0.50, 0.90, 1.0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const _IconBadge(icon: Icons.bar_chart_rounded),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress / Stats',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _kBasis,
                        letterSpacing: 0.28,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Your journey insights',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0x99434842),
                        letterSpacing: 0.5,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      color: _kBasis,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '7 DAY STREAK',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _kBasis,
                        letterSpacing: 0.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < _bars.length; i++) ...[
                  if (i != 0) const SizedBox(width: 4),
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: _bars[i],
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: i == _bars.length - 1 ? _kBasis : _kAccent,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kBasis, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF576674),
              height: 1.5,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF51606E),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
