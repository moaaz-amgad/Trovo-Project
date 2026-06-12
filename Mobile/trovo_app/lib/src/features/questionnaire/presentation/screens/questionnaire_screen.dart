import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:trovo_app/src/core/di/injection_container.dart';
import 'package:trovo_app/src/core/routing/app_router_paths.dart';
import '../../data/datasources/questionnaire_local_data_source.dart';
import '../../data/models/questionnaire_response.dart';
import '../cubit/questionnaire_cubit.dart';
import '../../../phone_usage/presentation/cubit/phone_usage_cubit.dart';
import '../widgets/questionnaire_gender_option.dart';
import '../widgets/questionnaire_horizontal_picker.dart';
import '../widgets/questionnaire_intro_card.dart';
import '../widgets/questionnaire_labeled_slider.dart';
import '../widgets/questionnaire_nav_buttons.dart';
import '../widgets/questionnaire_phone_purpose_option.dart';
import '../widgets/questionnaire_question_card.dart';
import '../widgets/questionnaire_question_title.dart';
import '../widgets/questionnaire_sloth_header.dart';
import '../widgets/questionnaire_step_indicator.dart';

// ---------------------------------------------------------------------------
// Public entry-point
// ---------------------------------------------------------------------------

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuestionnaireCubit>(
          create: (_) => sl<QuestionnaireCubit>()..loadDraft(),
        ),
        BlocProvider<PhoneUsageCubit>(create: (_) => sl<PhoneUsageCubit>()),
      ],
      child: const _QuestionnaireBody(),
    );
  }
}

// ---------------------------------------------------------------------------
// Body — decides whether to show the intro or the form
// ---------------------------------------------------------------------------

class _QuestionnaireBody extends StatefulWidget {
  const _QuestionnaireBody();

  @override
  State<_QuestionnaireBody> createState() => _QuestionnaireBodyState();
}

class _QuestionnaireBodyState extends State<_QuestionnaireBody> {
  bool _introComplete = false;

  void _onIntroComplete() => setState(() => _introComplete = true);

  @override
  Widget build(BuildContext context) {
    return _introComplete
        ? _QuestionnaireForm(key: const ValueKey('form'))
        : _QuestionnaireIntro(onComplete: _onIntroComplete);
  }
}

// ---------------------------------------------------------------------------
// Intro screen — "Let's Understand You Better" (design 37:3050)
// ---------------------------------------------------------------------------

