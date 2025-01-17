import 'package:flutter/material.dart';

class MyEditText extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final IconData? icon;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color fillColor;
  final Color textColor;
  final Color hintColor;

  const MyEditText({
    Key? key,
    this.hintText,
    this.isPassword = false,
    required this.controller,
    this.icon,
    this.borderColor = Colors.orange,
    this.borderWidth = 1.5,
    this.borderRadius = 16.0,
    this.fillColor = Colors.black,
    this.textColor = Colors.white,
    this.hintColor = Colors.grey,
  }) : super(key: key);

  @override
  _MyEditTextState createState() => _MyEditTextState();
}

class _MyEditTextState extends State<MyEditText> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      style: TextStyle(
          color: widget.textColor, fontFamily: "MontserratBold", fontSize: 16),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintColor),
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.hintColor,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: widget.hintColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: widget.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth + 0.5,
          ),
        ),
      ),
    );
  }
}
