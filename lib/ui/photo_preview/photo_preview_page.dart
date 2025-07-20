import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parkgisa_board_two/core/utils/image_saver.dart';
import 'package:parkgisa_board_two/core/utils/permissions_handler.dart';
import 'package:parkgisa_board_two/data/database/app_database.dart';
import 'package:parkgisa_board_two/ui/photo_preview/components/board_overlay.dart';
import 'package:provider/provider.dart';

class PhotoPreviewPage extends HookWidget {
  const PhotoPreviewPage({
    super.key,
    required this.imagePath,
    this.initialDate,
    this.initialLocation,
    this.initialWorkType,
    this.initialDescription,
  });

  final String imagePath;
  final DateTime? initialDate;
  final String? initialLocation;
  final String? initialWorkType;
  final String? initialDescription;

  @override
  Widget build(BuildContext context) {
    final locationController = useTextEditingController(
      text: initialLocation ?? '',
    );
    final workTypeController = useTextEditingController(
      text: initialWorkType ?? '',
    );
    final descriptionController = useTextEditingController(
      text: initialDescription ?? '',
    );

    final selectedDate = useState(initialDate ?? DateTime.now());
    final isSaving = useState(false);
    
    // Camera related states
    final controller = useState<CameraController?>(null);
    final cameras = useState<List<CameraDescription>?>(null);
    final isInitialized = useState(false);
    final isTakingPicture = useState(false);
    final capturedImagePath = useState<String?>(imagePath.isEmpty ? null : imagePath);
    final showCamera = useState(imagePath.isEmpty);

    Future<void> selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
      }
    }

    Future<void> savePhoto() async {
      if (isSaving.value) return;

      isSaving.value = true;

      try {
        final db = Provider.of<AppDatabase>(context, listen: false);

        final boardInfo = {
          'date': DateFormat('yyyy-MM-dd').format(selectedDate.value),
          'location': locationController.text,
          'workType': workTypeController.text,
          'description': descriptionController.text,
        };

        if (capturedImagePath.value == null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('사진을 먼저 촬영해주세요.')),
            );
          }
          return;
        }

        final savedImagePath = await ImageSaver.saveImageWithBoard(
          originalImagePath: capturedImagePath.value!,
          boardInfo: boardInfo,
        );

        if (locationController.text.isNotEmpty) {
          await db.insertLocation(locationController.text);
        }
        if (workTypeController.text.isNotEmpty) {
          await db.insertWorkType(workTypeController.text);
        }

        final photoInfo = PhotoInfosCompanion(
          imagePath: drift.Value(savedImagePath),
          capturedAt: drift.Value(selectedDate.value),
          location: drift.Value(
            locationController.text.isEmpty ? null : locationController.text,
          ),
          workType: drift.Value(
            workTypeController.text.isEmpty ? null : workTypeController.text,
          ),
          description: drift.Value(
            descriptionController.text.isEmpty
                ? null
                : descriptionController.text,
          ),
          customFields: drift.Value(jsonEncode(boardInfo)),
        );

        await db.insertPhoto(photoInfo);

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('사진이 저장되었습니다.')));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } catch (e) {
        // 사진 저장 오류 처리
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('사진 저장 중 오류가 발생했습니다: $e')));
        }
      } finally {
        isSaving.value = false;
      }
    }

    Future<void> initializeCamera() async {
      final hasPermission = await PermissionsHandler.requestCameraPermission();
      if (!hasPermission) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('카메라 권한이 필요합니다.')),
          );
        }
        return;
      }

      try {
        cameras.value = await availableCameras();
        if (cameras.value!.isNotEmpty) {
          controller.value = CameraController(
            cameras.value![0],
            ResolutionPreset.high,
            enableAudio: false,
          );

          await controller.value!.initialize();
          isInitialized.value = true;
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('카메라 초기화 오류: $e')),
          );
        }
      }
    }

    Future<void> takePicture() async {
      if (controller.value == null || !controller.value!.value.isInitialized) {
        return;
      }

      if (isTakingPicture.value) return;

      try {
        isTakingPicture.value = true;
        final XFile photo = await controller.value!.takePicture();
        capturedImagePath.value = photo.path;
        showCamera.value = false;
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('사진 촬영 오류: $e')),
          );
        }
      } finally {
        isTakingPicture.value = false;
      }
    }

    Future<void> pickFromGallery() async {
      final ImagePicker picker = ImagePicker();
      try {
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          capturedImagePath.value = image.path;
          showCamera.value = false;
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('사진 선택 오류: $e')),
          );
        }
      }
    }

    Future<void> retakePhoto() async {
      capturedImagePath.value = null;
      showCamera.value = true;
      await initializeCamera();
    }

    useEffect(() {
      if (imagePath.isEmpty) {
        initializeCamera();
      }
      return () {
        controller.value?.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(showCamera.value ? '사진 촬영' : '사진 미리보기'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (capturedImagePath.value != null && !showCamera.value)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: retakePhoto,
              tooltip: '다시 촬영',
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  if (showCamera.value && controller.value != null && isInitialized.value)
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CameraPreview(controller.value!),
                    )
                  else if (capturedImagePath.value != null)
                    Image.file(
                      File(capturedImagePath.value!),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BoardOverlay(
                      date: DateFormat('yyyy-MM-dd').format(selectedDate.value),
                      location: locationController.text,
                      workType: workTypeController.text,
                      description: descriptionController.text,
                    ),
                  ),
                  if (showCamera.value)
                    Positioned(
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: 'gallery',
                            onPressed: pickFromGallery,
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.photo_library,
                              color: Colors.black87,
                            ),
                          ),
                          FloatingActionButton.large(
                            heroTag: 'capture',
                            onPressed: isTakingPicture.value ? null : takePicture,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              size: 36,
                              color: isTakingPicture.value
                                  ? Colors.grey
                                  : Colors.black87,
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: 'switch',
                            onPressed: () async {
                              if (cameras.value != null && cameras.value!.length > 1) {
                                final currentIndex = cameras.value!.indexOf(
                                  controller.value!.description,
                                );
                                final newIndex = (currentIndex + 1) % cameras.value!.length;
                                
                                await controller.value?.dispose();
                                controller.value = CameraController(
                                  cameras.value![newIndex],
                                  ResolutionPreset.high,
                                  enableAudio: false,
                                );
                                await controller.value!.initialize();
                              }
                            },
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(
                      DateFormat('yyyy년 MM월 dd일').format(selectedDate.value),
                    ),
                    onTap: selectDate,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: workTypeController,
                    decoration: const InputDecoration(
                      labelText: '공종',
                      prefixIcon: Icon(Icons.work),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: '설명',
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (capturedImagePath.value != null)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: retakePhoto,
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                            ),
                            child: const Text('다시 촬영'),
                          ),
                        ),
                      if (capturedImagePath.value != null) const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isSaving.value ? null : savePhoto,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 48),
                          ),
                          child: isSaving.value
                              ? const CircularProgressIndicator()
                              : Text(capturedImagePath.value != null ? '저장' : '사진 촬영'),
                        ),
                      ),
                    ],
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
