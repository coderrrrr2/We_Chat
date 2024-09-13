import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppTextField extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final int? maxLines;
  final bool isGradientBorder;
  final BorderRadius? borderRadius;
  final String? header;
  final TextStyle? hintStyle;
  final double headerFontSize;
  final String hintText;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final FontWeight? headerFontWeight;
  final Color? fillColor;
  final Color? borderColor;
  final bool isReadOnly;
  final VoidCallback? ontap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText; // New property for obscure text

  const AppTextField({
    super.key,
    this.isGradientBorder = false,
    this.maxLines,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0),
    this.header,
    this.borderRadius,
    this.keyboardType,
    this.headerFontSize = 17.0,
    this.hintStyle,
    this.hintText = '',
    this.suffixWidget,
    this.prefixWidget,
    this.headerFontWeight,
    this.fillColor,
    this.isReadOnly = false,
    this.ontap,
    this.validator,
    required this.controller,
    this.obscureText = false, // Initialize obscure text
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.header != null) ...[
            Text(
              widget.header!,
              style: TextStyle(
                fontSize: widget.headerFontSize,
                fontWeight: widget.headerFontWeight ?? FontWeight.w600,
              ),
            ),
            addHeight(13),
          ],
          TextFormField(
            onTap: widget.ontap,
            readOnly: widget.isReadOnly,
            validator: widget.validator,
            maxLines: _obscureText ? 1 : widget.maxLines,
            minLines: null,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            style: const TextStyle(color: blackColor),
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixWidget,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: lightGrey,
                      ),
                      onPressed: _toggleObscureText,
                    )
                  : widget.suffixWidget,
              hintStyle: widget.hintStyle ??
                  const TextStyle(color: lightGrey, fontSize: 18),
              fillColor: widget.fillColor ?? whiteColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ?? extraLightGreyColor),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
              ),
            ),
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
