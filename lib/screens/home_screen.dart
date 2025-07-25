import 'package:flutter/material.dart';
import 'package:parkgisa_board_two/screens/camera_screen.dart';
import 'package:parkgisa_board_two/screens/gallery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CameraScreen(),
    const GalleryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '촬영',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: '갤러리',
          ),
        ],
      ),
    );
  }
}