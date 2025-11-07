import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import '../../core/error/exceptions.dart';
import '../../core/error/result.dart';

/// Service for generating PDFs from images
class PDFGeneratorService {
  /// Create PDF from multiple images
  Future<Result<File>> createPdfFromImages(
    List<File> imageFiles, {
    String? fileName,
  }) async {
    try {
      final pdf = pw.Document();

      for (final imageFile in imageFiles) {
        // Read and process image
        final imageBytes = await imageFile.readAsBytes();
        final image = img.decodeImage(imageBytes);

        if (image == null) {
          return Result.failure(
            FileSystemException('Failed to decode image: ${imageFile.path}'),
          );
        }

        // Optimize image (resize if too large)
        final optimized = _optimizeImage(image);
        final pngBytes = Uint8List.fromList(img.encodePng(optimized));

        // Add image to PDF page
        final pdfImage = pw.MemoryImage(pngBytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Center(
                child: pw.Image(pdfImage, fit: pw.BoxFit.contain),
              );
            },
          ),
        );
      }

      // Save PDF to temp directory
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final pdfFileName = fileName ?? 'document_$timestamp.pdf';
      final pdfFile = File('${tempDir.path}/$pdfFileName');

      await pdfFile.writeAsBytes(await pdf.save());

      return Result.success(pdfFile);
    } catch (e) {
      return Result.failure(
        FileSystemException(
          'Failed to create PDF from images',
          originalError: e,
        ),
      );
    }
  }

  /// Optimize image for PDF (resize if needed, compress)
  img.Image _optimizeImage(img.Image image) {
    const maxWidth = 1920;
    const maxHeight = 1920;

    if (image.width <= maxWidth && image.height <= maxHeight) {
      return image;
    }

    // Calculate new dimensions maintaining aspect ratio
    double ratio = image.width / image.height;
    int newWidth = maxWidth;
    int newHeight = (newWidth / ratio).round();

    if (newHeight > maxHeight) {
      newHeight = maxHeight;
      newWidth = (newHeight * ratio).round();
    }

    return img.copyResize(
      image,
      width: newWidth,
      height: newHeight,
      interpolation: img.Interpolation.linear,
    );
  }

  /// Generate thumbnail from first page of PDF or image
  Future<Result<File>> generateThumbnail(File sourceFile) async {
    try {
      final bytes = await sourceFile.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) {
        return Result.failure(
          FileSystemException('Failed to decode image for thumbnail'),
        );
      }

      // Create thumbnail (200x200)
      final thumbnail = img.copyResize(
        image,
        width: 200,
        height: 200,
        interpolation: img.Interpolation.linear,
      );

      // Save thumbnail
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final thumbnailFile = File('${tempDir.path}/thumb_$timestamp.jpg');

      final jpegBytes = img.encodeJpg(thumbnail, quality: 85);
      await thumbnailFile.writeAsBytes(jpegBytes);

      return Result.success(thumbnailFile);
    } catch (e) {
      return Result.failure(
        FileSystemException(
          'Failed to generate thumbnail',
          originalError: e,
        ),
      );
    }
  }

  /// Get file size in bytes
  Future<int> getFileSize(File file) async {
    return await file.length();
  }

  /// Get MIME type from file extension
  String getMimeType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        return 'application/octet-stream';
    }
  }
}

