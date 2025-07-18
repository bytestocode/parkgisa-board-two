import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:parkgisa_board_two/screens/photo_preview_screen.dart';
import 'package:parkgisa_board_two/utils/permissions_handler.dart';
import 'package:parkgisa_board_two/widgets/board_overlay.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isTakingPicture = false;
  
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Position? _currentPosition;
  bool _isLoadingLocation = false;
  bool _showBoardInputs = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getCurrentLocation();
  }

  Future<void> _initializeCamera() async {
    final hasPermission = await PermissionsHandler.requestCameraPermission();
    if (!hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('카메라 권한이 필요합니다.')),
        );
      }
      return;
    }

    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _controller = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }
    } catch (e) {
      // 카메라 초기화 오류 처리
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requestedPermission = await Geolocator.requestPermission();
        if (requestedPermission == LocationPermission.denied) {
          return;
        }
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (_currentPosition != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final address = '${place.locality ?? ''} ${place.name ?? ''}'.trim();
          _locationController.text = address;
        }
      }
    } catch (e) {
      // 위치 정보 가져오기 오류 처리
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized || _isTakingPicture) {
      return;
    }

    setState(() {
      _isTakingPicture = true;
    });

    try {
      final image = await _controller!.takePicture();
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoPreviewScreen(
              imagePath: image.path,
              initialDate: _selectedDate,
              initialLocation: _locationController.text,
              initialWorkType: _workTypeController.text,
              initialDescription: _descriptionController.text,
              currentPosition: _currentPosition,
            ),
          ),
        );
      }
    } catch (e) {
      // 사진 촬영 오류 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('사진 촬영 중 오류가 발생했습니다: $e')),
        );
      }
    } finally {
      setState(() {
        _isTakingPicture = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _locationController.dispose();
    _workTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사진 촬영'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isInitialized
          ? Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: CameraPreview(_controller!),
                      ),
                      if (_showBoardInputs)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: BoardOverlay(
                            date: DateFormat('yyyy-MM-dd').format(_selectedDate),
                            location: _locationController.text,
                            workType: _workTypeController.text,
                            description: _descriptionController.text,
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
                        initiallyExpanded: _showBoardInputs,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _showBoardInputs = expanded;
                          });
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
                                  title: Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDate)),
                                  onTap: _selectDate,
                                ),
                                TextField(
                                  controller: _locationController,
                                  decoration: InputDecoration(
                                    labelText: '위치',
                                    prefixIcon: const Icon(Icons.location_on),
                                    suffixIcon: _isLoadingLocation
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          )
                                        : IconButton(
                                            icon: const Icon(Icons.my_location),
                                            onPressed: _getCurrentLocation,
                                          ),
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                                TextField(
                                  controller: _workTypeController,
                                  decoration: const InputDecoration(
                                    labelText: '공종',
                                    prefixIcon: Icon(Icons.work),
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                                TextField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    labelText: '설명',
                                    prefixIcon: Icon(Icons.description),
                                  ),
                                  maxLines: 2,
                                  onChanged: (_) => setState(() {}),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: FloatingActionButton(
                          onPressed: _isTakingPicture ? null : _takePicture,
                          backgroundColor: _isTakingPicture ? Colors.grey : Theme.of(context).colorScheme.primary,
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}