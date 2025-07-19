import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:parkgisa_board_two/core/utils/image_saver.dart';
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
    this.currentPosition,
  });

  final String imagePath;
  final DateTime? initialDate;
  final String? initialLocation;
  final String? initialWorkType;
  final String? initialDescription;
  final Position? currentPosition;

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
    final currentPositionState = useState<Position?>(currentPosition);
    final isLoadingLocation = useState(false);
    final isSaving = useState(false);

    Future<void> getCurrentLocation() async {
      isLoadingLocation.value = true;

      try {
        final permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          final requestedPermission = await Geolocator.requestPermission();
          if (requestedPermission == LocationPermission.denied) {
            return;
          }
        }

        currentPositionState.value = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );

        if (currentPositionState.value != null) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPositionState.value!.latitude,
            currentPositionState.value!.longitude,
          );

          if (placemarks.isNotEmpty) {
            final place = placemarks.first;
            final address = '${place.locality ?? ''} ${place.name ?? ''}'
                .trim();
            locationController.text = address;
          }
        }
      } catch (e) {
        // 위치 정보 가져오기 오류 처리
      } finally {
        isLoadingLocation.value = false;
      }
    }

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

        final savedImagePath = await ImageSaver.saveImageWithBoard(
          originalImagePath: imagePath,
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
          latitude: drift.Value(currentPositionState.value?.latitude),
          longitude: drift.Value(currentPositionState.value?.longitude),
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

    useEffect(() {
      if (locationController.text.isEmpty) {
        getCurrentLocation();
      }
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('사진 미리보기'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.file(File(imagePath), fit: BoxFit.cover),
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
              ],
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
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: '위치',
                      prefixIcon: const Icon(Icons.location_on),
                      suffixIcon: isLoadingLocation.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : IconButton(
                              icon: const Icon(Icons.my_location),
                              onPressed: getCurrentLocation,
                            ),
                    ),
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
                  ElevatedButton(
                    onPressed: isSaving.value ? null : savePhoto,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: isSaving.value
                        ? const CircularProgressIndicator()
                        : const Text('저장'),
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
