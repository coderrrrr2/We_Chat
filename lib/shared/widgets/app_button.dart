import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final String text;
  final Color? backgroundColor;
  final Size? buttonSize;
  final double? textSize;
  final Color? textColor;
  final Widget? content;
  const AppButton(
      {super.key,
      required this.onPressed,
      this.text = "",
      this.content,
      this.backgroundColor,
      this.isEnabled = true,
      this.textColor,
      this.buttonSize,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: backgroundColor ?? Colors.black,
          minimumSize: buttonSize ?? const Size(600, 70)),
      child: text.isNotEmpty
          ? Text(
              text,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: textSize ?? 19,
                  fontWeight: FontWeight.bold),
            )
          : content,
    );
  }
}
