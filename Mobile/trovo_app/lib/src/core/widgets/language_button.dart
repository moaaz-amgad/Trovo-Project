import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trovo_app/src/core/cubits/locale_cubit.dart';
import 'package:trovo_app/src/core/extensions/context_extension.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';
import 'package:trovo_app/src/core/theming/app_text_styles.dart';
import 'package:trovo_app/src/core/widgets/language_selector_bottom_sheet.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: context.isRTL ? Alignment.centerLeft : Alignment.centerRight,
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => const LanguageSelectorBottomSheet(),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/global.svg',
              width: 18.sp,
              height: 18.sp,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            label: Text(
              locale.languageCode == 'en' ? 'العربية' : 'English',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            style: TextButton.styleFrom(minimumSize: Size.zero),
          );
        },
      ),
    );
  }
}
