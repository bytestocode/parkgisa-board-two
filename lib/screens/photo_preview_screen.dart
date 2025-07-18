import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import 'package:parkgisa_board_two/database/app_database.dart';
import 'package:parkgisa_board_two/widgets/board_overlay.dart';
import 'package:parkgisa_board_two/utils/image_saver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final String imagePath;
  final DateTime? initialDate;
  final String? initialLocation;
  final String? initialWorkType;
  final String? initialDescription;
  final Position? currentPosition;

  const PhotoPreviewScreen({
    super.key,
    required this.imagePath,
    this.initialDate,
    this.initialLocation,
    this.initialWorkType,
    this.initialDescription,
    this.currentPosition,
  });

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  Position? _currentPosition;
  bool _isLoadingLocation = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _locationController.text = widget.initialLocation ?? '';
    _workTypeController.text = widget.initialWorkType ?? '';
    _descriptionController.text = widget.initialDescription ?? '';
    _currentPosition = widget.currentPosition;
    
    if (_locationController.text.isEmpty) {
      _getCurrentLocation();
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

  Future<void> _savePhoto() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final db = Provider.of<AppDatabase>(context, listen: false);
      
      final boardInfo = {
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
        'location': _locationController.text,
        'workType': _workTypeController.text,
        'description': _descriptionController.text,
      };

      final savedImagePath = await ImageSaver.saveImageWithBoard(
        originalImagePath: widget.imagePath,
        boardInfo: boardInfo,
      );

      if (_locationController.text.isNotEmpty) {
        await db.insertLocation(_locationController.text);
      }
      if (_workTypeController.text.isNotEmpty) {
        await db.insertWorkType(_workTypeController.text);
      }

      final photoInfo = PhotoInfosCompanion(
        imagePath: drift.Value(savedImagePath),
        capturedAt: drift.Value(_selectedDate),
        location: drift.Value(_locationController.text.isEmpty ? null : _locationController.text),
        latitude: drift.Value(_currentPosition?.latitude),
        longitude: drift.Value(_currentPosition?.longitude),
        workType: drift.Value(_workTypeController.text.isEmpty ? null : _workTypeController.text),
        description: drift.Value(_descriptionController.text.isEmpty ? null : _descriptionController.text),
        customFields: drift.Value(jsonEncode(boardInfo)),
      );

      await db.insertPhoto(photoInfo);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사진이 저장되었습니다.')),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      // 사진 저장 오류 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('사진 저장 중 오류가 발생했습니다: $e')),
        );
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _workTypeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
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
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _workTypeController,
                    decoration: const InputDecoration(
                      labelText: '공종',
                      prefixIcon: Icon(Icons.work),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: '설명',
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _savePhoto,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: _isSaving
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