import 'package:flutter/material.dart';
import 'package:parkgisa_board_two/ui/board/edit/edit_board_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BoardOverlay extends StatefulWidget {
  const BoardOverlay({
    super.key,
    required this.date,
    required this.location,
    required this.workType,
    required this.description,
    this.customFields = const {},
  });

  final String date;
  final String location;
  final String workType;
  final String description;
  final Map<String, String> customFields;

  @override
  State<BoardOverlay> createState() => _BoardOverlayState();
}

class _BoardOverlayState extends State<BoardOverlay> {
  double overlayOpacity = 1.0;
  List<BoardField> boardFields = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 투명도 설정 불러오기
    setState(() {
      overlayOpacity = prefs.getDouble('overlay_opacity') ?? 1.0;
    });
    
    // 보드판 필드 불러오기
    final fieldsJson = prefs.getString('board_fields');
    if (fieldsJson != null) {
      setState(() {
        boardFields = (jsonDecode(fieldsJson) as List)
            .map((e) => BoardField.fromJson(e))
            .toList();
      });
    } else {
      // 기본 필드
      setState(() {
        boardFields = [
          BoardField(id: '1', label: '공사명', isRequired: true),
          BoardField(id: '2', label: '공 종', isRequired: true),
          BoardField(id: '3', label: '위 치', isRequired: true),
          BoardField(id: '4', label: '내 용', isRequired: true),
          BoardField(id: '5', label: '일 자', isRequired: true, isReadOnly: true),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: overlayOpacity),
        border: Border.all(color: Colors.black87, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildFieldRows(),
        ),
      ),
    );
  }

  List<Widget> _buildFieldRows() {
    final List<Widget> rows = [];
    
    // 설정된 필드들을 순서대로 표시
    for (int i = 0; i < boardFields.length; i++) {
      final field = boardFields[i];
      String? value;
      
      // 필드 ID에 따른 값 매핑
      switch (field.label) {
        case '공사명':
          value = widget.workType;
          break;
        case '공 종':
          value = widget.location;
          break;
        case '위 치':
          value = widget.description;
          break;
        case '내 용':
          value = ''; // 내용은 보드판 오버레이에 표시하지 않음
          break;
        case '일 자':
          value = widget.date;
          break;
        default:
          // 커스텀 필드
          value = widget.customFields[field.label] ?? '';
      }
      
      if (value.isNotEmpty) {
        if (rows.isNotEmpty) {
          rows.add(const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black87,
          ));
        }
        
        rows.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    field.label,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    
    return rows.isEmpty
        ? [const Text('데이터 없음', style: TextStyle(color: Colors.black87))]
        : rows;
  }
}
