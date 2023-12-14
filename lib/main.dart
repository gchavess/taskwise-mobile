import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_wise_frontend/providers/app_state.dart'; // Importa diretamente
import 'package:task_wise_frontend/screens/login/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return ChangeNotifierProvider(
      create: (context) => AppProviderState(), // Use o nome correto aqui
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Wise',
        home: SplashScreen(),
      ),
    );
  }
}
