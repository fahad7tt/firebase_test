import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // You must run 'flutterfire configure' to generate firebase_options.dart
    // For now, we attempt to initialize. If it fails, check instructions.
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
    debugPrint("Ensure you have run 'flutterfire configure' and added firebase_options.dart");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mimo - Tasks & Categories',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF637DFF),
          primary: const Color(0xFF637DFF),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
