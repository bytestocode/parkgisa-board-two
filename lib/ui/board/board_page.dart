import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:parkgisa_board_two/ui/photo_preview/photo_preview_page.dart';

class BoardPage extends HookWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = useTextEditingController();
    final workTypeController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState(DateTime.now());
    final currentPosition = useState<Position?>(null);
    final isLoadingLocation = useState(false);


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

    useEffect(() {
      getCurrentLocation();
      return null;
    }, []);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '보드판 정보 입력',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '보드판 정보를 입력하고 사진을 촬영해주세요',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: InkWell(
                onTap: selectDate,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        DateFormat('yyyy년 MM월 dd일').format(selectedDate.value),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: '위치',
                prefixIcon: const Icon(Icons.location_on),
                suffixIcon: isLoadingLocation.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.my_location),
                        onPressed: getCurrentLocation,
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: workTypeController,
              decoration: InputDecoration(
                labelText: '공종',
                prefixIcon: const Icon(Icons.work),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: '설명',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoPreviewPage(
                imagePath: '',
                initialDate: selectedDate.value,
                initialLocation: locationController.text,
                initialWorkType: workTypeController.text,
                initialDescription: descriptionController.text,
                currentPosition: currentPosition.value,
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: const Text('사진 촬영', style: TextStyle(fontSize: 16)),
        icon: const FaIcon(FontAwesomeIcons.camera, size: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
