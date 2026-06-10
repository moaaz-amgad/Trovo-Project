import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trovo_app/generated/l10n.dart';
import 'package:trovo_app/src/core/cubits/locale_cubit.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';
import 'package:trovo_app/src/core/theming/app_text_styles.dart';
import 'package:trovo_app/src/core/widgets/gradient_button.dart';

/// A bottom sheet that allows users to select and change the app language.
///
/// Displays all supported locales dynamically from [S.delegate.supportedLocales]
/// and applies the selected language through [LocaleCubit].
class LanguageSelectorBottomSheet extends StatefulWidget {
  const LanguageSelectorBottomSheet({super.key});

  @override
  State<LanguageSelectorBottomSheet> createState() =>
      _LanguageSelectorBottomSheetState();
}

class _LanguageSelectorBottomSheetState
    extends State<LanguageSelectorBottomSheet> {
  late String _selectedLanguageCode;

  static const _languageNames = {'ar': 'العربية', 'en': 'English'};

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = context.read<LocaleCubit>().state.languageCode;
  }

  void _onLanguageSelected(String languageCode) {
    setState(() => _selectedLanguageCode = languageCode);
  }

  void _applyLanguageChange() {
    final locale = S.delegate.supportedLocales.firstWhere(
      (locale) => locale.languageCode == _selectedLanguageCode,
    );
    context.read<LocaleCubit>().changeLocale(locale);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F6),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          SizedBox(height: 24.h),
          _buildLanguageOptions(),
          SizedBox(height: 24.h),
          _buildApplyButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      S.of(context).language,
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF0D1D1E),
      ),
    );
  }

  Widget _buildLanguageOptions() {
    final locales = S.delegate.supportedLocales;
    return Column(
      children: [
        for (var i = 0; i < locales.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i < locales.length - 1 ? 12.h : 0),
            child: _LanguageOption(
              label:
                  _languageNames[locales[i].languageCode] ??
                  locales[i].languageCode,
              isSelected: _selectedLanguageCode == locales[i].languageCode,
              onTap: () => _onLanguageSelected(locales[i].languageCode),
            ),
          ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return GradientButton(
      text: S.of(context).apply,
      onPressed: _applyLanguageChange,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const _borderColor = Color(0xFFE8E8E8);
  static const _textColor = Color(0xFF0D1D1E);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(color: _textColor),
            ),
            SizedBox(width: 8.w),
            _CustomRadioButton(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _CustomRadioButton extends StatelessWidget {
  const _CustomRadioButton({required this.isSelected});

  final bool isSelected;

  static const double _outerSize = 16;
  static const double _innerSize = 8;
  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.primary
        : AppColors.primary.withAlpha(50);

    return Container(
      width: _outerSize.w,
      height: _outerSize.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: _borderWidth),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _innerSize.w,
          height: _innerSize.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColors.primary : Colors.white,
          ),
        ),
      ),
    );
  }
}
