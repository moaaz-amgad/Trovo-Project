import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/services/hive_cache_service.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';
import 'package:trovo_app/src/core/theming/app_text_styles.dart';
import 'package:trovo_app/src/core/widgets/gradient_button.dart';
import 'package:trovo_app/src/features/phone_usage/data/models/phone_usage_data.dart';
import 'package:trovo_app/src/features/phone_usage/data/models/phone_usage_metrics.dart';
import 'package:trovo_app/src/features/phone_usage/presentation/cubit/phone_usage_cubit.dart';

enum _PhoneUsageAction { collect, submit }

class PhoneUsageScreen extends StatelessWidget {
  const PhoneUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneUsageCubit>(
      create: (_) => sl<PhoneUsageCubit>(),
      child: const _PhoneUsageView(),
    );
  }
}

class _PhoneUsageView extends StatefulWidget {
  const _PhoneUsageView();

  @override
  State<_PhoneUsageView> createState() => _PhoneUsageViewState();
}

class _PhoneUsageViewState extends State<_PhoneUsageView> {
  static const _consentCacheKey = 'phone_usage_consent';
  static const _latestMetricsCacheKey = 'phone_usage_latest_metrics';

  final _cacheService = HiveCacheService();

  final _userIdController = TextEditingController();
  final _diagnosisIdController = TextEditingController();
  final _purposeController = TextEditingController();

  final _dailyUsageController = TextEditingController();
  final _screenTimeBeforeBedController = TextEditingController();
  final _phoneCheckController = TextEditingController();
  final _appsUsedController = TextEditingController();
  final _socialMediaController = TextEditingController();
  final _gamingController = TextEditingController();
  final _weekendUsageController = TextEditingController();

  bool _consentGranted = false;
  bool _isLoading = false;
  bool _isSaving = false;
  bool _hasUsageAccess = false;
  bool _manualEntry = false;
  String? _statusMessage;
  PhoneUsageMetrics? _metrics;
  _PhoneUsageAction? _activeAction;

  bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  bool get _isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  PhoneUsageCubit get _cubit => context.read<PhoneUsageCubit>();

  @override
  void initState() {
    super.initState();
    _loadCachedState();
    _refreshUsageAccess();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _diagnosisIdController.dispose();
    _purposeController.dispose();
    _dailyUsageController.dispose();
    _screenTimeBeforeBedController.dispose();
    _phoneCheckController.dispose();
    _appsUsedController.dispose();
    _socialMediaController.dispose();
    _gamingController.dispose();
    _weekendUsageController.dispose();
    super.dispose();
  }

  Future<void> _loadCachedState() async {
    await _cacheService.init();
    final cachedConsent = _cacheService.get(_consentCacheKey);
    if (cachedConsent is bool && mounted) {
      setState(() => _consentGranted = cachedConsent);
    }

    final cachedMetrics = _cacheService.get(_latestMetricsCacheKey);
    if (cachedMetrics is Map) {
      final metrics = PhoneUsageMetrics.fromJson(
        Map<String, dynamic>.from(cachedMetrics),
      );
      _setMetrics(metrics, persist: false);
    }
  }

  Future<void> _refreshUsageAccess() async {
    if (!_isAndroid) return;
    final hasAccess = await _cubit.hasUsageAccess();
    if (mounted) {
      setState(() => _hasUsageAccess = hasAccess);
    }
  }

