import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:parkgisa_board_two/data/database/app_database.dart';
import 'package:provider/provider.dart';

class GalleryPage extends HookWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 4);
    final selectedFilter = useState('');
    final db = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('사진 갤러리'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: '전체'),
            Tab(text: '날짜별'),
            Tab(text: '위치별'),
            Tab(text: '공종별'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildAllPhotosView(db),
          _buildFilteredView(db, 'date', selectedFilter),
          _buildFilteredView(db, 'location', selectedFilter),
          _buildFilteredView(db, 'workType', selectedFilter),
        ],
      ),
    );
  }

  Widget _buildAllPhotosView(AppDatabase db) {
    return FutureBuilder<List<PhotoInfo>>(
      future: db.getAllPhotos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('아직 촬영한 사진이 없습니다.'));
        }

        return _buildPhotoGrid(snapshot.data!);
      },
    );
  }

  Widget _buildFilteredView(AppDatabase db, String filterType, ValueNotifier<String> selectedFilter) {
    return Column(
      children: [
        _buildFilterChips(db, filterType, selectedFilter),
        Expanded(
          child: selectedFilter.value.isEmpty
              ? const Center(child: Text('필터를 선택하세요'))
              : FutureBuilder<List<PhotoInfo>>(
                  future: _getFilteredPhotos(db, filterType, selectedFilter.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('해당 조건의 사진이 없습니다.'));
                    }

                    return _buildPhotoGrid(snapshot.data!);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(AppDatabase db, String filterType, ValueNotifier<String> selectedFilter) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: FutureBuilder<List<String>>(
        future: _getFilterOptions(db, filterType),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final option = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: FilterChip(
                  label: Text(option),
                  selected: selectedFilter.value == option,
                  onSelected: (selected) {
                    selectedFilter.value = selected ? option : '';
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> _getFilterOptions(
    AppDatabase db,
    String filterType,
  ) async {
    final photos = await db.getAllPhotos();
    final Set<String> options = {};

    for (final photo in photos) {
      switch (filterType) {
        case 'date':
          options.add(DateFormat('yyyy-MM-dd').format(photo.capturedAt));
          break;
        case 'location':
          if (photo.location != null && photo.location!.isNotEmpty) {
            options.add(photo.location!);
          }
          break;
        case 'workType':
          if (photo.workType != null && photo.workType!.isNotEmpty) {
            options.add(photo.workType!);
          }
          break;
      }
    }

    return options.toList()..sort();
  }

  Future<List<PhotoInfo>> _getFilteredPhotos(
    AppDatabase db,
    String filterType,
    String value,
  ) async {
    switch (filterType) {
      case 'date':
        final date = DateFormat('yyyy-MM-dd').parse(value);
        return db.getPhotosByDate(date);
      case 'location':
        return db.getPhotosByLocation(value);
      case 'workType':
        return db.getPhotosByWorkType(value);
      default:
        return db.getAllPhotos();
    }
  }

  Widget _buildPhotoGrid(List<PhotoInfo> photos) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3 / 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return GestureDetector(
          onTap: () => _showPhotoDetail(context, photo),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(photo.imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    DateFormat('MM/dd').format(photo.capturedAt),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPhotoDetail(BuildContext context, PhotoInfo photo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.file(File(photo.imagePath), fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '날짜: ${DateFormat('yyyy-MM-dd').format(photo.capturedAt)}',
                  ),
                  if (photo.location != null) Text('위치: ${photo.location}'),
                  if (photo.workType != null) Text('공종: ${photo.workType}'),
                  if (photo.description != null)
                    Text('설명: ${photo.description}'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('닫기'),
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