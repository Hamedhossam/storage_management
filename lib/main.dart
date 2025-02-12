import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:storage/models/product_model.dart';
import 'package:storage/screens/login_screen.dart';

void main() async {
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.initFlutter("D:/System/Database");
  await Hive.openBox<ProductModel>("products_box");
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
      home: const LoginScreen(),
    );
  }
}
