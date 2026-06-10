import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trovo_app/generated/l10n.dart';
import 'package:trovo_app/src/core/theming/app_colors.dart';
import 'package:trovo_app/src/core/theming/app_text_styles.dart';
import 'package:trovo_app/src/core/widgets/gradient_button.dart';

enum ImageSourceType { camera, gallery }

class ImageSourceBottomSheet extends StatefulWidget {
  final void Function(ImageSourceType source) onSourceSelected;

  const ImageSourceBottomSheet({super.key, required this.onSourceSelected});

  static void show(
    BuildContext context, {
    required void Function(ImageSourceType source) onSourceSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) =>
          ImageSourceBottomSheet(onSourceSelected: onSourceSelected),
    );
  }

  @override
  State<ImageSourceBottomSheet> createState() => _ImageSourceBottomSheetState();
}

class _ImageSourceBottomSheetState extends State<ImageSourceBottomSheet> {
  ImageSourceType? _selectedSource;

  void _onSourceSelected(ImageSourceType source) {
    setState(() => _selectedSource = source);
  }

  void _applySelection() {
    if (_selectedSource != null) {
      Navigator.pop(context);
      widget.onSourceSelected(_selectedSource!);
    }
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
          _buildSourceOptions(),
          SizedBox(height: 24.h),
          _buildSelectButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      S.of(context).selectImageSource,
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF0D1D1E),
      ),
    );
  }

  Widget _buildSourceOptions() {
    return Column(
      children: [
        _ImageSourceOption(
          label: S.of(context).camera,
          subtitle: S.of(context).takeNewPhoto,
          isSelected: _selectedSource == ImageSourceType.camera,
          onTap: () => _onSourceSelected(ImageSourceType.camera),
        ),
        SizedBox(height: 12.h),
        _ImageSourceOption(
          label: S.of(context).gallery,
          subtitle: S.of(context).chooseFromGallery,
          isSelected: _selectedSource == ImageSourceType.gallery,
          onTap: () => _onSourceSelected(ImageSourceType.gallery),
        ),
      ],
    );
  }

  Widget _buildSelectButton() {
    return GradientButton(
      text: S.of(context).select,
      onPressed: _selectedSource != null ? _applySelection : null,
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  const _ImageSourceOption({
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
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
          border: Border.all(
            color: isSelected ? AppColors.primary : _borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            _CustomRadioButton(isSelected: isSelected),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: _textColor.withValues(alpha: 0.6),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
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
