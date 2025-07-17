import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parkgisa_board_two/database/app_database.dart';
import 'package:parkgisa_board_two/screens/home_screen.dart';

void main() {
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      dispose: (context, db) => db.close(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '박기사보드판',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Pretendard',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}