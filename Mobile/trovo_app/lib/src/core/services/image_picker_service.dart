import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trovo_app/generated/l10n.dart';
import 'package:trovo_app/src/core/widgets/image_source_bottom_sheet.dart';

class ImagePickResult {
  final File? file;
  final String? errorMessage;
  final bool isSuccess;

  const ImagePickResult._({
    this.file,
    this.errorMessage,
    required this.isSuccess,
  });

  factory ImagePickResult.success(File file) =>
      ImagePickResult._(file: file, isSuccess: true);

  factory ImagePickResult.error(String message) =>
      ImagePickResult._(errorMessage: message, isSuccess: false);

  factory ImagePickResult.cancelled() =>
      const ImagePickResult._(isSuccess: false);
}

class ImagePickerConfig {
  final int maxSizeBytes;

  final int imageQuality;

  final double? maxWidth;

  final double? maxHeight;

  const ImagePickerConfig({
    this.maxSizeBytes = 5 * 1024 * 1024,
    this.imageQuality = 80,
    this.maxWidth = 1024,
    this.maxHeight = 1024,
  });

  double get maxSizeKB => maxSizeBytes / 1024;

  double get maxSizeMB => maxSizeBytes / (1024 * 1024);
}

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();
  final ImagePickerConfig _config;

  ImagePickerService({ImagePickerConfig? config})
    : _config = config ?? const ImagePickerConfig();

  Future<ImagePickResult> pickImage(ImageSourceType source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source == ImageSourceType.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: _config.imageQuality,
        maxWidth: _config.maxWidth,
        maxHeight: _config.maxHeight,
      );

      if (pickedFile == null) {
        return ImagePickResult.cancelled();
      }

      final file = File(pickedFile.path);

      final validationError = await _validateFileSize(file);
      if (validationError != null) {
        return ImagePickResult.error(validationError);
      }

      return ImagePickResult.success(file);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return ImagePickResult.error(S.current.unknownError);
    }
  }

  Future<String?> _validateFileSize(File file) async {
    final fileSize = await file.length();
    if (fileSize > _config.maxSizeBytes) {
      return S.current.imageTooLarge(_config.maxSizeMB);
    }
    return null;
  }

  Future<double> getFileSizeMB(File file) async {
    final fileSize = await file.length();
    return fileSize / (1024 * 1024);
  }

  void showImageSourceBottomSheet(
    BuildContext context, {
    required void Function(File? image) onImageSelected,
    void Function(String error)? onError,
  }) {
    ImageSourceBottomSheet.show(
      context,
      onSourceSelected: (source) async {
        final result = await pickImage(source);

        if (result.isSuccess && result.file != null) {
          onImageSelected(result.file);
        } else if (result.errorMessage != null) {
          onError?.call(result.errorMessage!);
          onImageSelected(null);
        } else {
          onImageSelected(null);
        }
      },
    );
  }
}
