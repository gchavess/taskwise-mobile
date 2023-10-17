import 'package:flutter/material.dart';
import 'package:task_wise_frontend/screens/home/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Task Wise',
      home: HomePage(),
    );
  }
}
