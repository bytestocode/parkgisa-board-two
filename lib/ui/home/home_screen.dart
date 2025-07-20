import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.tableList),
            label: '보드판',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidImages),
            label: '갤러리',
          ),
          // BottomNavigationBarItem(
          //   icon: FaIcon(FontAwesomeIcons.solidFileImage),
          //   label: '사진대지',
          // ),
        ],
      ),
    );
  }
}
