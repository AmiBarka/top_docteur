import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomField extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomField({
    Key? key,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obscureText : false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(widget.label),
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: obscureText
                      ? const Icon(CupertinoIcons.eye_slash_fill)
                      : const Icon(CupertinoIcons.eye_fill),
                )
              : null,
        ),
      ),
    );
  }
}
