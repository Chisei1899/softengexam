import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const IlocoListoApp());
}

class IlocoListoApp extends StatelessWidget {
  const IlocoListoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iloco Listo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB71C1C)),
        useMaterial3: true,
        fontFamily: 'sans-serif',
      ),
      home: const LoginScreen(),
    );
  }
}