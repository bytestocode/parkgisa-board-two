import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBoardPage extends HookWidget {
  const EditBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 보드판 필드 리스트
    final boardFields = useState<List<BoardField>>([
      BoardField(id: '1', label: '공사명', isRequired: true),
      BoardField(id: '2', label: '공 종', isRequired: true),
      BoardField(id: '3', label: '위 치', isRequired: true),
      BoardField(id: '4', label: '내 용', isRequired: true),
      BoardField(id: '5', label: '일 자', isRequired: true, isReadOnly: true),
    ]);

    // 오버레이 설정
    final overlayPosition = useState<OverlayPosition>(
      OverlayPosition.bottomRight,
    );
    final overlayOpacity = useState<double>(1.0);

    // SharedPreferences에서 설정 불러오기
    useEffect(() {
      Future<void> loadSettings() async {
        final prefs = await SharedPreferences.getInstance();

        // 보드판 필드 불러오기
        final fieldsJson = prefs.getString('board_fields');
        if (fieldsJson != null) {
          final fieldsList = (jsonDecode(fieldsJson) as List)
              .map((e) => BoardField.fromJson(e))
              .toList();
          boardFields.value = fieldsList;
        }

        // 오버레이 설정 불러오기
        final positionIndex = prefs.getInt('overlay_position') ?? 3;
        overlayPosition.value = OverlayPosition.values[positionIndex];

        final opacity = prefs.getDouble('overlay_opacity') ?? 1.0;
        overlayOpacity.value = opacity;
      }

      loadSettings();
      return null;
    }, []);

    // 설정 저장
    Future<void> saveSettings() async {
      final prefs = await SharedPreferences.getInstance();

      // 보드판 필드 저장
      final fieldsJson = jsonEncode(
        boardFields.value.map((e) => e.toJson()).toList(),
      );
      await prefs.setString('board_fields', fieldsJson);

      // 오버레이 설정 저장
      await prefs.setInt('overlay_position', overlayPosition.value.index);
      await prefs.setDouble('overlay_opacity', overlayOpacity.value);

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('설정이 저장되었습니다.')));
        Navigator.pop(context);
      }
    }

    // 필드 추가
    void addField() {
      showDialog(
        context: context,
        builder: (context) {
          final controller = TextEditingController();
          return AlertDialog(
            title: const Text('필드 추가'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '필드명',
                hintText: '예: 작업자, 날씨 등',
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    boardFields.value = [
                      ...boardFields.value,
                      BoardField(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        label: controller.text,
                        isRequired: false,
                      ),
                    ];
                    Navigator.pop(context);
                  }
                },
                child: const Text('추가'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('보드판 편집'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [TextButton(onPressed: saveSettings, child: const Text('저장'))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 보드판 필드 관리
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '보드판 필드',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: addField,
                        icon: const Icon(Icons.add),
                        tooltip: '필드 추가',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '필수 필드는 삭제할 수 없습니다.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ReorderableListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final fields = List<BoardField>.from(boardFields.value);
                      final field = fields.removeAt(oldIndex);
                      fields.insert(newIndex, field);
                      boardFields.value = fields;
                    },
                    children: boardFields.value.map((field) {
                      return ListTile(
                        key: ValueKey(field.id),
                        leading: Icon(
                          Icons.drag_handle,
                          color: Colors.grey.shade400,
                        ),
                        title: Text(field.label),
                        subtitle: field.isRequired
                            ? const Text('필수', style: TextStyle(fontSize: 12))
                            : null,
                        trailing: field.isRequired
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  boardFields.value = boardFields.value
                                      .where((f) => f.id != field.id)
                                      .toList();
                                },
                              ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // 오버레이 위치 설정
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '오버레이 위치',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2,
                    children: [
                      _buildPositionButton(
                        label: '좌측 상단',
                        position: OverlayPosition.topLeft,
                        currentPosition: overlayPosition.value,
                        onTap: () =>
                            overlayPosition.value = OverlayPosition.topLeft,
                      ),
                      _buildPositionButton(
                        label: '우측 상단',
                        position: OverlayPosition.topRight,
                        currentPosition: overlayPosition.value,
                        onTap: () =>
                            overlayPosition.value = OverlayPosition.topRight,
                      ),
                      _buildPositionButton(
                        label: '좌측 하단',
                        position: OverlayPosition.bottomLeft,
                        currentPosition: overlayPosition.value,
                        onTap: () =>
                            overlayPosition.value = OverlayPosition.bottomLeft,
                      ),
                      _buildPositionButton(
                        label: '우측 하단',
                        position: OverlayPosition.bottomRight,
                        currentPosition: overlayPosition.value,
                        onTap: () =>
                            overlayPosition.value = OverlayPosition.bottomRight,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 투명도 설정
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '배경 투명도',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${(overlayOpacity.value * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: overlayOpacity.value,
                    min: 0.3,
                    max: 1.0,
                    divisions: 7,
                    label: '${(overlayOpacity.value * 100).round()}%',
                    onChanged: (value) {
                      overlayOpacity.value = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  // 미리보기
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: overlayOpacity.value,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black87),
                        ),
                        child: const Text(
                          '보드판 미리보기',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionButton({
    required String label,
    required OverlayPosition position,
    required OverlayPosition currentPosition,
    required VoidCallback onTap,
  }) {
    final isSelected = position == currentPosition;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// 보드판 필드 모델
class BoardField {
  final String id;
  final String label;
  final bool isRequired;
  final bool isReadOnly;

  BoardField({
    required this.id,
    required this.label,
    this.isRequired = false,
    this.isReadOnly = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'isRequired': isRequired,
    'isReadOnly': isReadOnly,
  };

  factory BoardField.fromJson(Map<String, dynamic> json) => BoardField(
    id: json['id'],
    label: json['label'],
    isRequired: json['isRequired'] ?? false,
    isReadOnly: json['isReadOnly'] ?? false,
  );
}

// 오버레이 위치 enum
enum OverlayPosition { topLeft, topRight, bottomLeft, bottomRight }
