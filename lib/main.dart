import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_wise_frontend/screens/home/home.dart';
import 'package:task_wise_frontend/screens/login/login_screen.dart' as login;
import 'package:task_wise_frontend/screens/login/sign_up_screen.dart' as signup;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Wise',
      home: HomePage(),
    );
  }
}
