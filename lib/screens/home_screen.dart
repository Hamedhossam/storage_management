import 'package:flutter/material.dart';
import 'package:storage/constants.dart';
import 'package:storage/screens/export_screen.dart';
import 'package:storage/screens/imports_screen.dart';
import 'package:storage/screens/storge_screen.dart';
import 'package:storage/widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // List<NavigationRailDestination> navigationDestinations = [
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 1),
          Container(
            width: 230,
            height: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: kLightColor, width: 2)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Row(
                children: [
                  const Text(
                    'إدارة المخازن  ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/database_957635.png'),
                  )
                ],
              ),
            ),
          ),
          const Spacer(flex: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryWidget(
                tittle: 'الصادرات',
                icon: 'assets/images/exports.png',
                screen: ExportScreen(),
              ),
              CategoryWidget(
                tittle: 'الواردات',
                icon: 'assets/images/imports.png',
                screen: ImportsScreen(),
              ),
              CategoryWidget(
                tittle: 'المخزن',
                icon: 'assets/images/storage.png',
                screen: StorgeScreen(),
              ),
            ],
          ),
          const Spacer(flex: 8),
        ],
      ),
    );
  }
}
