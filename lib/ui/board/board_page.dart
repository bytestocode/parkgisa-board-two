import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parkgisa_board_two/ui/board/edit/edit_board_page.dart';
import 'package:parkgisa_board_two/ui/photo_preview/photo_preview_page.dart';

class BoardPage extends HookWidget {
  const BoardPage({super.key});

  static const double outlineBorderWidth = 3;
  static const double innerBorderWidth = 2;

  @override
  Widget build(BuildContext context) {
    final companyController = useTextEditingController();
    final locationController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedDate = useState(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('보드판 작성'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditBoardPage()),
              );
            },
            tooltip: '보드판 편집',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black87,
                width: outlineBorderWidth,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: [
                  // 공사명 행
                  _buildTableRow(
                    label: '공사명',
                    child: _buildTextField(
                      controller: companyController,
                      hintText: '공사명을 입력하세요',
                    ),
                  ),
                  const _TableDivider(),

                  // 공종 행
                  _buildTableRow(
                    label: '공 종',
                    child: _buildTextField(
                      controller: locationController,
                      hintText: '공종을 입력하세요',
                    ),
                  ),
                  const _TableDivider(),

                  // 위치 행
                  _buildTableRow(
                    label: '위 치',
                    child: _buildTextField(
                      controller: descriptionController,
                      hintText: '위치를 입력하세요',
                    ),
                  ),
                  const _TableDivider(),

                  // 내용 행
                  _buildTableRow(
                    label: '내 용',
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '작업 내용을 입력하세요',
                        ),
                      ),
                    ),
                  ),
                  const _TableDivider(),

                  // 일자 행
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border(
                              right: BorderSide(
                                color: Colors.black87,
                                width: BoardPage.innerBorderWidth,
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '일 자',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              DateFormat(
                                'yyyy년 MM월 dd일 (E)',
                                'ko_KR',
                              ).format(selectedDate.value),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
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
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () async {
                    final imageXFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (imageXFile != null && context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoPreviewPage(
                            imagePath: imageXFile.path,
                            initialDate: selectedDate.value,
                            initialLocation: locationController.text,
                            initialWorkType: companyController.text,
                            initialDescription: descriptionController.text,
                            fromGallery: true,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('갤러리에서 선택'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoPreviewPage(
                          imagePath: '',
                          initialDate: selectedDate.value,
                          initialLocation: locationController.text,
                          initialWorkType: companyController.text,
                          initialDescription: descriptionController.text,
                          fromGallery: false,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('사진 촬영'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  static Widget _buildTableRow({required String label, required Widget child}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border(
                right: BorderSide(
                  color: Colors.black87,
                  width: BoardPage.innerBorderWidth,
                ),
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(padding: const EdgeInsets.all(8), child: child),
          ),
        ],
      ),
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}

class _TableDivider extends StatelessWidget {
  const _TableDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: BoardPage.innerBorderWidth,
      color: Colors.black87,
    );
  }
}
