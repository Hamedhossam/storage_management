import 'package:flutter/material.dart';
import 'package:storage/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "NotoKufiArabic",
        brightness: Brightness.dark, // Set dark theme settings
        // You can customize other dark theme properties here
      ),
      darkTheme: ThemeData(
        fontFamily: "NotoKufiArabic",
        brightness:
            Brightness.dark, // Ensure dark theme settings are consistent
      ),
      themeMode: ThemeMode.dark, // Always use dark mode
      title: 'Storage App',
      home: const HomeScreen(),
    );
  }
}
