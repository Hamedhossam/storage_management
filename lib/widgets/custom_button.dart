import 'package:flutter/material.dart';
import 'package:storage/constants.dart';

// ignore: must_be_immutable
class CustomizedButtonWithBorder extends StatelessWidget {
  CustomizedButtonWithBorder({
    super.key,
    this.onTap,
    required this.tittle,
    required this.isLoading,
  });
  final void Function()? onTap;
  final String tittle;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : onTap,
      icon: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          border: Border.all(color: kLightColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: kLightColor,
              ))
            : Center(
                child: Text(
                  tittle,
                  style: const TextStyle(
                    color: kLightColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
