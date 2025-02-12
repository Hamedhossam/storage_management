import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storage/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.textInputType,
      this.suffixIcon,
      this.prefixIcon,
      this.onSaved,
      this.obscureText = false,
      this.controller,
      this.inputFormatters,
      this.labelText});
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLines: obscureText ? 1 : null, // Allows unlimited lines
        minLines: 1, // Starts with 1 line
        controller: controller,
        style: labelStyle.copyWith(fontSize: 20),
        obscureText: obscureText,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: labelStyle.copyWith(fontSize: 20),
          hintText: hintText,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromARGB(26, 0, 0, 0),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: kLightColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xFFE6E9E9),
      ),
    );
  }
}