  Future<void> _collectUsageData() async {
    if (_isLoading) return;
    final consentOk = await _ensureConsent();
    if (!consentOk) return;

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });
    _activeAction = _PhoneUsageAction.collect;

    if (_isAndroid) {
      final accessOk = await _ensureUsageAccess();
      if (!accessOk) {
        setState(() => _isLoading = false);
        _activeAction = null;
        return;
      }
    }

    _cubit.loadPlatformUsage();
  }

  Future<bool> _ensureConsent() async {
    if (_consentGranted) return true;
    final approved = await _showConsentDialog();
    if (approved && mounted) {
      setState(() => _consentGranted = true);
      await _cacheService.init();
      await _cacheService.put(_consentCacheKey, true);
    }
    return approved;
  }

  Future<bool> _ensureUsageAccess() async {
    final hasAccess = await _cubit.hasUsageAccess();
    if (mounted) {
      setState(() => _hasUsageAccess = hasAccess);
    }
    if (hasAccess) return true;

    await _cubit.openUsageAccessSettings();
    final updated = await _cubit.hasUsageAccess();
    if (mounted) {
      setState(() => _hasUsageAccess = updated);
    }

    if (!updated && mounted) {
      _showSnackBar('Usage access is still not granted.');
    }
    return updated;
  }

  Future<void> _sendToBackend() async {
    if (_isSaving) return;
    final data = _buildPhoneUsageData();
    if (data == null) return;

    setState(() => _isSaving = true);
    _activeAction = _PhoneUsageAction.submit;
    _cubit.submitUsageData(data);
  }

  Future<void> _saveLocally() async {
    final data = _buildPhoneUsageData();
    if (data == null) return;
    await _cacheService.init();
    await _cacheService.put(_latestMetricsCacheKey, data.toJson());
    if (mounted) {
      _showSnackBar('Usage data cached locally.');
    }
  }

  PhoneUsageData? _buildPhoneUsageData() {
    final userId = int.tryParse(_userIdController.text.trim());
    final diagnosisId = int.tryParse(_diagnosisIdController.text.trim());
    final purpose = _purposeController.text.trim();

    if (userId == null || diagnosisId == null || purpose.isEmpty) {
      _showSnackBar('Please provide user id, diagnosis id, and purpose.');
      return null;
    }

    final metrics = _manualEntry
        ? _metricsFromControllers()
        : (_metrics ?? _metricsFromControllers());

    if (metrics == null) {
      _showSnackBar('Usage metrics are missing.');
      return null;
    }

    return PhoneUsageData(
      usageId: DateTime.now().millisecondsSinceEpoch,
      userId: userId,
      diagnosisId: diagnosisId,
      dailyUsageHours: metrics.dailyUsageHours,
      screenTimeBeforeBed: metrics.screenTimeBeforeBed,
      phoneCheckPerDay: metrics.phoneCheckPerDay,
      appsUsedDaily: metrics.appsUsedDaily,
      timeOnSocialMedia: metrics.timeOnSocialMedia,
      timeInGaming: metrics.timeInGaming,
      phoneUsagePurpose: purpose,
      weekendUsageHours: metrics.weekendUsageHours,
      collectedAt: metrics.collectedAt,
    );
  }

  PhoneUsageMetrics? _metricsFromControllers() {
    final daily = double.tryParse(_dailyUsageController.text.trim());
    final beforeBed = double.tryParse(
      _screenTimeBeforeBedController.text.trim(),
    );
    final checks = int.tryParse(_phoneCheckController.text.trim());
    final apps = int.tryParse(_appsUsedController.text.trim());
    final social = double.tryParse(_socialMediaController.text.trim());
    final gaming = double.tryParse(_gamingController.text.trim());
    final weekend = double.tryParse(_weekendUsageController.text.trim());

    if ([
      daily,
      beforeBed,
      checks,
      apps,
      social,
      gaming,
      weekend,
    ].contains(null)) {
      return null;
    }

    return PhoneUsageMetrics(
      dailyUsageHours: daily ?? 0,
      screenTimeBeforeBed: beforeBed ?? 0,
      phoneCheckPerDay: checks ?? 0,
      appsUsedDaily: apps ?? 0,
      timeOnSocialMedia: social ?? 0,
      timeInGaming: gaming ?? 0,
      weekendUsageHours: weekend ?? 0,
      collectedAt: _metrics?.collectedAt ?? DateTime.now(),
    );
  }

  void _setMetrics(PhoneUsageMetrics metrics, {required bool persist}) {
    if (mounted) {
      setState(() => _metrics = metrics);
    } else {
      _metrics = metrics;
    }
    _syncMetricControllers(metrics);
    if (persist) {
      _cacheService.put(_latestMetricsCacheKey, metrics.toJson());
    }
  }

  void _syncMetricControllers(PhoneUsageMetrics metrics) {
    _dailyUsageController.text = metrics.dailyUsageHours.toStringAsFixed(2);
    _screenTimeBeforeBedController.text = metrics.screenTimeBeforeBed
        .toStringAsFixed(2);
    _phoneCheckController.text = metrics.phoneCheckPerDay.toString();
    _appsUsedController.text = metrics.appsUsedDaily.toString();
    _socialMediaController.text = metrics.timeOnSocialMedia.toStringAsFixed(2);
    _gamingController.text = metrics.timeInGaming.toStringAsFixed(2);
    _weekendUsageController.text = metrics.weekendUsageHours.toStringAsFixed(2);
  }

  Future<bool> _showConsentDialog() async {
    final approved = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Consent required'),
        content: const Text(
          'We collect your phone usage statistics (such as screen time and app '
          'usage) to provide personalized insights. This data is processed '
          'securely and only with your permission.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Not now'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('I agree'),
          ),
        ],
      ),
    );
    return approved ?? false;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final headerText = _isIOS
        ? 'iOS provides limited usage access. Manual entry is recommended.'
        : 'Usage data is collected using your device settings.';

    return BlocListener<PhoneUsageCubit, PhoneUsageState>(
      listener: (context, state) {
        state.whenOrNull(
          metricsLoaded: (metrics) {
            if (_activeAction == _PhoneUsageAction.collect) {
              _setMetrics(metrics, persist: true);
              setState(() {
                _statusMessage = null;
                _manualEntry = false;
                _isLoading = false;
              });
              _activeAction = null;
            }
          },
          permissionRequired: (message) {
            if (_activeAction == _PhoneUsageAction.collect) {
              setState(() {
                _statusMessage = message;
                _manualEntry = true;
                _isLoading = false;
                _metrics = PhoneUsageMetrics(collectedAt: DateTime.now());
              });
              _syncMetricControllers(_metrics!);
              _activeAction = null;
            }
          },
          submitted: (_) {
            if (_activeAction == _PhoneUsageAction.submit) {
              _showSnackBar('Usage data sent successfully.');
              setState(() => _isSaving = false);
              _activeAction = null;
            }
          },
          error: (message) {
            if (_activeAction == _PhoneUsageAction.submit) {
              _showSnackBar('Failed to send data: $message');
              setState(() => _isSaving = false);
              _activeAction = null;
              return;
            }

            setState(() {
              _statusMessage = message;
              _manualEntry = true;
              _isLoading = false;
              _metrics = PhoneUsageMetrics(collectedAt: DateTime.now());
            });
            _syncMetricControllers(_metrics!);
            _activeAction = null;
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.lightSurface,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF7F9FF), Color(0xFFEFF3FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Usage Data',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    headerText,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InfoCard(
                    title: 'Consent and privacy',
                    description:
                        'We only collect usage metrics after you approve. You can '
                        'revoke access anytime in system settings.',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _consentGranted
                              ? Icons.verified_rounded
                              : Icons.shield_outlined,
                          color: _consentGranted
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _consentGranted ? 'Granted' : 'Needed',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _InfoCard(
                    title: 'Usage access',
                    description: _isAndroid
                        ? 'Android usage access is required to read screen time.'
                        : 'Usage access is not available on iOS without special '
                              'entitlements.',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _hasUsageAccess
                              ? Icons.check_circle_rounded
                              : Icons.error_outline_rounded,
                          color: _hasUsageAccess
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _hasUsageAccess ? 'Enabled' : 'Disabled',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'User details',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _TextField(
                    controller: _userIdController,
                    label: 'User id',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  _TextField(
                    controller: _diagnosisIdController,
                    label: 'Diagnosis id',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  _TextField(
                    controller: _purposeController,
                    label: 'Primary phone usage purpose',
                    hintText: 'Example: Learning, social, work',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Usage metrics',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _manualEntry = !_manualEntry);
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        child: Text(
                          _manualEntry ? 'Show summary' : 'Edit manually',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_manualEntry)
                    _ManualMetricsForm(
                      dailyUsageController: _dailyUsageController,
                      screenTimeBeforeBedController:
                          _screenTimeBeforeBedController,
                      phoneCheckController: _phoneCheckController,
                      appsUsedController: _appsUsedController,
                      socialMediaController: _socialMediaController,
                      gamingController: _gamingController,
                      weekendUsageController: _weekendUsageController,
                    )
                  else
                    _MetricsSummary(metrics: _metrics),
                  if (_statusMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _statusMessage!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  GradientButton(
                    text: _isLoading ? 'Collecting...' : 'Collect usage data',
                    isLoading: _isLoading,
                    onPressed: _isLoading ? null : _collectUsageData,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _saveLocally,
                          child: const Text('Save locally'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isSaving ? null : _sendToBackend,
                          child: Text(
                            _isSaving ? 'Sending...' : 'Send to backend',
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_isAndroid && !_hasUsageAccess) ...[
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _cubit.openUsageAccessSettings,
                      icon: const Icon(Icons.settings_rounded),
                      label: const Text('Open usage access settings'),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.description,
    required this.trailing,
  });

  final String title;
  final String description;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          trailing,
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _MetricsSummary extends StatelessWidget {
  const _MetricsSummary({required this.metrics});

  final PhoneUsageMetrics? metrics;

  @override
  Widget build(BuildContext context) {
    if (metrics == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          'No metrics collected yet.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    final items = [
      _MetricItem(
        'Daily usage',
        '${metrics!.dailyUsageHours.toStringAsFixed(2)} h',
      ),
      _MetricItem(
        'Before bed',
        '${metrics!.screenTimeBeforeBed.toStringAsFixed(2)} h',
      ),
      _MetricItem('Phone checks', '${metrics!.phoneCheckPerDay}'),
      _MetricItem('Apps used', '${metrics!.appsUsedDaily}'),
      _MetricItem(
        'Social media',
        '${metrics!.timeOnSocialMedia.toStringAsFixed(2)} h',
      ),
      _MetricItem('Gaming', '${metrics!.timeInGaming.toStringAsFixed(2)} h'),
      _MetricItem(
        'Weekend usage',
        '${metrics!.weekendUsageHours.toStringAsFixed(2)} h',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      item.value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ManualMetricsForm extends StatelessWidget {
  const _ManualMetricsForm({
    required this.dailyUsageController,
    required this.screenTimeBeforeBedController,
    required this.phoneCheckController,
    required this.appsUsedController,
    required this.socialMediaController,
    required this.gamingController,
    required this.weekendUsageController,
  });

  final TextEditingController dailyUsageController;
  final TextEditingController screenTimeBeforeBedController;
  final TextEditingController phoneCheckController;
  final TextEditingController appsUsedController;
  final TextEditingController socialMediaController;
  final TextEditingController gamingController;
  final TextEditingController weekendUsageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NumberField(
          label: 'Daily usage hours',
          controller: dailyUsageController,
          decimal: true,
        ),
        const SizedBox(height: 12),
        _NumberField(
          label: 'Screen time before bed (hours)',
          controller: screenTimeBeforeBedController,
          decimal: true,
        ),
        const SizedBox(height: 12),
        _NumberField(
          label: 'Phone checks per day',
          controller: phoneCheckController,
        ),
        const SizedBox(height: 12),
        _NumberField(label: 'Apps used daily', controller: appsUsedController),
        const SizedBox(height: 12),
        _NumberField(
          label: 'Time on social media (hours)',
          controller: socialMediaController,
          decimal: true,
        ),
        const SizedBox(height: 12),
        _NumberField(
          label: 'Time in gaming (hours)',
          controller: gamingController,
          decimal: true,
        ),
        const SizedBox(height: 12),
        _NumberField(
          label: 'Weekend usage hours',
          controller: weekendUsageController,
          decimal: true,
        ),
      ],
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.controller,
    this.decimal = false,
  });

  final String label;
  final TextEditingController controller;
  final bool decimal;

  @override
  Widget build(BuildContext context) {
    final formatters = <TextInputFormatter>[
      FilteringTextInputFormatter.allow(
        decimal ? RegExp(r'[0-9.]') : RegExp(r'[0-9]'),
      ),
    ];

    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      inputFormatters: formatters,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _MetricItem {
  const _MetricItem(this.label, this.value);

  final String label;
  final String value;
}
