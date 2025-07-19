import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:parkgisa_board_two/ui/photo_preview/components/board_overlay.dart';
import 'package:parkgisa_board_two/ui/photo_preview/photo_preview_page.dart';
import 'package:parkgisa_board_two/core/utils/permissions_handler.dart';

class BoardPage extends HookWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useState<CameraController?>(null);
    final cameras = useState<List<CameraDescription>?>(null);
    final isInitialized = useState(false);
    final isTakingPicture = useState(false);

    final locationController = useTextEditingController();
    final workTypeController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState(DateTime.now());
    final currentPosition = useState<Position?>(null);
    final isLoadingLocation = useState(false);
    final showBoardInputs = useState(false);

    Future<void> initializeCamera() async {
      final hasPermission = await PermissionsHandler.requestCameraPermission();
      if (!hasPermission) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('카메라 권한이 필요합니다.')));
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
        // 카메라 초기화 오류 처리
      }
    }

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

        currentPosition.value = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );

        if (currentPosition.value != null) {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.value!.latitude,
            currentPosition.value!.longitude,
          );

          if (placemarks.isNotEmpty) {
            final place = placemarks.first;
            final address = '${place.locality ?? ''} ${place.name ?? ''}'.trim();
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

    Future<void> takePicture() async {
      if (controller.value == null ||
          !controller.value!.value.isInitialized ||
          isTakingPicture.value) {
        return;
      }

      isTakingPicture.value = true;

      try {
        final image = await controller.value!.takePicture();

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoPreviewPage(
                imagePath: image.path,
                initialDate: selectedDate.value,
                initialLocation: locationController.text,
                initialWorkType: workTypeController.text,
                initialDescription: descriptionController.text,
                currentPosition: currentPosition.value,
              ),
            ),
          );
        }
      } catch (e) {
        // 사진 촬영 오류 처리
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('사진 촬영 중 오류가 발생했습니다: $e')));
        }
      } finally {
        isTakingPicture.value = false;
      }
    }

    useEffect(() {
      initializeCamera();
      getCurrentLocation();
      return () {
        controller.value?.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('보드판 설정'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: controller.value != null && isInitialized.value
                      ? CameraPreview(controller.value!)
                      : const Center(child: CircularProgressIndicator()),
                ),
                if (showBoardInputs.value)
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
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ExpansionTile(
                  title: const Text('보드판 정보 입력'),
                  initiallyExpanded: showBoardInputs.value,
                  onExpansionChanged: (expanded) {
                    showBoardInputs.value = expanded;
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
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
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.my_location),
                                      onPressed: getCurrentLocation,
                                    ),
                            ),
                            onChanged: (_) {},
                          ),
                          TextField(
                            controller: workTypeController,
                            decoration: const InputDecoration(
                              labelText: '공종',
                              prefixIcon: Icon(Icons.work),
                            ),
                            onChanged: (_) {},
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: '설명',
                              prefixIcon: Icon(Icons.description),
                            ),
                            maxLines: 2,
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FloatingActionButton(
                    onPressed: isTakingPicture.value ? null : takePicture,
                    backgroundColor: isTakingPicture.value
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}