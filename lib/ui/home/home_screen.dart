import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:parkgisa_board_two/ui/board/board_page.dart';
import 'package:parkgisa_board_two/ui/gallery/gallery_page.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    final List<Widget> pages = [const BoardPage(), const GalleryPage()];

    return Scaffold(
      body: pages[selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: '촬영'),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: '갤러리',
          ),
        ],
      ),
    );
  }
}