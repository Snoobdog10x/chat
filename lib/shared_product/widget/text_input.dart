import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hintText;
  final bool isPasswordField;
  final void Function(String value)? onTextChange;
  final TextEditingController? controller;
  const TextInput({
    super.key,
    required this.hintText,
    this.onTextChange,
    this.isPasswordField = false,
    this.controller,
  });

  @override
  State<TextInput> createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField && !isVisible,
      onChanged: widget.onTextChange,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        suffixIcon: widget.isPasswordField
            ? InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHover: (isHover) {},
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
