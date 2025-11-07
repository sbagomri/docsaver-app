import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/result.dart';

/// Service for picking images and files
class FilePickerService {
  final ImagePicker _imagePicker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;

  /// Pick single image from camera
  Future<Result<File>> pickImageFromCamera() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
      );

      if (photo == null) {
        return Result.failure(
          ValidationException('No image selected'),
        );
      }

      return Result.success(File(photo.path));
    } catch (e) {
      return Result.failure(
        FileSystemException(
          'Failed to capture image from camera',
          originalError: e,
        ),
      );
    }
  }

  /// Pick multiple images from gallery
  Future<Result<List<File>>> pickImagesFromGallery({int maxImages = 10}) async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
      );

      if (images.isEmpty) {
        return Result.failure(
          ValidationException('No images selected'),
        );
      }

      if (images.length > maxImages) {
        return Result.failure(
          ValidationException('Maximum $maxImages images allowed'),
        );
      }

      final files = images.map((xFile) => File(xFile.path)).toList();
      return Result.success(files);
    } catch (e) {
      return Result.failure(
        FileSystemException(
          'Failed to pick images from gallery',
          originalError: e,
        ),
      );
    }
  }

  /// Pick PDF or document file
  Future<Result<File>> pickDocument() async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return Result.failure(
          ValidationException('No file selected'),
        );
      }

      final filePath = result.files.first.path;
      if (filePath == null) {
        return Result.failure(
          FileSystemException('Invalid file path'),
        );
      }

      final file = File(filePath);

      // Check file size (max 50MB)
      final fileSize = await file.length();
      const maxSize = 50 * 1024 * 1024; // 50MB

      if (fileSize > maxSize) {
        return Result.failure(
          ValidationException('File size exceeds 50MB limit'),
        );
      }

      return Result.success(file);
    } catch (e) {
      return Result.failure(
        FileSystemException(
          'Failed to pick document',
          originalError: e,
        ),
      );
    }
  }

  /// Pick multiple files
  Future<Result<List<File>>> pickMultipleDocuments({int maxFiles = 5}) async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) {
        return Result.failure(
          ValidationException('No files selected'),
        );
      }

      if (result.files.length > maxFiles) {
        return Result.failure(
          ValidationException('Maximum $maxFiles files allowed'),
        );
      }

      final files = <File>[];
      for (final platformFile in result.files) {
        if (platformFile.path != null) {
          files.add(File(platformFile.path!));
        }
      }

      if (files.isEmpty) {
        return Result.failure(
          FileSystemException('No valid files selected'),
        );
      }

      return Result.success(files);
    } catch (e) {
      return Result.failure(
        FileSystemException(
          'Failed to pick documents',
          originalError: e,
        ),
      );
    }
  }
}

