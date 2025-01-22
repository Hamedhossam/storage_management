import 'package:flutter/material.dart';
import 'package:storage/constants.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.tittle,
    required this.icon,
    required this.screen,
  });
  final String tittle;
  final String icon;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: kLightColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => screen));
              },
              hoverColor: kLightColor,
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 270,
                  width: 270,
                  child: Image.asset(icon),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              tittle,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
