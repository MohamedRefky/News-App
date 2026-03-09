import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.hintStyle,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextStyle? hintStyle;
  final Function(String)? validator;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLines;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16, color: Color(0xFF141414)),
        ),
        SizedBox(height: 8),
        TextFormField(
          cursorColor: Color(0xFF141414),
          controller: widget.controller,
          validator: widget.validator != null
              ? (String? value) => widget.validator!(value!)
              : null,
          maxLines: widget.maxLines,
          obscureText: widget.obscureText && !_isVisible,
          style: TextStyle(fontSize: 16, color: Color(0xFF141414)),
          decoration: InputDecoration(
            hintStyle: widget.hintStyle,
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() => _isVisible = !_isVisible);
                    },
                    icon: Icon(
                      _isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
