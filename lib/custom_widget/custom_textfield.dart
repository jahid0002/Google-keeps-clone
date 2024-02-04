import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String hintText;
  final double hintFontSize;
  final double styleSize;
  void Function(String)? onChanged;
  Widget? prefixIcon;
  CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintFontSize,
      required this.hintText,
      this.maxLines = 1,
      this.styleSize = 20,
      this.onChanged,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: maxLines,
      controller: controller,
      style: TextStyle(fontSize: styleSize, fontWeight: FontWeight.w700),
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.only(left: 0, right: 0),
        prefixIcon: prefixIcon,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: hintFontSize),
      ),
    );
  }
}
