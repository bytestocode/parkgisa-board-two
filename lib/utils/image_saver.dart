import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:photo_manager/photo_manager.dart';

class ImageSaver {
  static const String albumName = '박기사보드판';

  static Future<String> saveImageWithBoard({
    required String originalImagePath,
    required Map<String, String> boardInfo,
  }) async {
    try {
      final originalFile = File(originalImagePath);
      final originalBytes = await originalFile.readAsBytes();
      final originalImage = img.decodeImage(originalBytes);

      if (originalImage == null) {
        throw Exception('이미지를 디코딩할 수 없습니다.');
      }

      final boardImage = await _createBoardImage(boardInfo, originalImage.width);

      final combinedImage = img.Image(
        width: originalImage.width,
        height: originalImage.height + boardImage.height,
      );

      img.compositeImage(combinedImage, originalImage, dstY: 0);
      img.compositeImage(combinedImage, boardImage, dstY: originalImage.height);

      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'parkgisa_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = path.join(directory.path, fileName);

      final file = File(filePath);
      await file.writeAsBytes(img.encodeJpg(combinedImage, quality: 90));

      await _saveToGallery(file);

      return filePath;
    } catch (e) {
      throw Exception('이미지 저장 실패: $e');
    }
  }

  static Future<img.Image> _createBoardImage(Map<String, String> boardInfo, int width) async {
    final boardHeight = 150;
    final boardImage = img.Image(width: width, height: boardHeight);
    
    img.fill(boardImage, color: img.ColorRgb8(0, 0, 0));
    
    img.drawRect(
      boardImage,
      x1: 2,
      y1: 2,
      x2: width - 3,
      y2: boardHeight - 3,
      color: img.ColorRgb8(255, 255, 255),
      thickness: 2,
    );

    int yOffset = 20;
    const int fontSize = 20;
    const int lineHeight = 30;

    if (boardInfo['date'] != null && boardInfo['date']!.isNotEmpty) {
      final dateText = '날짜: ${boardInfo['date']}';
      _drawText(boardImage, dateText, 20, yOffset, fontSize);
      yOffset += lineHeight;
    }

    if (boardInfo['location'] != null && boardInfo['location']!.isNotEmpty) {
      final locationText = '위치: ${boardInfo['location']}';
      _drawText(boardImage, locationText, 20, yOffset, fontSize);
      yOffset += lineHeight;
    }

    if (boardInfo['workType'] != null && boardInfo['workType']!.isNotEmpty) {
      final workTypeText = '공종: ${boardInfo['workType']}';
      _drawText(boardImage, workTypeText, 20, yOffset, fontSize);
      yOffset += lineHeight;
    }

    if (boardInfo['description'] != null && boardInfo['description']!.isNotEmpty) {
      final descText = '설명: ${boardInfo['description']}';
      _drawText(boardImage, descText, 20, yOffset, fontSize);
    }

    return boardImage;
  }

  static void _drawText(img.Image image, String text, int x, int y, int size) {
    img.drawString(
      image,
      text,
      font: img.arial24,
      x: x,
      y: y,
      color: img.ColorRgb8(255, 255, 255),
    );
  }

  static Future<void> _saveToGallery(File imageFile) async {
    try {
      final result = await PhotoManager.requestPermissionExtend();
      if (!result.isAuth) {
        throw Exception('갤러리 접근 권한이 없습니다.');
      }

      await PhotoManager.editor.saveImageWithPath(
        imageFile.path,
        title: path.basename(imageFile.path),
      );

    } catch (e) {
      // 갤러리 저장 오류 처리
    }
  }
}