class _QuestionnaireIntro extends StatelessWidget {
  const _QuestionnaireIntro({required this.onComplete});

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            IgnorePointer(
              child: Column(
                children: [
                  Container(
                    height: 155,
                    decoration: const BoxDecoration(
                      color: Color(0xFF042F40),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            const Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Center(child: QuestionnaireSlothHeader()),
              ),
            ),
            Positioned.fill(
              top: 180,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    MediaQuery.viewPaddingOf(context).bottom + 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _IntroTitleSection(),
                      const SizedBox(height: 16),
                      const _PrivacyReassuranceCard(),
                      const SizedBox(height: 32),
                      _IntroButton(
                        label: 'Allow Access',
                        primary: true,
                        onTap: onComplete,
                      ),
                      const SizedBox(height: 16),
                      _IntroButton(
                        label: 'Maybe Later',
                        primary: false,
                        onTap: onComplete,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroTitleSection extends StatelessWidget {
  const _IntroTitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Let's Understand\nYou Better",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Color(0xFF042F40),
            letterSpacing: -0.9,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Color(0x99042F40),
              height: 1.7,
            ),
            children: [
              TextSpan(text: 'To give you the best experience, '),
              TextSpan(
                text: 'we need access',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF042F40),
                ),
              ),
              TextSpan(
                text:
                    ' to your Screen Time and daily phone usage.'
                    ' This helps us understand your habits and'
                    ' accurately set your ideal focus level.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivacyReassuranceCard extends StatelessWidget {
  const _PrivacyReassuranceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(32),
        border: const Border(
          left: BorderSide(color: Color(0x99042F40), width: 4),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 30,
            color: Color(0xFF042F40),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "Don't worry, your data stays private\n"
              'and is only used to improve your\njourney.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0x99042F40),
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroButton extends StatelessWidget {
  const _IntroButton({
    required this.label,
    required this.primary,
    required this.onTap,
  });

  final String label;
  final bool primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (primary) {
      return SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF042F40),
            foregroundColor: const Color(0xFFF2F2F2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    return SizedBox(
      height: 44,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFF2F2F2),
          backgroundColor: const Color(0x99042F40),
          side: const BorderSide(color: Color(0x33042F40)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Questionnaire form — 6 steps (design 37:3088 → 37:3310)
// ---------------------------------------------------------------------------

class _QuestionnaireForm extends StatefulWidget {
  const _QuestionnaireForm({super.key});

  @override
  State<_QuestionnaireForm> createState() => _QuestionnaireFormState();
}

class _QuestionnaireFormState extends State<_QuestionnaireForm> {
  // ── constants ─────────────────────────────────────────────────────────────

  static const int _totalSteps = 6;
  static const int _lastStep = _totalSteps - 1;

  static const List<String> _phonePurposeOptions = [
    'Social Media',
    'Gaming',
    'Education',
    'Other',
  ];

  static const List<String> _academicLabels = [
    'Fail (F)',
    'Pass (D)',
    'Good (C)',
    'V.Good (B)',
    'Excel (A)',
  ];

  static const List<String> _socialLabels = [
    'Never',
    'Rarely',
    'Sometime',
    'Often',
    'Always',
  ];

  static const List<int> _gradeToPerformance = [0, 55, 70, 85, 100];

  // ── controllers ───────────────────────────────────────────────────────────

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthYearController = TextEditingController(
    text: '2004',
  );

  // ── form state ────────────────────────────────────────────────────────────

  int _step = 0;
  bool _isLoadingDraft = true;

  // Step 0
  String _gender = '';

  // Step 1
  int _sleepHours = 8;
  int _academicGrade = 2; // 0=F … 4=A

  // Step 2
  int _socialQuality = 2; // 0=Never … 4=Always
  int _exerciseHours = 2; // 0-4

  // Step 3
  int _sadnessFrequency = 5; // 0-10
  int _anxietyLevel = 5; // 0-10  (local only — not in QuestionnaireResponse)

  // Step 4
  int _selfEsteem = 5; // 0-10
  int _studyHours = 5; // 0-10  (local only — not in QuestionnaireResponse)

  // Step 5 (last)
  String _phonePurpose = '';

  // ── lifecycle ─────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _birthYearController.dispose();
    super.dispose();
  }

  // ── draft ─────────────────────────────────────────────────────────────────

  void _applyDraft(QuestionnaireDraft? draft) {
    if (!mounted) return;
    if (draft == null) {
      setState(() => _isLoadingDraft = false);
      return;
    }
    final r = draft.response;
    setState(() {
      _nameController.text = r.name;
      _birthYearController.text =
          '${DateTime.now().year - r.age.clamp(10, 40)}';
      _gender = r.gender;
      _sleepHours = r.sleepHours.clamp(1, 24);
      _academicGrade = _performanceToGrade(r.academicPerformance);
      _socialQuality = (r.socialInteractionScore ~/ 2).clamp(0, 4);
      _exerciseHours = r.physicalExerciseHours.clamp(0, 4);
      _sadnessFrequency = r.sadnessFrequency.clamp(0, 10);
      _selfEsteem = r.selfEsteemScore.clamp(0, 10);
      _phonePurpose = _normalizePhonePurpose(r.phonePurpose);
      _step = 0;
      _isLoadingDraft = false;
    });
  }

  static int _performanceToGrade(int performance) {
    if (performance <= 40) return 0;
    if (performance <= 62) return 1;
    if (performance <= 77) return 2;
    if (performance <= 92) return 3;
    return 4;
  }

  static String _normalizePhonePurpose(String value) {
    if (_phonePurposeOptions.contains(value)) return value;
    return '';
  }

  // ── response builder ──────────────────────────────────────────────────────

  QuestionnaireResponse _buildResponse() {
    final birthYear =
        int.tryParse(_birthYearController.text.trim()) ??
        (DateTime.now().year - 21);
    final age = (DateTime.now().year - birthYear).clamp(10, 40);

    return QuestionnaireResponse(
      name: _nameController.text.trim(),
      age: age,
      gender: _gender,
      sleepHours: _sleepHours,
      academicPerformance: _gradeToPerformance[_academicGrade],
      socialInteractionScore: _socialQuality * 2,
      physicalExerciseHours: _exerciseHours,
      sadnessFrequency: _sadnessFrequency,
      selfEsteemScore: _selfEsteem,
      dailyPhoneUsageHours: 4,
      primaryGoal: 'Focus',
      phonePurpose: _phonePurpose,
    );
  }

  // ── navigation ────────────────────────────────────────────────────────────

  void _next() {
    if (!_validateStep(_step)) {
      _showValidationMessage(_step);
      return;
    }
    if (_step < _lastStep) {
      _updateAndSetState(() => _step += 1);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToTop());
      return;
    }
    _submit();
  }

  void _back() {
    if (_step > 0) {
      _updateAndSetState(() => _step -= 1);
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToTop());
    }
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void _updateAndSetState(VoidCallback updater) {
    setState(updater);
    unawaited(
      context.read<QuestionnaireCubit>().saveDraft(
        response: _buildResponse(),
        step: _step,
      ),
    );
  }

  // ── validation ────────────────────────────────────────────────────────────

  bool _validateStep(int step) {
    if (step == 0) {
      return _nameController.text.trim().isNotEmpty && _gender.isNotEmpty;
    }
    if (step == _lastStep) return _phonePurpose.isNotEmpty;
    return true;
  }

  void _showValidationMessage(int step) {
    final message = switch (step) {
      0 when _nameController.text.trim().isEmpty && _gender.isEmpty =>
        'Please enter your name and choose your gender to continue.',
      0 when _nameController.text.trim().isEmpty =>
        'Please enter your name to continue.',
      0 => 'Please choose your gender to continue.',
      _ => 'Please choose your phone usage purpose to continue.',
    };
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // ── submission ────────────────────────────────────────────────────────────

  void _submit() {
    if (!_validateStep(_step)) {
      _showValidationMessage(_step);
      return;
    }
    context.read<QuestionnaireCubit>().submit(_buildResponse());
  }

  // ── bottom sheet ──────────────────────────────────────────────────────────

  void _showManualPhoneUsageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<PhoneUsageCubit>(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: _ManualPhoneUsageSheet(phonePurpose: _phonePurpose),
        ),
      ),
    );
  }

  // ── build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuestionnaireCubit, QuestionnaireState>(
          listener: (context, state) {
            state.whenOrNull(
              draftLoaded: _applyDraft,
              submitted: () {
                context.read<PhoneUsageCubit>().loadPlatformUsage();
              },
              error: (message) => ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(message))),
            );
          },
        ),
        BlocListener<PhoneUsageCubit, PhoneUsageState>(
          listener: (context, state) {
            state.whenOrNull(
              metricsLoaded: (metrics) {
                context.read<PhoneUsageCubit>().submitUsage({
                  'daily_usage_hours': metrics.dailyUsageHours.toStringAsFixed(
                    1,
                  ),
                  'screen_time_before_bed': metrics.screenTimeBeforeBed
                      .toStringAsFixed(1),
                  'phone_checks_per_day': metrics.phoneCheckPerDay.toString(),
                  'apps_used_daily': metrics.appsUsedDaily.toString(),
                  'time_on_social_media': metrics.timeOnSocialMedia
                      .toStringAsFixed(1),
                  'time_on_gaming': metrics.timeInGaming.toStringAsFixed(1),
                  'weekend_usage_hours': metrics.weekendUsageHours
                      .toStringAsFixed(1),
                });
              },
              permissionRequired: (_) =>
                  _showManualPhoneUsageBottomSheet(context),
              error: (_) => _showManualPhoneUsageBottomSheet(context),
              submitted: (_) {
                context.go(AppRoutePaths.diagnosisResultScreen);
              },
            );
          },
        ),
      ],
      child: BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
        builder: (context, state) {
          final isLoadingDraft = state.maybeWhen(
            loadingDraft: () => true,
            orElse: () => _isLoadingDraft,
          );
          final isQuestionnaireSubmitting = state.maybeWhen(
            submitting: () => true,
            orElse: () => false,
          );
          final isPhoneUsageSubmitting = context
              .watch<PhoneUsageCubit>()
              .state
              .maybeWhen(loading: () => true, orElse: () => false);
          final isSubmitting =
              isQuestionnaireSubmitting || isPhoneUsageSubmitting;

          if (isLoadingDraft) {
            return const Scaffold(
              backgroundColor: Color(0xFFF2F2F2),
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF042F40)),
              ),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xFFF2F2F2),
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  IgnorePointer(
                    child: Column(
                      children: [
                        Container(
                          height: 155,
                          decoration: const BoxDecoration(
                            color: Color(0xFF042F40),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 112,
                    child: _FormPanel(
                      step: _step,
                      totalSteps: _totalSteps,
                      scrollController: _scrollController,
                      stepContent: _buildStepContent(),
                      bottomActions: _buildBottomActions(isSubmitting),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── step content factory ──────────────────────────────────────────────────

  Widget _buildStepContent() {
    return switch (_step) {
      0 => _buildPersonalInfoStep(),
      1 => _buildSleepAcademicStep(),
      2 => _buildSocialExerciseStep(),
      3 => _buildMentalHealthStep(),
      4 => _buildSelfEsteemStudyStep(),
      _ => _buildPhonePurposeStep(),
    };
  }

  // Step 0 — Personal Info (37:3088)
  Widget _buildPersonalInfoStep() {
    return QuestionnaireQuestionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuestionnaireQuestionTitle('What is your name?'),
          const SizedBox(height: 10),
          _buildTextField(
            controller: _nameController,
            hint: 'Full Name',
            onChanged: (_) => _updateAndSetState(() {}),
          ),
          const SizedBox(height: 22),
          const QuestionnaireQuestionTitle("What's your birth year?"),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF82979F), width: 0.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _birthYearController.text.isEmpty ? null : _birthYearController.text,
                hint: const Text('Select Year', style: TextStyle(color: Color(0x80042F40))),
                items: List.generate(
                  DateTime.now().year - 1949, // From 1950 to current year
                  (index) => (DateTime.now().year - index).toString(),
                ).map((year) {
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year, style: const TextStyle(color: Color(0xFF042F40))),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    _birthYearController.text = val;
                    _updateAndSetState(() {});
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const QuestionnaireQuestionTitle('What is your gender?'),
          const SizedBox(height: 8),
          Row(
            children: [
              QuestionnaireGenderOption(
                label: 'Male',
                selected: _gender == 'Male',
                onTap: () => _updateAndSetState(() => _gender = 'Male'),
              ),
              const SizedBox(width: 24),
              QuestionnaireGenderOption(
                label: 'Female',
                selected: _gender == 'Female',
                onTap: () => _updateAndSetState(() => _gender = 'Female'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 1 — Sleep & Academic (37:3155)
  Widget _buildSleepAcademicStep() {
    return Column(
      children: [
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How many hours do you sleep per night on average?',
              ),
              const SizedBox(height: 10),
              QuestionnaireHorizontalPicker(
                min: 1,
                max: 24,
                value: _sleepHours,
                onChanged: (v) => _updateAndSetState(() => _sleepHours = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How would you rate your academic performance?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 4,
                divisions: 4,
                value: _academicGrade.toDouble(),
                labels: _academicLabels,
                labelFontSize: 10,
                onChanged: (v) =>
                    _updateAndSetState(() => _academicGrade = v.round()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 2 — Social & Exercise (37:3234)
  Widget _buildSocialExerciseStep() {
    return Column(
      children: [
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How would you rate the quality of your social interactions?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 4,
                divisions: 4,
                value: _socialQuality.toDouble(),
                labels: _socialLabels,
                onChanged: (v) =>
                    _updateAndSetState(() => _socialQuality = v.round()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How many hours of physical exercise do you engage in daily?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 4,
                divisions: 4,
                value: _exerciseHours.toDouble(),
                labels: const ['0', '1', '2', '3', '4'],
                onChanged: (v) =>
                    _updateAndSetState(() => _exerciseHours = v.round()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 3 — Mental Health (37:3365)
  Widget _buildMentalHealthStep() {
    return Column(
      children: [
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How often do you experience feelings of sadness or loneliness?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 10,
                divisions: 10,
                value: _sadnessFrequency.toDouble(),
                labels: const [
                  '0',
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                ],
                onChanged: (v) =>
                    _updateAndSetState(() => _sadnessFrequency = v.round()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How would you rate your overall anxiety-level?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 10,
                divisions: 10,
                value: _anxietyLevel.toDouble(),
                labels: const [
                  '0',
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                ],
                onChanged: (v) =>
                    _updateAndSetState(() => _anxietyLevel = v.round()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 4 — Self-esteem & Study (37:3453)
  Widget _buildSelfEsteemStudyStep() {
    return Column(
      children: [
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How would you rate your overall self-esteem?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 10,
                divisions: 10,
                value: _selfEsteem.toDouble(),
                labels: const [
                  '0',
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                ],
                onChanged: (v) =>
                    _updateAndSetState(() => _selfEsteem = v.round()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        QuestionnaireQuestionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuestionnaireQuestionTitle(
                'How many hours do you study per night on average?',
              ),
              const SizedBox(height: 14),
              QuestionnaireLabeledSlider(
                min: 0,
                max: 10,
                divisions: 10,
                value: _studyHours.toDouble(),
                labels: const [
                  '0',
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                ],
                onChanged: (v) =>
                    _updateAndSetState(() => _studyHours = v.round()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Step 5 — Phone Purpose (37:3310)
  Widget _buildPhonePurposeStep() {
    return QuestionnaireQuestionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuestionnaireQuestionTitle(
            'What is the primary purpose of your phone usage?',
          ),
          const SizedBox(height: 8),
          ..._phonePurposeOptions.map(
            (option) => QuestionnairePhonePurposeOption(
              label: option,
              selected: _phonePurpose == option,
              onTap: () => _updateAndSetState(() => _phonePurpose = option),
            ),
          ),
        ],
      ),
    );
  }

  // ── bottom actions ────────────────────────────────────────────────────────

  Widget _buildBottomActions(bool isSubmitting) {
    if (_step == _lastStep) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: isSubmitting ? null : _next,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF042F40),
            foregroundColor: const Color(0xFFF2F2F2),
            minimumSize: const Size.fromHeight(44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFF042F40), width: 2),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: isSubmitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Get Your Results'),
        ),
      );
    }

    return QuestionnaireNavButtons(
      onBack: _back,
      onNext: _next,
      canGoBack: _step > 0,
      isLoading: isSubmitting,
    );
  }

  // ── helpers ───────────────────────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF042F40),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0x80042F40),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF82979F), width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF82979F), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF042F40), width: 1),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Panel that wraps the scrollable content area + indicators
// ---------------------------------------------------------------------------

class _FormPanel extends StatelessWidget {
  const _FormPanel({
    required this.step,
    required this.totalSteps,
    required this.scrollController,
    required this.stepContent,
    required this.bottomActions,
  });

  final int step;
  final int totalSteps;
  final ScrollController scrollController;
  final Widget stepContent;
  final Widget bottomActions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDED8E1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          52,
          16,
          MediaQuery.viewPaddingOf(context).bottom + 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      const Center(
                        child: SizedBox(
                          height: 185,
                          child: Image(
                            image: AssetImage('assets/images/sloth.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      QuestionnaireIntroCard(),
                      const SizedBox(height: 22),
                      QuestionnaireStepIndicator(
                        currentStep: step,
                        totalSteps: totalSteps,
                      ),
                      const SizedBox(height: 28),
                      stepContent,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            bottomActions,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// iOS / Permission Denied Fallback Bottom Sheet
// ---------------------------------------------------------------------------

class _ManualPhoneUsageSheet extends StatefulWidget {
  final String phonePurpose;
  const _ManualPhoneUsageSheet({required this.phonePurpose});

  @override
  State<_ManualPhoneUsageSheet> createState() => _ManualPhoneUsageSheetState();
}

class _ManualPhoneUsageSheetState extends State<_ManualPhoneUsageSheet> {
  final _dailyController = TextEditingController(text: '4');
  final _bedController = TextEditingController(text: '1');
  final _checksController = TextEditingController(text: '30');
  final _appsController = TextEditingController(text: '10');
  final _socialController = TextEditingController(text: '2');
  final _gamingController = TextEditingController(text: '0');
  final _weekendController = TextEditingController(text: '5');

  void _submit() {
    final daily = double.tryParse(_dailyController.text.trim()) ?? 4.0;
    final bed = double.tryParse(_bedController.text.trim()) ?? 1.0;
    final checks = int.tryParse(_checksController.text.trim()) ?? 30;
    final apps = int.tryParse(_appsController.text.trim()) ?? 10;
    final social = double.tryParse(_socialController.text.trim()) ?? 2.0;
    final gaming = double.tryParse(_gamingController.text.trim()) ?? 0.0;
    final weekend = double.tryParse(_weekendController.text.trim()) ?? 5.0;

    Navigator.of(context).pop();

    context.read<PhoneUsageCubit>().submitUsage({
      'daily_usage_hours': daily.toStringAsFixed(1),
      'screen_time_before_bed': bed.toStringAsFixed(1),
      'phone_checks_per_day': checks.toString(),
      'apps_used_daily': apps.toString(),
      'time_on_social_media': social.toStringAsFixed(1),
      'time_on_gaming': gaming.toStringAsFixed(1),
      'weekend_usage_hours': weekend.toStringAsFixed(1),
    });
  }

  @override
  void dispose() {
    _dailyController.dispose();
    _bedController.dispose();
    _checksController.dispose();
    _appsController.dispose();
    _socialController.dispose();
    _gamingController.dispose();
    _weekendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Manual Phone Usage Entry',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF042F40),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your device does not support automatic screen time collection. Please estimate your usage.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _TextField(
              controller: _dailyController,
              label: 'Daily usage (hours)',
            ),
            const SizedBox(height: 12),
            _TextField(
              controller: _bedController,
              label: 'Screen time before bed (hours)',
            ),
            const SizedBox(height: 12),
            _TextField(
              controller: _checksController,
              label: 'Phone checks per day',
            ),
            const SizedBox(height: 12),
            _TextField(
              controller: _appsController,
              label: 'Apps used daily',
            ),
            const SizedBox(height: 12),
            _TextField(
              controller: _socialController,
              label: 'Time on social media (hours)',
            ),
            const SizedBox(height: 12),
            _TextField(
              controller: _gamingController,
              label: 'Time on gaming (hours)',
            ),
            const SizedBox(height: 12),
            _TextField(
              controller: _weekendController,
              label: 'Weekend usage (hours)',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF042F40),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Submit Usage & View Diagnosis',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const _TextField({required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
