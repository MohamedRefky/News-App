import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.hintStyle,
    this.validator,
    this.suffix,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextStyle? hintStyle;
  final Function(String)? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xFF141414))),
        SizedBox(height: 8),
        TextFormField(
          cursorColor: Color(0xFF141414),
          controller: controller,
          validator: validator != null
              ? (String? value) => validator!(value!)
              : null,
          maxLines: 1,
          style: TextStyle(fontSize: 16, color: Color(0xFF141414)),
          decoration: InputDecoration(
            hintStyle: hintStyle,
            hintText: hintText,
            suffix: suffix,
          ),
        ),
      ],
    );
  }
}
